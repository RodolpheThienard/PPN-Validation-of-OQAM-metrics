CC := gcc
MPICC := mpicc
ARCH := native
OLVL := 0
CFLAGS := -Wall -g -Werror -pedantic
CFLAGS += -O$(OLVL) -march=$(ARCH)
LDFLAGS :=
EXE := omp_task pthread omp_sections fork mpi hybrid_task omp_for omp_task2

WORK_ITERATIONS :=
MIN_ITERATIONS :=
MAX_PTHREADS :=
MAX_FORK_THREADS :=
PB_SIZE_FLAGS :=

# Application problem size
ifneq ($(WORK_ITERATIONS),)
	PB_SIZE_FLAGS += -DWORK_ITERATIONS=$(WORK_ITERATIONS)
endif
ifneq ($(MIN_ITERATIONS),)
	PB_SIZE_FLAGS += -DMIN_ITERATIONS=$(MIN_ITERATIONS)
endif
ifneq ($(MAX_PTHREADS),)
	PB_SIZE_FLAGS += -DMAX_PTHREADS=$(MAX_PTHREADS)
endif
ifneq ($(MAX_FORK_THREADS),)
	PB_SIZE_FLAGS += -DMAX_FORK_THREADS=$(MAX_FORK_THREADS)
endif
CFLAGS += $(PB_SIZE_FLAGS)

MAQAO := maqao
MFLAGS := oneview -R1 --replace -of=html --show-program-output=on -WS

.PHONY: all clean clear

all: $(EXE)

omp_task2: omp_task2.c
	$(CC) -fopenmp $(CFLAGS) $(LDFLAGS) -o $@ $<

omp_task: omp_task.c
	$(CC) -fopenmp $(CFLAGS) $(LDFLAGS) -o $@ $<

omp_sections: omp_sections.c
	$(CC) -fopenmp $(CFLAGS) $(LDFLAGS) -o $@ $<

omp_for: omp_for.c
	$(CC) -fopenmp $(CFLAGS) $(LDFLAGS) -o $@ $<

pthread: pthread.c
	$(CC) -pthread $(CFLAGS) $(LDFLAGS) -o $@ $<

mpi: mpi.c
	$(MPICC) $(CFLAGS) $(LDFLAGS) -o $@ $<

hybrid_task: hybrid_task.c
	$(MPICC) -fopenmp $(CFLAGS) $(LDFLAGS) -o $@ $<

all: $(EXE)

clean:
	rm -f *.o

clear: clean
	rm -f ${EXE}
