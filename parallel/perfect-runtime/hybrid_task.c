#include <mpi.h>
#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
 * Computation of the "perfect" metric of MAQAO,
 * on a hybrid MPI + OMP task based parallel model.
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

#define ROOT 0

void
usage (char *bin)
{
    fprintf (stderr,
             "usage: %s l_1 l_2 ...\n\n"
             "where l_k is a list of f_n separated by a coma or a space\n"
             "The thread n of MPI process k will do f_n * WORK_ITERATIONS "
             "iterations.\n"
             "n - 1 should not be greater than the max spawnable threads.\n"
             "If f_n <= 0, then it will be set to MIN_ITERATIONS, so\n"
             "MAQAO still sees the thread.\n"
             "WORK_ITERATIONS and MIN_ITERATIONS are macros that can be\n"
             "set at compile time\n\n"
             "example: OMP_NUM_THREADS=2 mpirun -n 4 %s 1,2 -1,5 0,2 0,0\n",
             bin, bin);
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
    int rank, nproc, max_threads = omp_get_max_threads ();
    long job[max_threads];
    double before[max_threads], after[max_threads], before_job[max_threads];

    // Start timer for main thread
    after[0] = before[0] = omp_get_wtime ();

    //
    MPI_Init (&argc, &argv);
    MPI_Comm_rank (MPI_COMM_WORLD, &rank);
    MPI_Comm_size (MPI_COMM_WORLD, &nproc);

    // Showing help message
    if (argc == 2 && (!strcmp (argv[1], "-h") || !strcmp (argv[1], "--help")))
        {
            if (rank == ROOT)
                usage (*argv);

            MPI_Finalize ();
            return 0;
        }

    // Checking args
    if (argc - 1 > nproc)
        {
            if (rank == ROOT)
                usage (*argv);

            MPI_Finalize ();
            return 1;
        }

    // Parsing args
    {
        char *token = NULL;
        int i = 0;

        if (rank + 1 < argc)
            token = strtok (argv[rank + 1], " ,\n\t");

        for (i = 0; i < max_threads && token != NULL; ++i)
            {
                long factor = atol (token);
                if (factor <= 0)
                    factor = MIN_ITERATIONS;
                else
                    factor *= WORK_ITERATIONS;
                job[i] = factor;
                token = strtok (NULL, " ,\n\t");
            }

        for (; i < max_threads; ++i)
            job[i] = MIN_ITERATIONS;
    }

    // Doing the work
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
#pragma omp task shared(after, before_job)
                    dummy_work (job[i], before_job, after);
                }

                // Wait for every task
#pragma omp taskwait
        }
    }

    // Data agregation
    // Construction of bin_time[max_threads] and omp_time[max_threads]
    double bin_time[max_threads], omp_time[max_threads];
    for (int i = 0; i < max_threads; ++i)
        {
            const double job_time = after[i] - before_job[i];
            bin_time[i] = after[i] - before[i];
            omp_time[i] = bin_time[i] - job_time;
        }

    /*
     * Gathering the statistics about OMP to the main MPI proc.
     * The time spend in the gather will be timed and gather,
     * so we know the time spend in MPI.
     */
    double bin_time_all[nproc * max_threads],
        omp_time_all[nproc * max_threads], mpi_time_all[nproc];
    {
        double mpi_time, before_bcast, after_bcast;

        before_bcast = omp_get_wtime ();
        MPI_Gather (bin_time, max_threads, MPI_DOUBLE, bin_time_all,
                    max_threads, MPI_DOUBLE, ROOT, MPI_COMM_WORLD);
        MPI_Gather (omp_time, max_threads, MPI_DOUBLE, omp_time_all,
                    max_threads, MPI_DOUBLE, ROOT, MPI_COMM_WORLD);
        after_bcast = omp_get_wtime ();

        mpi_time = after_bcast - before_bcast;
        MPI_Gather (&mpi_time, 1, MPI_DOUBLE, mpi_time_all, 1, MPI_DOUBLE,
                    ROOT, MPI_COMM_WORLD);
    }

    if (rank == ROOT)
        {
            // Computing the max(time), mean(time without OMP + MPI)
            // and max (time without OMP + MPI)
            printf ("\n# %10s %10s %10s %10s %10s\n", "thread id", "time",
                    "bin time", "omp time", "mpi time");
            double max_time = 0, max_time_without_runtime = 0,
                   mean_time_without_runtime = 0;
            for (int i = 0; i < nproc * max_threads; ++i)
                {
                    const double bin_time = bin_time_all[i];
                    const double omp_time = omp_time_all[i];
                    double mpi_time;

                    // Is the thread 0's data ?
                    // If so add its mpi_time
                    if (!(i % max_threads))
                        mpi_time = mpi_time_all[i / max_threads];
                    else
                        mpi_time = 0.0;

                    max_time = MAX (max_time, bin_time + mpi_time + omp_time);
                    max_time_without_runtime
                        = MAX (max_time_without_runtime, bin_time);
                    mean_time_without_runtime += bin_time;

                    // Debug value in case we need it
                    printf ("  %10d %10lf %10lf %10lf %10lf\n", i,
                            bin_time + omp_time + mpi_time, bin_time, omp_time,
                            mpi_time);
                }
            mean_time_without_runtime /= (nproc * max_threads);

            /*
             * Perfect OpenMP + MPI + Pthread
             *       = max_time (time) / max(time without OMP + MPI)
             */
            printf ("# Perfect OpenMP + MPI + Pthread: %f\n",
                    max_time / max_time_without_runtime);

            /*
             * Perfect OpenMP + MPI + Pthread + Perfect Load Distribution
             *       = max_time (time) / mean(time without OMP + MPI)
             */
            printf ("# Perfect OpenMP + MPI + Pthread + Perfect Load "
                    "Distribution: %f\n",
                    max_time / mean_time_without_runtime);
        }

    //
    MPI_Finalize ();
    return 0;
}

/* vim: set ts=8 sts=4 sw=4 et : */
