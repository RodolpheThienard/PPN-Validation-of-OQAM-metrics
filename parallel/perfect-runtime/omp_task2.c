#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
 * Computation of the "perfect" metric of MAQAO,
 * on a OMP task based parallel model.
 * OMP task have a little bit of overhead when task are dispatched
 * to the available threads.
 * We will see that using timers.
 */

/*
 * To be seen by MAQAO, the threads has to be seen at least one time
 * during the sampling done at 200MHz by MAQAO.
 */
#ifndef MIN_ITERATIONS
#define MIN_ITERATIONS 1e7
#endif /* MIN_ITERATIONS */

#define MAX(a, b) (((a) < (b) ? (b) : (a)))

void
usage (char *bin)
{
    fprintf (
        stderr,
        "usage: %s nb_threads nb_task\n\n"
        "OMP_NUM_THREADS threads will be created. But only nb_threads "
        "threads\n"
        "will do some consistent work.\n"
        "They will work together to complete nb_task * MIN_ITERATIONS "
        "worth of job.\n"
        "The non working threads will only do 1 * MIN_ITERATIONS worth of job "
        "so\n"
        "MAQAO still sees them.\n"
        "nb_iterations should be great enough so we see the real overhead\n"
        "MIN_ITERATIONS is a macro that can be set at compile time\n",
        bin);
}

int
dummy_work (long iterations, double *bin_time)
{
    const int tid = omp_get_thread_num ();
    double before, after;
    int ret = 0;

    before = omp_get_wtime ();

    for (long i = 0; i < iterations; ++i)
        ret += i % 2;

    after = omp_get_wtime ();

    // Incrementing the binary time
    bin_time[tid] += after - before;

    return ret;
}

int
main (int argc, char **argv)
{
    int max_threads = omp_get_max_threads ();
    double execution_time[max_threads], bin_time[max_threads];
    int nb_working_threads;
    long nb_iterations;

    // Start timer for main thread
    execution_time[0] = omp_get_wtime ();

    // Showing help message
    if (argc == 2 && (!strcmp (argv[1], "-h") || !strcmp (argv[1], "--help")))
        return usage (*argv), 0;

    // Checking args
    if (argc != 3)
        return usage (*argv), 1;

    // Parsing args
    nb_working_threads = atoi (argv[1]);
    nb_iterations = atoll (argv[2]);
    if (nb_working_threads >= max_threads || nb_working_threads <= 0
        || nb_iterations <= 0)
        return usage (*argv), 2;

#pragma omp parallel num_threads(nb_working_threads)
    {
        const int tid = omp_get_thread_num ();

        // Initialize the binary time
        bin_time[tid] = 0;

        // Start timer
        if (tid != 0)
            execution_time[tid] = omp_get_wtime ();

#pragma omp single nowait
        {
            // Spawning threads
            for (int i = 0; i < nb_iterations; ++i)
                {
#pragma omp task shared(bin_time) depend(in : i)
                    dummy_work (MIN_ITERATIONS, bin_time);
                }
        }

        // Wait for every task
#pragma omp taskwait
#pragma omp barrier

        // End timer of the execution time
        execution_time[tid] = omp_get_wtime () - execution_time[tid];
    }

    // Non working threads
#pragma omp parallel
    {
        const int tid = omp_get_thread_num ();

        if (tid >= nb_working_threads)
            {
                bin_time[tid] = 0;
                dummy_work (MIN_ITERATIONS, bin_time);
                execution_time[tid] = bin_time[tid];
            }
    }

    // Computing the max(time) and mean(time without OMP)
    printf ("\n# %10s %10s %10s\n", "thread id", "exec time", "omp time");
    double max_time = 0, max_time_without_omp = 0, mean_time_without_omp = 0;
    for (int i = 0; i < max_threads; ++i)
        {
            const double cur_execution_time = execution_time[i];
            const double cur_bin_time = bin_time[i];
            const double cur_omp_time = cur_execution_time - cur_bin_time;
            double cur_time_without_omp;

            if (cur_omp_time >= 0.F)
                cur_time_without_omp = cur_bin_time;
            else
                cur_time_without_omp = cur_execution_time;

            max_time = MAX (max_time, cur_execution_time);
            max_time_without_omp
                = MAX (max_time_without_omp, cur_time_without_omp);
            mean_time_without_omp += cur_time_without_omp;

            // Debug value in case we need it
            printf ("  %10d %10lf %10lf\n", i, cur_execution_time,
                    cur_omp_time);
        }
    mean_time_without_omp /= max_threads;

    /*
     * Perfect OpenMP + MPI + Pthread
     *       = max_time (time) / max(time without OMP)
     */
    printf ("# Perfect OpenMP + MPI + Pthread: %f\n",
            max_time / max_time_without_omp);

    /*
     * Perfect OpenMP + MPI + Pthread + Perfect Load Distribution
     *       = max_time (time) / mean(time without OMP)
     */
    printf (
        "# Perfect OpenMP + MPI + Pthread + Perfect Load Distribution: %f\n",
        max_time / mean_time_without_omp);

    //
    return 0;
}

/* vim: set ts=8 sts=4 sw=4 et : */
