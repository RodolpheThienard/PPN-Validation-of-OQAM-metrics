#include "utils.h"

//
void
usage (char *exe)
{
    fprintf (stderr, "usage: %s dimension repetition\n", exe);
}

//
void
daxpy (const double a, const double *restrict x, double *restrict y, size_t n)
{
// Alignment
#if defined(ALIGN_PTR) && defined(ALIGNMENT)
    x = __builtin_assume_aligned (a, ALIGNMENT);
    y = __builtin_assume_aligned (b, ALIGNMENT);
#endif

// Unroll
#if defined(__clang__)
#pragma clang loop unroll_count(4)
#elif defined(__GNUC__) || defined(__GNUG__)
#pragma GCC unroll 4
#elif defined(__AMD__) || defined(__INTEL_COMPILER)
#pragma unroll 4
#else
#error "Unsupported compiler"
#endif

// Vectorization
#ifdef VECTORIZE
#if defined(__clang__)
#pragma clang loop vectorize(enable)
#elif defined(__GNUC__) || defined(__GNUG__)
#pragma GCC ivdep
#elif defined(__AMD__)
#pragma vector
#elif defined(__INTEL_COMPILER)
#pragma simd
#else
#error "Unsupported compiler"
#endif
#endif
    for (size_t i = 0; i < n; i++)
        y[i] = a * x[i] + y[i];
}

//
int
main (int argc, char **argv)
{
    //
    size_t N, rep;
    double *x, *y;

    //
    if (argc != 3)
        {
            return usage (argv[0]), 1;
        }

    //
    N = atoll (argv[1]);
    rep = atoll (argv[2]);

    // Fill x & y with N random doubles
    x = alloc_f64 (N);
    y = alloc_f64 (N);
    init_f64 (x, N, 'r');
    init_f64 (y, N, 'r');

    //
    for (size_t r = 0; r < rep; ++r)
        daxpy (rand (), x, y, N);

    //
    free (x);
    free (y);

    return 0;
}
