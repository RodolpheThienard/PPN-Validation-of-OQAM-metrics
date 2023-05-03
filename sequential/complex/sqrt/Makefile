CC := gcc
ARCH := haswell
OLVL := 0
LDFLAGS := -lm
OFLAGS := -O$(OLVL) -march=$(ARCH)
CFLAGS := -Wall -Werror -pedantic -gdwarf-4 -Wno-unused-but-set-variable
CFLAGS += $(OFLAGS) $(INCLUDE)
EXE := sse_rsqrt_ps sse_rsqrt_ss sse_sqrt_pd sse_sqrt_ps sse_sqrt_sd sse_sqrt_ss
EXE += avx_rsqrt_ps avx_sqrt_pd avx_sqrt_ps

.PHONY: clear clean all list list_targets

%: %.o

all: $(EXE)

clean:
	rm -f *.o

clear: clean
	rm -f $(EXE)

list:
	@echo $(EXE)

list_targets: list
