#include "common.h"
#include <stdio.h>

// x87 add simple precision
void
_test ()
{
    TYPE x = 5, y = 1;
    __asm__ volatile("fadd" ISN_SUFFIX " %[x]" : "+t"(x) : [x] "m"(y));
    printf ("%" FORMAT "\n", x);
}

DUMMY_MAIN
