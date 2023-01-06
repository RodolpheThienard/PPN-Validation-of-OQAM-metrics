all: nbody div

nbody: nbody0.c
	gcc -g -Ofast -funroll-loops -finline-functions -ftree-vectorize $< -o $@ -lm -lSDL2 

div: div.c
	gcc -g -O0 -fno-omit-frame-pointer $< -o $@

clean:
	rm -Rf nbody div
