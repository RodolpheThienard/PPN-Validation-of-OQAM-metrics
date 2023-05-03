
OLVL := 3
OFLAGS := -O$(OLVL) -march=armv-a
CFLAGS := -Wall -Wextra -gdwarf-4
CFLAGS += $(OFLAGS) -funroll-loops

EXE := gauss_C gauss_CPP gauss_F

.PHONY: all clean

all: $(EXE)

gauss_C: gauss_elimination.c
	aarch64-linux-gnu-gcc $(CFLAGS) $< -o $@

gauss_CPP: gauss_elimination.cpp
	g++ $(CFLAGS) $< -o $@

gauss_F: gauss_elimination.f
	gfortran $(CFLAGS) $< -o $@

clean:
	@rm -f $(EXE)
