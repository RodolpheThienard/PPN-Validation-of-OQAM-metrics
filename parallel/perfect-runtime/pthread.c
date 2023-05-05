#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

/*
 * Computation of the "perfect" metric of MAQAO,
 * on a pthread model.
 */

/*
 * To be seen by MAQAO, the threads has to be seen at least one time
 * during the sampling done at 200MHz by MAQAO.
 */
#ifndef MIN_ITERATIONS
#define MIN_ITERATIONS 1e7
#endif /* MIN_ITERATIONS */

#ifndef WORK_ITERATIONS
#define WORK_ITERATIONS 3e9
#endif /* WORK_ITERATIONS */

#ifndef MAX_PTHREADS
#define MAX_PTHREADS 8
#endif /* MAX_PTHREADS */

#define MAX(a, b) (((a) < (b) ? (b) : (a)))

// pthread argument passing structure
struct thread_args
{
    long iteration;
    struct timespec *before, *after;
    int ret;
};

void
usage (char *bin)
{
    fprintf (stderr,
             "usage: %s f_1 f_2 f_3 f_4 ...\n\n"
             "The thread n will do f_n * WORK_ITERATIONS iterations.\n"
             "n - 1 should not be greater than MAX_PTHREADS.\n"
             "If f_n <= 0, then it will be set to MIN_ITERATIONS, so\n"
             "MAQAO still sees the thread.\n"
             "MAX_PTHREADS, WORK_ITERATIONS and MIN_ITERATIONS are macros\n"
             "that can be set at compile time\n",
             bin);
}

void *
worker (void *args_ptr)
{
    struct thread_args *args = (struct thread_args *)args_ptr;
    struct timespec *before = args->before, *after = args->after;
    long iterations = args->iteration;
    int ret = 0;

    clock_gettime (CLOCK_MONOTONIC_RAW, before);

    for (long i = 0; i < iterations; ++i)
        ret += i % 2;

    clock_gettime (CLOCK_MONOTONIC_RAW, after);

    args->ret = ret;
    return NULL;
}

int
main (int argc, char **argv)
{
    struct timespec before[MAX_PTHREADS], after[MAX_PTHREADS];
    long job[MAX_PTHREADS];
    pthread_t pid[MAX_PTHREADS];
    struct thread_args args[MAX_PTHREADS];

    // Start timer for main thread
    clock_gettime (CLOCK_MONOTONIC_RAW, before);

    // Showing help message
    if (argc == 2 && (!strcmp (argv[1], "-h") || !strcmp (argv[1], "--help")))
        return usage (*argv), 0;

    // Checking args
    if (argc - 1 > MAX_PTHREADS)
        return usage (*argv), 1;

    // Parsing args
    for (int i = 1; i < argc; ++i)
        {
            long factor = atol (argv[i]);
            if (factor <= 0)
                factor = MIN_ITERATIONS;
            else
                factor *= WORK_ITERATIONS;
            job[i - 1] = factor;
        }
    for (int i = argc - 1; i < MAX_PTHREADS; ++i)
        job[i] = MIN_ITERATIONS;

    // Spawning threads
    for (int i = 1; i < MAX_PTHREADS; ++i)
        {
            // Fill the thread arguments
            args[i].iteration = job[i];
            args[i].after = after + i;
            args[i].before = before + i;

            // Creating the thread
            pthread_create (pid + i, NULL, worker, args + i);
        }

    // Master thread work
    {
        args[0].iteration = job[0];
        args[0].before = after; // dummy
        args[0].after = after;

        worker (args);
    }

    /*
     * End timer for thread 0.
     * We add it here, so we do not take into account the
     * iddling time of pthread_join.
     * MAQAO won't see the thread if he is stuck in there,
     * and we will have divergent values.
     */
    clock_gettime (CLOCK_MONOTONIC_RAW, after);

    // Waiting for the threads
    for (int i = 1; i < MAX_PTHREADS; ++i)
        pthread_join (pid[i], NULL);

    // Computing the max(time), max(time without pthread)
    // and mean(time without pthread)
    printf ("\n# %10s %10s\n", "thread id", "execution time");
    double max_time = 0, max_time_without_pthread = 0,
           mean_time_without_pthread = 0;
    for (int i = 0; i < MAX_PTHREADS; ++i)
        {
            const double exec_time
                = (double)(after[i].tv_sec - before[i].tv_sec)
                  + (double)(after[i].tv_nsec - before[i].tv_nsec) * 1e-9;
            max_time = MAX (max_time, exec_time);
            max_time_without_pthread = MAX (max_time_without_pthread, exec_time);
            mean_time_without_pthread += exec_time;

            // Debug value in case we need it
            printf (" %10d %10lf\n", i, exec_time);
        }
    mean_time_without_pthread /= MAX_PTHREADS;

    /*
     * Perfect OpenMP + MPI + Pthread
     *       = max_time (time) / max(time without pthread)
     */
    printf ("# Perfect OpenMP + MPI + Pthread: %f\n",
            max_time / max_time_without_pthread);

    /*
     * Perfect OpenMP + MPI + Pthread + Perfect Load Distribution
     *       = max_time (time) / mean(time without pthread)
     */
    printf (
        "# Perfect OpenMP + MPI + Pthread + Perfect Load Distribution: %f\n",
        max_time / mean_time_without_pthread);

    //
    return 0;
}

/* vim: set ts=8 sts=4 sw=4 et : */
