#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

float a = 2.0, *x, *y;
int N;
int nb_threads;
void *saxpy(void *threadid) {
  int start = (int)threadid * N / nb_threads;
  int end = start + N / nb_threads;
  for(int i = 0; i < N; ++i)
      for (int j = 0; j < 1000; j++)
          y[i] = a*x[i] + y[i];
  pthread_exit(NULL);
}

int main(int argc, char** argv) {
  struct timespec begin, end;
  N = atoi(argv[1]);
  x = (float*)malloc(sizeof(float)*N);
  y = (float*)malloc(sizeof(float)*N);
  pthread_t threads[4];
  nb_threads = atoi(argv[2]);
  int rc;
  long t;
  for (t = 0; t < nb_threads; t++) {
    rc = pthread_create(&threads[t], NULL, saxpy, (void *)t);
    if (rc) {
      printf("Error: unable to create thread, %d\n", rc);
      exit(-1);
    }
  }
    clock_gettime(CLOCK_MONOTONIC, &begin);
  for (t = 0; t < nb_threads; t++) {
    pthread_join(threads[t], NULL);
  }
    clock_gettime(CLOCK_MONOTONIC, &end);
    printf("%lf secs\n", (double)(end.tv_sec - begin.tv_sec)+(end.tv_nsec - begin.tv_nsec)* 1E-9);
  return 0;
}