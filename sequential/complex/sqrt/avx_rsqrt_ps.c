#include "common.h"

// AVX packed scalar single precision reciprocal sqrt
void
_test ()
{
    __m256 a;
    a = _mm256_set1_ps (5.0);
    a = _mm256_rsqrt_ps (a);
}

DUMMY_MAIN
