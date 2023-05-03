#include <gsl/gsl_rng.h>
#include <mpi.h>
#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void
usage (char *bin)
{
    fprintf (stderr, "usage: %s nb_iteration\n", bin);
}

int
main (int argc, char **argv)
{
    long long count = 0, samples, tmp;
    long double pi;
    struct timespec before, after;
    int rank, nproc, provided, required = MPI_THREAD_FUNNELED;

    // Start timer
    clock_gettime (CLOCK_MONOTONIC_RAW, &before);

    //
    MPI_Init_thread (&argc, &argv, required, &provided);
    MPI_Comm_rank (MPI_COMM_WORLD, &rank);
    MPI_Comm_size (MPI_COMM_WORLD, &nproc);

    // Argument check
    if (argc != 2)
        {
            if (rank == 0)
                usage (*argv);

            MPI_Finalize ();
            return 1;
        }

    // MPI lib check
    if (required < provided)
        {
            if (rank == 0)
                fprintf (stderr,
                         "Could not initialize multi threaded MPI runtime\n");

            MPI_Finalize ();
            return 3;
        }

    // Argument parsing
    samples = atoll (argv[1]);
    if (samples <= 0L)
        {
            if (rank == 0)
                usage (*argv);

            MPI_Finalize ();
            return 2;
        }

    // GSL initialization
    gsl_rng_env_setup ();
    const gsl_rng_type *T = gsl_rng_default;

#pragma omp parallel
    {
        // Random lib preparation
        double x, y;
        int tid = omp_get_thread_num ();
        gsl_rng *r = gsl_rng_alloc (T);

        gsl_rng_set (r, time (NULL) + tid);

#pragma omp for reduction(+ : count)
        for (long long i = 0; i < samples / (long long)nproc; i++)
            {
                // Taking a random point in the quarter square unit
                x = gsl_rng_uniform (r);
                y = gsl_rng_uniform (r);

                // Testing if it belongs to the unit circle
                if ((x * x + y * y) <= 1.0)
                    count++;
            }

        gsl_rng_free (r);
    }

    // Reduce the count
    MPI_Reduce (&count, &tmp, 1, MPI_LONG_LONG, MPI_SUM, 0, MPI_COMM_WORLD);
    MPI_Finalize ();

    // Stop timer
    clock_gettime (CLOCK_MONOTONIC_RAW, &after);

    // Print pi value
    if (rank == 0)
        {
            //
            count = tmp;

            // Pi estimation
            pi = 4.0L * (long double)count / (long double)samples;

            //
            printf ("Estimation of pi: %.15Lf\n"
                    "Execution time: %lf seconds\n",
                    pi,
                    (double)(after.tv_sec - before.tv_sec)
                        + (double)(after.tv_nsec - before.tv_nsec) * 1e-9);
        }

    //
    return 0;
}
