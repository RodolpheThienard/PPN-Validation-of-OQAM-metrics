#include <mpi.h>
#include <stdlib.h>
#include <time.h>
#include <stdio.h>

int
main (int argc, char **argv)
{
    int rank, size;

    MPI_Init (&argc, &argv);

    MPI_Comm_rank (MPI_COMM_WORLD, &rank);
    MPI_Comm_size (MPI_COMM_WORLD, &size);
    int N = atoi(argv[1]), threads = size, i;
    double a = 3.141592, *x, *y, t1, t2;
    x = (double*)malloc(sizeof(double)*N);
    y = (double*)malloc(sizeof(double)*N);

    struct timespec begin, end;
    clock_gettime (CLOCK_MONOTONIC_RAW, &begin);

    for (i = 0; i < N; ++i)
        for (int j = 0; j < 1000; j++)
            y[i] = a * x[i] + y[i];

    clock_gettime (CLOCK_MONOTONIC, &end);
    printf ("threadID : %d, time : %lf\n", rank,
            (double)(end.tv_sec - begin.tv_sec)
                + (end.tv_nsec - begin.tv_nsec) * 1E-9);

    MPI_Finalize ();

    return 0;
}