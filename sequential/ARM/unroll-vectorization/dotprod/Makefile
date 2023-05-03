CC := aarch64-linux-gnu-gcc
ARCH := armv8-a
INCLUDE := -I ../utils
VECTORIZE := false
ALIGN_PTR := false
ALIGNMENT := 32
OLVL := 3
OFLAGS := -O$(OLVL) -march=$(ARCH)
CFLAGS := -Wall -g3 -Werror -pedantic -gdwarf-4
CFLAGS += $(OFLAGS) $(INCLUDE)
ifeq ($(VECTORIZE),true)
CFLAGS += -DVECTORIZE
endif
ifeq ($(ALIGN_PTR),true)
CFLAGS += -DALIGN_PTR -DALIGNMENT=32
endif
EXE := dotprod_unroll0 dotprod_unroll4 dotprod_unroll8

.PHONY: clear clean all

all: $(EXE)

../utils/utils.o:
	make -BC ../utils CC=$(CC) ARCH=$(ARCH) OLVL=$(OLVL)

dotprod_unroll0: ../utils/utils.o dotprod_unroll0.o

dotprod_unroll4: ../utils/utils.o dotprod_unroll4.o

dotprod_unroll8: ../utils/utils.o dotprod_unroll8.o

clean:
	rm -f *.o

clear: clean
	rm -f ${EXE}
