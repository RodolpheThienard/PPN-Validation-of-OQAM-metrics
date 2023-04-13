
CC := gcc
OLVL := 3
ARCH := native
GFLAGS := -g -gdwarf-4 -Wall -Wextra
OFLAGS := -O$(OLVL) -funroll-loops -ftree-vectorize
CFLAGS := $(GFLAGS) -march=$(ARCH) $(OFLAGS)
LDFLAGS := -lpthread
EXE := reduc_first_all_lb_barrier

.PHONY: all clean

all: $(EXE)

%: %.c
	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS) 


clean:
	@ rm -f $(EXE)
