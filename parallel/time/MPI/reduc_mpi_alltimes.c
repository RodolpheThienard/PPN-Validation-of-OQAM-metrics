
#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

// Perform a reduction in minus
static double
reduc (const double *restrict a, const size_t size)
{

    double res = 0.0F;

    for (size_t i = 0; i < size; i++)
        res -= a[i];

    return res;
}

int
main (int argc, char *argv[])
{

    if (argc < 2 || argc > 3)
        return fprintf (stderr, "USAGE: %s [taille_vecteur] nb_iteration\n",
                        argv[0]),
               1;

    MPI_Init (&argc, &argv);

    // Start timer
    struct timespec begin, end;
    double mpiBegin;

    clock_gettime (CLOCK_MONOTONIC_RAW, &begin);
    mpiBegin = MPI_Wtime ();

    // Collect Comm information
    int mpiSize = 0;
    int mpiRank = 0;

    MPI_Comm_rank (MPI_COMM_WORLD, &mpiRank);
    MPI_Comm_size (MPI_COMM_WORLD, &mpiSize);

    const size_t vecSize
        = (argc == 2) ? 4 * 1024 : strtoul (argv[1], NULL, 10);
    const size_t nbIter = strtoul (argv[argc - 1], NULL, 10) / mpiSize;
    // Allocate and fill the tab to reduce
    double *a = (double *)aligned_alloc (32, vecSize * sizeof (double));

    for (size_t i = 0; i < vecSize; i++)
        a[i] = 0.1F * i;

    double res = 0.0F;

    // Make the reduction
    for (size_t i = 0; i < nbIter; i++)
        res = reduc (a, vecSize);

    free (a);

    double allRes = 0.0F;

    // Everyone get the final result
    MPI_Allreduce (&res, &allRes, 1, MPI_DOUBLE, MPI_SUM, MPI_COMM_WORLD);

    // No dead code
    printf ("%lf\n", allRes);

    // Compute elapsed time
    clock_gettime (CLOCK_MONOTONIC_RAW, &end);

    double elapsed = (double)(end.tv_sec - begin.tv_sec)
                     + (double)(end.tv_nsec - begin.tv_nsec) * 1e-9;
    double mpiElapsed = MPI_Wtime () - mpiBegin;

    // Write the measures
    char filename[32];
    memset (filename, '\0', 32);
    sprintf (filename, "%d.dat", getpid ());

    FILE *file;
    file = fopen (filename, "a");
    fprintf (file, "%3.9lf\t%3.9lf\n", elapsed, mpiElapsed);
    fclose (file);

    MPI_Finalize ();

    return 0;
}
