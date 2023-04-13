CC := aarch64-linux-gnu-gcc
ARCH := armv8-a
OLVL := 3
OFLAGS := -O$(OLVL) -march=$(ARCH)
CFLAGS := -Wall -g3 -Werror -pedantic -gdwarf-4 $(OFLAGS)

.PHONY: clear clean

utils.o: utils.c utils.h
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f *.o

clear: clean
	rm -f ${EXE}
