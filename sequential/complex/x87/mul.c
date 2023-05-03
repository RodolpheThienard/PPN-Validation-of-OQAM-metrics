#include "common.h"
#include <stdio.h>

// x87 mul simple precision
void
_test ()
{
    TYPE x = 5, y = 3;
    __asm__ volatile("fmul" ISN_SUFFIX " %[x]" : "+t"(x) : [x] "m"(y));
    printf ("%" FORMAT "\n", x);
}

DUMMY_MAIN
