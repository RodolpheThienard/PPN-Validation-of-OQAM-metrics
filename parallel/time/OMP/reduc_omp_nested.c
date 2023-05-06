
#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int num_threads = 0;

// Naive reduction
static double
reduc (const double *restrict a, const size_t size)
{

    double res = 0.0F;

    for (size_t i = 0; i < size; i++)
        res -= a[i];

    return res;
}

// Tree reduction with parallel regions created
static double
reduc_parallel (const double *restrict a, const size_t size, size_t nbNested)
{

    if (size == 1)
        return a[0];

    double res = 0.0F;

    if (nbNested >= 1)
        {
            nbNested--;

#pragma omp parallel num_threads(2) reduction(+ : res)
            {
                if (omp_get_thread_num () != 0)
                    {
#pragma omp atomic
                        num_threads++;
                    }
#pragma omp single nowait
                {
                    res += reduc_parallel (a, size / 2 + size % 2,
                                           nbNested / 2 + nbNested % 2);
                }
#pragma omp single nowait
                {
                    res += reduc_parallel (a + (size / 2 + size % 2), size / 2,
                                           nbNested / 2);
                }
            }
        }
    else
        {
            res += reduc (a + (size / 2 + size % 2), size / 2);
        }

    return res;
}

int
main (int argc, char *argv[])
{

    struct timespec begin, end;
    double ompBegin, ompElapsed;

    if (argc != 3 && argc != 4)
        return fprintf (
                   stderr,
                   "USAGE: %s [taille_vecteur] nb_iteration nb_imbriquée\n",
                   argv[0]),
               1;

    // Firtst measure
    clock_gettime (CLOCK_MONOTONIC_RAW, &begin);
    ompBegin = omp_get_wtime ();

    const size_t vecSize
        = (argc == 3) ? 4 * 1024 : strtoul (argv[1], NULL, 10);
    const size_t nbIter = strtoul (argv[argc - 2], NULL, 10);
    const size_t nbNested = strtoul (argv[argc - 1], NULL, 10);

    double *a = (double *)aligned_alloc (32, vecSize * sizeof (double));

    double res = 0.0F;

    // Fill and compute
#pragma omp parallel
    {
#pragma omp atomic
        num_threads++;

#pragma omp for schedule(runtime)
        for (size_t i = 0; i < vecSize; i++)
            a[i] = 0.1F * i;

#pragma omp for schedule(runtime) reduction(+ : res)
        for (size_t i = 0; i < nbIter; i++)
            res = reduc_parallel (a, vecSize, nbNested);
    }

    free (a);

    printf ("%lf\n", res);

    // Last measure and write to file
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
