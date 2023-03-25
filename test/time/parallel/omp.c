#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#include <time.h>

int 
main(int argc, char** argv)
{
    int N = atoi(argv[1]), threads = omp_get_num_threads(), i;
    // omp_set_num_threads(threads);
    double a = 3.141592, *x, *y, t1, t2;
    x = (double*)malloc(sizeof(double)*N);
    y = (double*)malloc(sizeof(double)*N);

    for(i = 0; i < N; ++i){
            x[i] = y[i] = (double)i;
    }

    // clock_gettime(CLOCK_MONOTONIC, &begin);
    #pragma omp parallel 
    {
        #pragma for
    {
            
        struct timespec begin, end;
        clock_gettime(CLOCK_MONOTONIC_RAW, &begin);

            for(i = 0; i < N; ++i)
                for (int j = 0; j < 1000; j++)
                    y[i] = a*x[i] + y[i];
    
        clock_gettime(CLOCK_MONOTONIC, &end);
        printf("threadID : %d, time : %lf\n", omp_get_thread_num(), (double)(end.tv_sec - begin.tv_sec)+(end.tv_nsec - begin.tv_nsec)* 1E-9); 
    }
}}