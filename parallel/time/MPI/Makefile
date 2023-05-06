
CC := gcc
MPICC := mpicc
MPIFORT := mpifort
OLVL := 3
ARCH := native
WFLAGS := -Wall -Wextra
GFLAGS := -g -gdwarf-4
OFLAGS := -O$(OLVL) -funroll-loops
FFLAGS := $(GFLAGS) -march=$(ARCH) $(OFLAGS)
CFLAGS := $(WFLAGS) $(GFLAGS) -march=$(ARCH) $(OFLAGS)
EXE :=  reduc_mpi reduc_mpi_alltimes reduc_mpi_fort reduc_mpi_fort_alltimes


.PHONY: all clean

all: $(EXE)


reduc_mpi: reduc_mpi.c
	$(MPICC) $(CFLAGS) $< -o $@

reduc_mpi_alltimes: reduc_mpi_alltimes.c
	$(MPICC) $(CFLAGS) $< -o $@

# Pour intel, spécifiez MPIFORT=mpiifort
reduc_mpi_fort: reduc_mpi_fort.f
	$(MPIFORT) $(FFLAGS) $< -o $@

ifneq ($(MPIFORT), mpiifort)
reduc_mpi_fort_alltimes: reduc_mpi_fort_alltimes.f
	$(MPIFORT) $(FFLAGS) $< -o $@
else
reduc_mpi_fort_alltimes: reduc_mpi_fort_alltimes_intel.f
	$(MPIFORT) $(FFLAGS) $< -o $@
endif

clean:
	rm -f $(EXE) resultats.dat [1-9]*.dat
