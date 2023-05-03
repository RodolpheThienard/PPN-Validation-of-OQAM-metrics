#include "common.h"
#include <stdio.h>

// x87 sqrt simple precision
void
_test ()
{
    TYPE x = 9;
    __asm__ volatile("fsqrt" : "+t"(x));
    printf ("%" FORMAT "\n", x);
}

DUMMY_MAIN
