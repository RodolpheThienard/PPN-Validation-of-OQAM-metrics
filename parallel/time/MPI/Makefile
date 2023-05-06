
CC := gcc
MPICC := mpicc
MPIFORT := mpifort
OLVL := 3
ARCH := native
WFLAGS := -Wall -Wextra
GFLAGS := -g -gdwarf-4
OFLAGS := -O$(OLVL) -funroll-loops
FLAGS := $(GFLAGS) -march=$(ARCH) $(OFLAGS)
CFLAGS := $(WFLAGS)  $(FLAGS) 
EXE :=  reduc_mpi reduc_mpi_fort

.PHONY: all clean

all: $(EXE)


reduc_mpi: reduc_mpi.c
	$(MPICC) $(CFLAGS) $< -o $@

reduc_omp_mpi: reduc_mpi.c
	$(MPICC) $(CFLAGS) $< -o $@ -fopenmp

# Pour intel, spécifiez MPIFORT=mpiifort
reduc_mpi_fort: reduc_mpi_fort.f
	$(MPIFORT) $(FLAGS) $< -o $@


clean:
	rm -f $(EXE) resultats.dat
