#include "utils.h"

//
void
usage (char *exe)
{
    fprintf (stderr, "usage: %s dimension repetition\n", exe);
}

//
double
reduc (double *restrict a, size_t n)
{
    double d = 0.0;

// Alignment
#if defined(ALIGN_PTR) && defined(ALIGNMENT)
    a = __builtin_assume_aligned (a, ALIGNMENT);
#endif

// Unroll
#if defined(__clang__)
#pragma clang loop unroll_count(8)
#elif defined(__GNUC__) || defined(__GNUG__)
#pragma GCC unroll 8
#elif defined(__AMD__) || defined(__INTEL_COMPILER)
#pragma unroll 8
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
        d += a[i];

    return d;
}

//
int
main (int argc, char **argv)
{
    //
    size_t N, rep;
    double *a, ret;

    //
    if (argc != 3)
        {
            return usage (argv[0]), 1;
        }

    //
    N = atoll (argv[1]);
    rep = atoll (argv[2]);

    // Fill a with N random doubles
    a = alloc_f64 (N);
    init_f64 (a, N, 'r');

    //
    for (size_t r = 0; r < rep; ++r)
        ret = reduc (a, N);

    // remove unused message, and prevent DCE
    (void)ret;

    //
    free (a);

    return 0;
}
