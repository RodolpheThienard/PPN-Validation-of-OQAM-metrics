#include "common.h"
#include <stdio.h>

// x87 comparison simple precision
void
_test ()
{
    TYPE x = 5, y = 3;
    __asm__ volatile("fcom" ISN_SUFFIX " %[x]" : "+t"(x) : [x] "m"(y));
}

DUMMY_MAIN
