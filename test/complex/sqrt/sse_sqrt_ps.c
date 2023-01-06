#include "common.h"

// SSE packed single precision sqrt
void
_test ()
{
    __m128 a;
    a = _mm_set1_ps (5.0);
    a = _mm_sqrt_ps (a);
}

DUMMY_MAIN
