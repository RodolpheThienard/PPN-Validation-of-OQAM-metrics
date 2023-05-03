CC := gcc
MPICC := mpicc
ARCH := native
OLVL := fast
CFLAGS := -Wall -g -Werror -pedantic
CFLAGS += -O$(OLVL) -finline-functions -funroll-loops -march=$(ARCH)
LDFLAGS := -lgsl -lcblas
EXE := monte_carlo_omp monte_carlo_mpi monte_carlo_hybrid monte_carlo_pthread monte_carlo_pthread_mpi

MAQAO := maqao
MFLAGS := oneview -R1 --replace -of=html --show-program-output=on -WS
# strong or weak
TEST := strong

.PHONY: all clean clear report_omp report_mpi

all: $(EXE)

monte_carlo_hybrid: monte_carlo_hybrid.c
	$(MPICC) $(CFLAGS) -fopenmp $(LDFLAGS) -o $@ $<

monte_carlo_mpi: monte_carlo_mpi.c
	$(MPICC) $(CFLAGS) $(LDFLAGS) -o $@ $<

monte_carlo_pthread_mpi: monte_carlo_pthread_mpi.c
	$(MPICC) $(CFLAGS) -pthread $(LDFLAGS) -o $@ $<

monte_carlo_omp: monte_carlo_omp.c
	$(CC) $(CFLAGS) -fopenmp $(LDFLAGS) -o $@ $<

monte_carlo_pthread: monte_carlo_pthread.c
	$(CC) $(CFLAGS) -pthread $(LDFLAGS) -o $@ $<

report_hybrid: monte_carlo_hybrid
	$(MAQAO) $(MFLAGS)=$(TEST) -xp=hybrid_$(TEST) -c=maqao_configs/config_hybrid_$(TEST).lua

report_mpi: monte_carlo_mpi
	$(MAQAO) $(MFLAGS)=$(TEST) -xp=mpi_$(TEST) -c=maqao_configs/config_mpi_$(TEST).lua

report_omp: monte_carlo_omp
	$(MAQAO) $(MFLAGS)=$(TEST) -xp=omp_$(TEST) -c=maqao_configs/config_omp_$(TEST).lua

report_pthread: monte_carlo_pthread
	$(MAQAO) $(MFLAGS)=$(TEST) -xp=pthread_$(TEST) -c=maqao_configs/config_pthread_$(TEST).lua

report_pthread_mpi: monte_carlo_pthread_mpi
	$(MAQAO) $(MFLAGS)=$(TEST) -xp=pthread_mpi_$(TEST) -c=maqao_configs/config_pthread_mpi_$(TEST).lua

clean:
	rm -f *.o

clear: clean
	rm -f ${EXE}
