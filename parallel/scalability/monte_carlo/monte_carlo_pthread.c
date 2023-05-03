#include <gsl/gsl_rng.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// pthread argument passing structure
struct thread_args
{
    long long nb_iteration;
    long long count;
    int tid;
    const gsl_rng_type *T;
};

void
usage (char *bin)
{
    fprintf (stderr, "usage: %s nb_iteration nb_threads\n", bin);
}

void *
worker (void *args_ptr)
{
    struct thread_args *args = (struct thread_args *)args_ptr;
    long long nb_iteration = args->nb_iteration;
    long long count = args->count;
    int tid = args->tid;
    const gsl_rng_type *T = args->T;

    // Random lib preparation
    double x, y;
    gsl_rng *r = gsl_rng_alloc (T);

    gsl_rng_set (r, time (NULL) + tid);

    for (long long i = 0; i < nb_iteration; i++)
        {
            // Taking a random point in the quarter square unit
            x = gsl_rng_uniform (r);
            y = gsl_rng_uniform (r);

            // Testing if it belongs to the unit circle
            if ((x * x + y * y) <= 1.0)
                count++;
        }

    // Storing the count
    args->count = count;

    //
    gsl_rng_free (r);
    return NULL;
}

int
main (int argc, char **argv)
{
    long long count = 0, samples;
    long double pi;
    struct timespec before, after;
    int nb_threads;

    // Start timer
    clock_gettime (CLOCK_MONOTONIC_RAW, &before);

    // Argument check
    if (argc != 3)
        return usage (*argv), 1;

    // Argument parsing
    samples = atoll (argv[1]);
    nb_threads = atoi (argv[2]);
    if (samples <= 0L || nb_threads <= 0)
        return usage (*argv), 2;

    // GSL initialization
    gsl_rng_env_setup ();
    const gsl_rng_type *T = gsl_rng_default;

    // Spawning threads
    pthread_t pid[nb_threads];
    struct thread_args args[nb_threads];
    for (int i = 1; i < nb_threads; ++i)
        {
            // Fill the thread arguments
            args[i].count = 0;
            args[i].nb_iteration = samples / nb_threads;
            args[i].T = T;
            args[i].tid = i;

            // Creating the thread
            pthread_create (pid + i, NULL, worker, args + i);
        }

    // Master thread work
    {
        args[0].count = 0;
        args[0].nb_iteration = samples / nb_threads;
        args[0].T = T;
        args[0].tid = 0;

        worker (args);

        // Getting the result
        count += args[0].count;
    }

    // Waiting for the threads
    for (int i = 1; i < nb_threads; ++i)
        {
            pthread_join (pid[i], NULL);
            count += args[i].count;
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
