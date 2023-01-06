#include "common.h"

// SSE scalar single precision sqrt
void
_test ()
{
    __m128 a;
    a = _mm_set_ss (5.0);
    a = _mm_sqrt_ss (a);
}

DUMMY_MAIN
