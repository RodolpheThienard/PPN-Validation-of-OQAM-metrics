CC=gcc
CFLAGS=-g
OFLAGS=-O0 -march=native -fno-omit-frame-pointer
LFLAGS=

%: %.c
	$(CC) $(CFLAGS) $(OFLAGS) $< $(LFLAGS)


clean:
	rm -rf a.out
