CC := gcc
ARCH := haswell
INCLUDE := -I ../utils
OLVL := 0
LDFLAGS := -lm
OFLAGS := -O$(OLVL) -march=$(ARCH)
CFLAGS := -Wall -Werror -pedantic -gdwarf-4
CFLAGS += $(OFLAGS) $(INCLUDE)
DOUBLE := false
ifeq ($(DOUBLE),true)
CFLAGS += -DDOUBLE_PRECISION
endif
EXE := mul div sub add sqrt cmp fab

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
