#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

/*
 * Computation of the "perfect" metric of MAQAO,
 * on a fork model.
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

#ifndef MAX_FORK_THREADS
#define MAX_FORK_THREADS 8
#endif /* MAX_FORK_THREADS */

#define MAX(a, b) (((a) < (b) ? (b) : (a)))

// argument passing structure
struct thread_args
{
    long iteration;
    struct timespec *before, *after;
    int ret;
};

void
usage (char *bin)
{
    fprintf (
        stderr,
        "usage: %s f_1 f_2 f_3 f_4 ...\n\n"
        "The thread n will do f_n * WORK_ITERATIONS iterations.\n"
        "n - 1 should not be greater than MAX_FORK_THREADS.\n"
        "If f_n <= 0, then it will be set to MIN_ITERATIONS, so\n"
        "MAQAO still sees the thread.\n"
        "MAX_FORK_THREADS, WORK_ITERATIONS and MIN_ITERATIONS are macros\n"
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
    long job[MAX_FORK_THREADS];
    struct thread_args args[MAX_FORK_THREADS];
    struct timespec *before, *after;

    // Allocating share memory segments
    size_t time_size = MAX_FORK_THREADS * sizeof (struct timespec);
    before = mmap (NULL, time_size, PROT_READ | PROT_WRITE,
                   MAP_SHARED | MAP_ANONYMOUS, -1, 0);
    after = mmap (NULL, time_size, PROT_READ | PROT_WRITE,
                  MAP_SHARED | MAP_ANONYMOUS, -1, 0);

    // Start timer for main thread
    clock_gettime (CLOCK_MONOTONIC_RAW, before);

    // Showing help message
    if (argc == 2 && (!strcmp (argv[1], "-h") || !strcmp (argv[1], "--help")))
        return usage (*argv), 0;

    // Checking args
    if (argc - 1 > MAX_FORK_THREADS)
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
    for (int i = argc - 1; i < MAX_FORK_THREADS; ++i)
        job[i] = MIN_ITERATIONS;

    // Spawning threads
    for (int i = 1; i < MAX_FORK_THREADS; ++i)
        {
            // Fill the thread arguments
            args[i].iteration = job[i];
            args[i].after = after + i;
            args[i].before = before + i;

            // Creating the thread
            const pid_t pid = fork ();
            if (pid < 0)
                return perror ("fork"), 255;

            if (pid == 0) /* Child */
                return worker (args + i), 0;
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
     * iddling time of waitpid.
     * MAQAO won't see the thread if he is stuck in there,
     * and we will have divergent values.
     */
    clock_gettime (CLOCK_MONOTONIC_RAW, after);

    // Waiting for the childs
    for (int i = 1; i < MAX_FORK_THREADS; ++i)
        wait (NULL);

    // Computing the max(time) and mean(time)
    printf ("\n# %10s %10s\n", "thread id", "execution time");
    double max_time = 0, mean_time = 0;
    for (int i = 0; i < MAX_FORK_THREADS; ++i)
        {
            const double exec_time
                = MAX (0, (double)(after[i].tv_sec - before[i].tv_sec)
                              + (double)(after[i].tv_nsec - before[i].tv_nsec)
                                    * 1e-9);
            max_time = MAX (max_time, exec_time);
            mean_time += exec_time;

            // Debug value in case we need it
            printf (" %10d %10lf\n", i, exec_time);
        }
    mean_time /= MAX_FORK_THREADS;

    /*
     * Perfect OpenMP + MPI + Pthread
     *       = max (time) / max(time without pthread ...)
     * We are using no runtime. So max(time without ...) = max (time)
     */
    printf ("# Perfect OpenMP + MPI + Pthread: %f\n", max_time / max_time);

    /*
     * Perfect OpenMP + MPI + Pthread + Perfect Load Distribution
     *       = max (time) / mean(time without pthread...)
     * We are using no runtime. So mean(time without ...) = mean (time)
     */
    printf (
        "# Perfect OpenMP + MPI + Pthread + Perfect Load Distribution: %f\n",
        max_time / mean_time);

    //
    munmap (before, time_size);
    munmap (after, time_size);
    return 0;
}

/* vim: set ts=8 sts=4 sw=4 et : */
