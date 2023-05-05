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

#ifndef WORK_ITERATIONS
#define WORK_ITERATIONS 3e9
#endif /* WORK_ITERATIONS */

#define MAX(a, b) (((a) < (b) ? (b) : (a)))

void
usage (char *bin)
{
    fprintf (stderr,
             "usage: %s f_1 f_2 f_3 f_4 ...\n\n"
             "The thread n will do f_n * WORK_ITERATIONS iterations.\n"
             "n - 1 should not be greater than the max spawnable threads.\n"
             "If f_n <= 0, then it will be set to MIN_ITERATIONS, so\n"
             "MAQAO still sees the thread.\n"
             "WORK_ITERATIONS and MIN_ITERATIONS are macros that can be\n"
             "set at compile time\n",
             bin);
}

int
dummy_work (long iterations, double *job_beg_time, double *end_time)
{
    const int tid = omp_get_thread_num ();
    int ret = 0;

    /*
     * Saving the timestamp at the job start.
     * This will help us computing the overhead of OMP.
     */
    job_beg_time[tid] = omp_get_wtime ();

    for (long i = 0; i < iterations; ++i)
        ret += i % 2;

    /*
     * Saving the timestamp at the job end.
     * This will also be noted as the end time of the thread.
     */
    end_time[tid] = MAX (end_time[tid], omp_get_wtime ());

    return ret;
}

int
main (int argc, char **argv)
{
    int max_threads = omp_get_max_threads ();
    long job[max_threads];
    double before[max_threads], after[max_threads], before_job[max_threads];

    // Start timer for main thread
    after[0] = before[0] = omp_get_wtime ();

    // Showing help message
    if (argc == 2 && (!strcmp (argv[1], "-h") || !strcmp (argv[1], "--help")))
        return usage (*argv), 0;

    // Checking args
    if (argc - 1 > max_threads)
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
    for (int i = argc - 1; i < max_threads; ++i)
        job[i] = MIN_ITERATIONS;

#pragma omp parallel
    {
        const int tid = omp_get_thread_num ();

        // Start timer
        if (tid != 0)
            after[tid] = before[tid] = omp_get_wtime ();

#pragma omp single nowait
        {
            // Spawning threads
            for (int i = 0; i < max_threads; ++i)
                {
#pragma omp task shared(after, before_job) depend(in : i)
                    dummy_work (job[i], before_job, after);
                }

                // Wait for every task
#pragma omp taskwait
        }
    }

    // Computing the max(time) and mean(time without OMP)
    printf ("\n# %10s %10s %10s\n", "thread id", "exec time", "omp time");
    double max_time = 0, max_time_without_omp = 0, mean_time_without_omp = 0;
    for (int i = 0; i < max_threads; ++i)
        {
            const double exec_time = after[i] - before[i];
            const double job_time = after[i] - before_job[i];
            const double omp_time = exec_time - job_time;
            double cur_time_without_omp;

            if (omp_time >= 0.F)
                cur_time_without_omp = job_time;
            else
                cur_time_without_omp = exec_time;

            max_time = MAX (max_time, exec_time);
            max_time_without_omp
                = MAX (max_time_without_omp, cur_time_without_omp);
            mean_time_without_omp += cur_time_without_omp;

            // Debug value in case we need it
            printf ("  %10d %10lf %10lf\n", i, exec_time, omp_time);
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
