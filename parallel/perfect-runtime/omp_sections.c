#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
 * Computation of the "perfect" metric of MAQAO,
 * on a OMP sections based parallel model.
 * OMP task have a little bit of overhead when task are dispatched
 * to the available threads.
 * We will see that using timers.
 * The number of sections is hardcoded as MAX_SECTION, since sections
 * cannot be inside branches (hence not dynamic)
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

#define MAX_SECTION 4

#define MAX(a, b) (((a) < (b) ? (b) : (a)))

void
usage (char *bin)
{
    fprintf (stderr,
             "usage: %s f_1 f_2 f_3 f_4\n\n"
             "The thread n will do f_n * WORK_ITERATIONS iterations.\n"
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
    long job[MAX_SECTION];
    double before[MAX_SECTION], after[MAX_SECTION], before_job[MAX_SECTION];

    // Start timer for main thread
    after[0] = before[0] = omp_get_wtime ();

    // Showing help message
    if (argc == 2 && (!strcmp (argv[1], "-h") || !strcmp (argv[1], "--help")))
        return usage (*argv), 0;

    // Checking args
    if (argc != MAX_SECTION + 1)
        return usage (*argv), 1;

    // Parsing args
    for (int i = 1; i <= MAX_SECTION; ++i)
        {
            long factor = atol (argv[i]);
            if (factor <= 0)
                factor = MIN_ITERATIONS;
            else
                factor *= WORK_ITERATIONS;
            job[i - 1] = factor;
        }

#pragma omp parallel num_threads(MAX_SECTION)
    {
        const int tid = omp_get_thread_num ();

        // Start timer
        if (tid != 0)
            after[tid] = before[tid] = omp_get_wtime ();

#pragma omp sections nowait
        {
            // Spawning thread 0
#pragma omp section
            {
                dummy_work (job[0], before_job, after);
            }

            // Spawning thread 1
#pragma omp section
            {
                dummy_work (job[1], before_job, after);
            }

            // Spawning thread 2
#pragma omp section
            {
                dummy_work (job[2], before_job, after);
            }

            // Spawning thread 3
#pragma omp section
            {
                dummy_work (job[3], before_job, after);
            }
        }
    }

    // Computing the max(time) and mean(time without OMP)
    printf ("# %10s %10s\n", "thread id", "execution time");
    double max_time = 0, max_time_without_omp = 0, mean_time_without_omp = 0;
    for (int i = 0; i < MAX_SECTION; ++i)
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
            printf (" %10d %10lf\n", i, exec_time);
        }
    mean_time_without_omp /= MAX_SECTION;

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
