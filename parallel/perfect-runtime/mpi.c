#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

/*
 * Computation of the "perfect" metric of MAQAO,
 * on a MPI model.
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
             "usage: %s f_1 f_2 f_3 f_4 ...\n\n"
             "The thread n will do f_n * WORK_ITERATIONS iterations.\n"
             "n - 1 should not be greater than the number of MPI processes.\n"
             "If f_n <= 0, then it will be set to MIN_ITERATIONS, so\n"
             "MAQAO still sees the thread.\n"
             "WORK_ITERATIONS and MIN_ITERATIONS are macros\n"
             "that can be set at compile time\n",
             bin);
}

int
work (long iterations)
{
    int ret = 0;

    for (long i = 0; i < iterations; ++i)
        ret += i % 2;

    return ret;
}

int
main (int argc, char **argv)
{
    int rank, nproc;
    struct timespec before, after;

    // Start timer
    clock_gettime (CLOCK_MONOTONIC_RAW, &before);

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
    long job[nproc];
    for (int i = 1; i < argc; ++i)
        {
            long factor = atol (argv[i]);
            if (factor <= 0)
                factor = MIN_ITERATIONS;
            else
                factor *= WORK_ITERATIONS;
            job[i - 1] = factor;
        }
    for (int i = argc - 1; i < nproc; ++i)
        job[i] = MIN_ITERATIONS;

    // Doing the job
    {
        work (job[rank]);
    }

    // End timer
    clock_gettime (CLOCK_MONOTONIC_RAW, &after);
    double bin_time = (double)(after.tv_sec - before.tv_sec)
                      + (double)(after.tv_nsec - before.tv_nsec) * 1e-9;

    /*
     * Sharing the timer, so the ROOT can compute the metrics.
     * We also time the bcast to see the time spend in MPI.
     */
    double mpi_time_all[nproc], bin_time_all[nproc];
    {
        double mpi_time;
        struct timespec before_bcast, after_bcast;

        clock_gettime (CLOCK_MONOTONIC_RAW, &before_bcast);
        MPI_Gather (&bin_time, 1, MPI_DOUBLE, bin_time_all, 1, MPI_DOUBLE,
                    ROOT, MPI_COMM_WORLD);
        clock_gettime (CLOCK_MONOTONIC_RAW, &after_bcast);

        mpi_time
            = (double)(after_bcast.tv_sec - before_bcast.tv_sec)
              + (double)(after_bcast.tv_nsec - before_bcast.tv_nsec) * 1e-9;
        MPI_Gather (&mpi_time, 1, MPI_DOUBLE, mpi_time_all, 1, MPI_DOUBLE,
                    ROOT, MPI_COMM_WORLD);
    }

    if (rank == ROOT)
        {
            // Computing the max(time), mean(time without MPI)
            // and max (time without MPI)
            printf ("\n# %10s %10s %10s %10s\n", "proc id", "exec time",
                    "mpi time", "sum");
            double max_time = 0, max_time_without_mpi = 0,
                   mean_time_without_mpi = 0;
            for (int i = 0; i < nproc; ++i)
                {
                    const double bin_time = bin_time_all[i];
                    const double mpi_time = mpi_time_all[i];

                    max_time = MAX (max_time, bin_time + mpi_time);
                    max_time_without_mpi
                        = MAX (max_time_without_mpi, bin_time);
                    mean_time_without_mpi += bin_time;

                    // Debug value in case we need it
                    printf ("  %10d %10lf %10lf %10lf\n", i, bin_time,
                            mpi_time, bin_time + mpi_time);
                }
            mean_time_without_mpi /= nproc;

            /*
             * Perfect OpenMP + MPI + Pthread
             *       = max_time (time) / max(time without MPI)
             */
            printf ("# Perfect OpenMP + MPI + Pthread: %f\n",
                    max_time / max_time_without_mpi);

            /*
             * Perfect OpenMP + MPI + Pthread + Perfect Load Distribution
             *       = max_time (time) / mean(time without MPI)
             */
            printf ("# Perfect OpenMP + MPI + Pthread + Perfect Load "
                    "Distribution: %f\n",
                    max_time / mean_time_without_mpi);
        }

    //
    MPI_Finalize ();
    return 0;
}

/* vim: set ts=8 sts=4 sw=4 et : */
