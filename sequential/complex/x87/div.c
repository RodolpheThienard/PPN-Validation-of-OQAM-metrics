#include "common.h"
#include <stdio.h>

// x87 div simple precision
void
_test ()
{
    TYPE x = 8, y = 3;
    __asm__ volatile("fdiv" ISN_SUFFIX " %[x]" : "+t"(x) : [x] "m"(y));
    printf ("%" FORMAT "\n", x);
}

DUMMY_MAIN
