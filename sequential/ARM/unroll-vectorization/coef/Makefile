CC=aarch64-linux-gnu-gcc
CFLAGS=-g
OFLAGS=-O0 -march=armv8-a -fno-omit-frame-pointer -DSDL_DISABLE_IMMINTRIN_H
LFLAGS=

%: %.c
	$(CC) $(CFLAGS) $(OFLAGS) $< $(LFLAGS)


clean:
	rm -rf a.out
