# Validation de la métrique `Perfect OpenMP + MPI + Pthread (+ Perfect Load Distribution)`

## Concept

Cette batterie de test vérifie les métriques `Perfect OpenMP + MPI + Pthread`
et `Perfect OpenMP + MPI + Pthread + Perfect Load Distribution`.

Pour cela, le temps est mesuré dans chaque thread. On distingue également le
temps d'exécution du binaire et le temps passé dans les runtimes (OpenMP, MPI ou
Pthread).

En sortie les deux métrique sont affichées dans la sortie standard.

Chaque thread effectue un certain nombre d'itérations de travail.

Le nombre d'itérations normal est défini par la variable `WORK_ITERATIONS`.
Les threads ne travaillant pas feront `MIN_ITERATIONS` itérations afin d'être
vus par `MAQAO`.

Pour les exemples `pthreads`, le nombre de threads maximal est défini par
`MAX_PTHREADS`., pour des raisons d'uniformité des arguments des binaires.

Pour les modèles utilisant `fork`, le nombre de threads est défini par
`MAX_FORK_THREADS`.

## Compilation

Un simple `make` permet de compiler les binaires.

Le choix du compilateur peut-être fait avec la variable Make `CC`:
`make CC=clang -B`.

Les variables de compilation peuvent être définis comme suivant:

```
make -B                      \
    WORK_ITERATIONS=$((3e9)) \
    MIN_ITERATIONS=$((1e7))  \
    MAX_PTHREADS=8           \
    MAX_FORK_THREADS=4
```

## Exécution

### `omp_sections`

```
$ ./omp_sections -h
usage: ./omp_sections f_1 f_2 f_3 f_4

The thread n will do f_n * WORK_ITERATIONS iterations.
If f_n <= 0, then it will be set to MIN_ITERATIONS, so
MAQAO still sees the thread.
WORK_ITERATIONS and MIN_ITERATIONS are macros that can be
set at compile time
```

### `pthread`

```
$ ./pthread -h
usage: ./pthread f_1 f_2 f_3 f_4 ...

The thread n will do f_n * WORK_ITERATIONS iterations.
n - 1 should not be greater than MAX_PTHREADS.
If f_n <= 0, then it will be set to MIN_ITERATIONS, so
MAQAO still sees the thread.
MAX_PTHREADS, WORK_ITERATIONS and MIN_ITERATIONS are macros
that can be set at compile time
```

### `omp_task`

```
$ ./omp_task -h
usage: ./omp_task f_1 f_2 f_3 f_4 ...

The thread n will do f_n * WORK_ITERATIONS iterations.
n - 1 should not be greater than the max spawnable threads.
If f_n <= 0, then it will be set to MIN_ITERATIONS, so
MAQAO still sees the thread.
WORK_ITERATIONS and MIN_ITERATIONS are macros that can be
set at compile time
```

### `omp_task2`

```
$ ./omp_task2 -h
usage: ./omp_task2 nb_threads nb_task

OMP_NUM_THREADS threads will be created. But only nb_threads threads
will do some consistent work.
They will work together to complete nb_task * MIN_ITERATIONS worth of job.
The non working threads will only do 1 * MIN_ITERATIONS worth of job so
MAQAO still sees them.
nb_iterations should be great enough so we see the real overhead
MIN_ITERATIONS is a macro that can be set at compile time
```

### `omp_for`

```
$ ./omp_for -h
usage: ./omp_for nb_threads nb_iterations

OMP_NUM_THREADS threads will be created. But only nb_threads threads
will do some consistent work.
They will work together to complete nb_iterations * MIN_ITERATIONS worth of job.
The non working threads will only do 1 * MIN_ITERATIONS worth of job so
MAQAO still sees them.
nb_iterations should be great enough so we see the real overhead
MIN_ITERATIONS is a macro that can be set at compile time
```

### `fork`

```
$ ./fork -h
usage: ./fork f_1 f_2 f_3 f_4 ...

The thread n will do f_n * WORK_ITERATIONS iterations.
n - 1 should not be greater than MAX_FORK_THREADS.
If f_n <= 0, then it will be set to MIN_ITERATIONS, so
MAQAO still sees the thread.
MAX_FORK_THREADS, WORK_ITERATIONS and MIN_ITERATIONS are macros
that can be set at compile time
```

### `mpi`

```
$ mpirun -np 1 ./mpi -h
usage: ./mpi f_1 f_2 f_3 f_4 ...

The thread n will do f_n * WORK_ITERATIONS iterations.
n - 1 should not be greater than the number of MPI processes.
If f_n <= 0, then it will be set to MIN_ITERATIONS, so
MAQAO still sees the thread.
WORK_ITERATIONS and MIN_ITERATIONS are macros
that can be set at compile time
```

### `hybrid_task`

```
$ mpirun -np 1 ./hybrid_task -h
usage: ./hybrid_task l_1 l_2 ...

where l_k is a list of f_n separated by a coma or a space
The thread n of MPI process k will do f_n * WORK_ITERATIONS iterations.
n - 1 should not be greater than the max spawnable threads.
If f_n <= 0, then it will be set to MIN_ITERATIONS, so
MAQAO still sees the thread.
WORK_ITERATIONS and MIN_ITERATIONS are macros that can be
set at compile time

example: OMP_NUM_THREADS=2 mpirun -n 4 ./hybrid_task 1,2 -1,5 0,2 0,0
```

## Sortie

En sortie, les temps d'exécution des threads sont affichés ainsi
que les deux métriques voulues.

```
$ ./omp_sections 1 2 0 4
#  thread id execution time
          0  27.555698
          1  18.580174
          2  27.555478
          3  12.258167
# Perfect OpenMP + MPI + Pthread: 1.000006
# Perfect OpenMP + MPI + Pthread + Perfect Load Distribution: 1.282416
```

Dans cet exemple, la section 1 sera exécutée avec 1 * `WORK_ITERATIONS`
itérations.

La section 2 sera exécutée avec 2 * `WORK_ITERATIONS` itérations.

La section 3 sera exécutée avec `MIN_ITERATIONS` itérations car l'argument 3 est
négatif ou nul.

Finalement, la section 4 sera exécutée avec 4 * `WORK_ITERATIONS` itérations.

<!-- vim:set ts=8 sts=4 sw=4 tw=80 et: -->
