# unroll and vectorization tests

This test suit tests verifies that MAQAO provides correct informations
about vectorization and unrolling.

The test suits is a collections of basic linear algebra routines
(daxpy dotprod reduc).

For each routine, multiple versions with different unroll factor are given.
Loops are unrolled using the correct `pragma` for a given compiler.

## macros

The macros defined at processing level can change the binary of the routine.
Theses macros are `VECTORIZE`, `ALIGNMENT` and `ALIGN_PTR`.

- the `VECTORIZE` protects vectorization macros (`pragma`).
- the `ALIGN_PTR` protects alignment macros (`__builtin_assume_aligned`).
- the `ALIGNMENT` defines the pointer alignment (used in conjonction with `ALIGN_PTR`).

## compilation

The code can be compiled using `make`.

Some make variables are available:

- ALIGNMENT: power of 2 that will be defined as the value of the macro ALIGNMENT
  (default value is 32)
- ALIGN_PTR: boolean that tell if pointer alignment has to be enabled or not
  (default value is false)
- VECTORIZE: boolean that tell if vectorization has to be enabled or not
  (default value is false)
- ARCH: the target machine architecture (default value is Haswell)
- CC: the compiler to be used to build the binaries (default value is GCC)
- OLVL: Optimization level (default value is 3)
- CFLAGS: C compiler flags

## `lua` oracle

A `lua` oracle is available for user. This oracle tries to guess the unroll factor
of the loop 0 for a given binary. It is a partial oracle that assumes that assumes
that there is a regular array access in the loop. Hence, by analyzing the `ADD` 
and `SUB` instructions, it may find the correct factor.

Note that this oracle is only partial and may not work on every loop or on every compiler.

To run the oracle:

```
maqao oracle path/to/binary
```
