
#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Naive reduction with nested parallel region possible
static double
reduc (const double *restrict a, const size_t size)
{

    double res = 0.0F;

#pragma omp parallel for schedule(runtime) reduction(- : res)
    for (size_t i = 0; i < size; i++)
        res -= a[i];

    return res;
}

int
main (int argc, char *argv[])
{

    struct timespec begin, end;
    double ompBegin, ompElapsed;

    if (argc != 2 && argc != 3)
        return fprintf (stderr, "USAGE: %s [taille_vecteur] nb_iteration\n",
                        argv[0]),
               1;

    // Prise de la première mesure
    clock_gettime (CLOCK_MONOTONIC_RAW, &begin);
    ompBegin = omp_get_wtime ();

    const size_t vecSize
        = (argc == 2) ? 4 * 1024 : strtoul (argv[1], NULL, 10);
    const size_t nbIter = strtoul (argv[argc - 1], NULL, 10);

    double *a = (double *)aligned_alloc (32, vecSize * sizeof (double));

    int num_threads;
    double res = 0.0F;

// Remplissage du vecteur puis calcule de la réduction
#pragma omp parallel
    {
#pragma omp master
        {
            num_threads = omp_get_num_threads ();
        }
#pragma omp for schedule(runtime)
        for (size_t i = 0; i < vecSize; i++)
            a[i] = 0.1F * i;

#pragma omp for schedule(runtime) reduction(- : res)
        for (size_t i = 0; i < nbIter; i++)
            res = reduc (a, vecSize);
    }

    free (a);

    // Pour éviter le dead code
    printf ("%lf\n", res);

    // Deuxième mesure du temps, calcule du temps et écriture
    clock_gettime (CLOCK_MONOTONIC_RAW, &end);

    double elapsed = (double)(end.tv_sec - begin.tv_sec)
                     + (double)(end.tv_nsec - begin.tv_nsec) * 1e-9;
    ompElapsed = omp_get_wtime () - ompBegin;

    FILE *file;
    file = fopen ("resultats.dat", "a");
    fprintf (file, "%2d\t%3.9lf\t%3.9lf\n", num_threads, elapsed, ompElapsed);
    fclose (file);

    return 0;
}
