CC := gcc
ARCH := haswell
VECTORIZE := false
ALIGN_PTR := false
ALIGNMENT := 32
OLVL := 3
OFLAGS := -O$(OLVL) -march=$(ARCH)
CFLAGS := -Wall -g3 -Werror -pedantic -gdwarf-4 $(OFLAGS)
TARGETS := daxpy dotprod reduc
DEPS := utils

.PHONY: clean clear all

all:
	for d in $(TARGETS); do \
		make -BC $$d CC=$(CC) ARCH=$(ARCH) \
			VECTORIZE=$(VECTORIZE) ALIGN_PTR=$(ALIGN_PTR) \
			ALIGNMENT=$(ALIGNMENT) OLVL=$(OLVL); \
	done

clean:
	for d in $(TARGETS) $(DEPS); do \
		make -BC $$d clean; \
	done

clear:
	for d in $(TARGETS) $(DEPS); do \
		make -BC $$d clear; \
	done
