#include "common.h"

// AVX packed scalar double precision sqrt
void
_test ()
{
    __m256d a;
    a = _mm256_set1_pd (5.0);
    a = _mm256_sqrt_pd (a);
}

DUMMY_MAIN
