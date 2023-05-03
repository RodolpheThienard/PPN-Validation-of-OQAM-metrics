#include "common.h"

// SSE scalar double precision sqrt
void
_test ()
{
    __m128d a;
    a = _mm_set_sd (5.0);
    a = _mm_sqrt_sd (a, a);
}

DUMMY_MAIN
