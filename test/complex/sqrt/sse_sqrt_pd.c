#include "common.h"

// SSE packed double precision sqrt
void
_test ()
{
    __m128d a;
    a = _mm_set1_pd (5.0);
    a = _mm_sqrt_pd (a);
}

DUMMY_MAIN
