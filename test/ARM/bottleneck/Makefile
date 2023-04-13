all: nbody div


div: div.c
	aarch64-linux-gnu-gcc -march=armv8-a -g -O0 -fno-omit-frame-pointer $< -o $@

clean:
	rm -Rf nbody div
