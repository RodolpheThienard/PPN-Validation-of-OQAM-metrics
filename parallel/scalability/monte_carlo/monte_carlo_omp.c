#include <gsl/gsl_rng.h>
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
    long long count = 0, samples;
    long double pi;
    struct timespec before, after;

    // Start timer
    clock_gettime (CLOCK_MONOTONIC_RAW, &before);

    // Argument check
    if (argc != 2)
        return usage (*argv), 1;

    // Argument parsing
    samples = atoll (argv[1]);
    if (samples <= 0L)
        return usage (*argv), 2;

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
        for (long long i = 0; i < samples; i++)
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

    // Stop timer
    clock_gettime (CLOCK_MONOTONIC_RAW, &after);

    // Pi estimation
    pi = 4.0L * (long double)count / (long double)samples;

    //
    printf ("Estimation of pi: %.15Lf\n"
            "Execution time: %lf seconds\n",
            pi,
            (double)(after.tv_sec - before.tv_sec)
                + (double)(after.tv_nsec - before.tv_nsec) * 1e-9);

    //
    return 0;
}
