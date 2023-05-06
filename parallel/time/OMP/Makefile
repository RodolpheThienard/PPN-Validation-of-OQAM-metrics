
CC := gcc
FORT := gfortran
OLVL := 3
ARCH := native
WFLAGS := -Wall -Wextra
GFLAGS := -g -gdwarf-4
OFLAGS := -O$(OLVL) -funroll-loops
FLAGS := $(GFLAGS) -march=$(ARCH) $(OFLAGS) -fopenmp
CFLAGS := $(WFLAGS) $(FLAGS) 
EXE := reduc_omp reduc_omp_fort reduc_omp_nested

.PHONY: all clean

all: $(EXE)


reduc_omp: reduc_omp.c
	$(CC) $(CFLAGS) $< -o $@ 

reduc_omp_nested: reduc_omp_nested.c
	$(CC) $(CFLAGS) $< -o $@ 

reduc_omp_fort: reduc_omp_fort.f
	$(FORT) $(FLAGS) $< -o $@

clean:
	rm -f $(EXE) resultats.dat
