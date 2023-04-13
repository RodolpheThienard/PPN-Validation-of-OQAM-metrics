
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <pthread.h>

// The vector should fit in the L1 cache
#define SIZE 1024*16


pthread_barrier_t barrier;

// Naive reduction of a vector
static double reduc (const double *restrict tab, const size_t size) {

    double res = 0.0F;

    for(size_t i = 0; i < size; i++) {

        res -= tab[i];
    }

    return res;
}


// Structre and routine to fill the vector
typedef struct {

    double *tab;
    size_t size;
    size_t first;

} FillingArgs;

void * filling_routine (void *args) {

    FillingArgs *filling = (FillingArgs*) args;

    for(size_t i = 0; i < filling->size; i++) {

        filling->tab[i] = 0.1F * (i + filling->first); 
    }

    return NULL;
}


// Structure and routine to reduce the vector
typedef struct {

    double *tab;
    double ret;
    double elapsed;
    size_t nbIter;

} ComputeArgs;

void * compute_routine (void *args) {

    pthread_barrier_wait(&barrier);

    ComputeArgs *compute = (ComputeArgs *) args;

    struct timespec begin, end;
    clock_gettime(CLOCK_MONOTONIC_RAW, &begin);

    compute->ret = 0.0F;

    for(size_t i = 0; i < compute->nbIter; i++) {

        compute->ret += reduc(compute->tab, SIZE); 
    }

    pthread_barrier_wait(&barrier);

    clock_gettime(CLOCK_MONOTONIC_RAW, &end);
    compute->elapsed = (double) (end.tv_sec - begin.tv_sec) + (double) (end.tv_nsec - begin.tv_nsec) * 1e-9;

    return NULL;
}


int main (int argc, char *argv[]) {

    struct timespec begin, end;

    if(argc != 4)
        return fprintf(stderr, "USAGE: %s nb_iteration nb_threads nb_chunks\n", argv[0]), 1;

    clock_gettime(CLOCK_MONOTONIC_RAW, &begin);

    const size_t nbIter  = strtoul(argv[1], NULL, 10);
    const size_t nbThrd  = strtoul(argv[2], NULL, 10);
    const size_t nbChunk = strtoul(argv[3], NULL, 10);

    double *tab = (double *) aligned_alloc(32, SIZE * sizeof(double));
    pthread_t thrdID[nbThrd]; 
    FillingArgs *filling = aligned_alloc(32, nbThrd * sizeof(FillingArgs));

    pthread_barrier_init(&barrier, NULL, nbThrd);

    for(size_t i = 0; i < nbThrd; i++) {

        if(i == 0) {

            filling[i].size = (SIZE - nbThrd + 1);
            filling[i].tab = tab;
            filling[i].first = i * (SIZE / nbThrd);
        }
        else {

            filling[i].size = 1;
            filling[i].tab = &( tab[SIZE - nbThrd + i] );
            filling[i].first = SIZE - nbThrd + i;
        }

        pthread_create(&thrdID[i], NULL, filling_routine, &filling[i]);
    }

    for(size_t i = 0; i < nbThrd; i++) {

        pthread_join(thrdID[i], NULL);
    }

    free(filling);

    double res = 0.0F;
    ComputeArgs *compute = aligned_alloc(32, nbThrd * sizeof(ComputeArgs));
    size_t chunk = nbIter / nbChunk;

    for(size_t i = 0; i < nbThrd; i++) {

        if(i == 0) {

            compute[i].nbIter = (nbChunk - nbThrd + 1) * chunk + chunk % nbChunk; 
        }
        else {

            compute[i].nbIter = chunk;
        }

        compute[i].tab = tab;
        compute[i].ret = 0.0F;

        pthread_create(&thrdID[i], NULL, compute_routine, &compute[i]);
    }

    for(size_t i = 0; i < nbThrd; i++) {

        pthread_join(thrdID[i], NULL);
        res += compute[i].ret;
        fprintf(stderr, "%3.9lf\n", compute[i].elapsed); 
    }

    free(compute);

    printf("%lf\n", res);

    clock_gettime(CLOCK_MONOTONIC_RAW, &end);

    double elapsed = (double) (end.tv_sec - begin.tv_sec) + (double) (end.tv_nsec - begin.tv_nsec) * 1e-9;
    fprintf(stderr, "%3.9lf\n", elapsed); 

    return 0;
}
