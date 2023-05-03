#include "common.h"
#include <stdio.h>

// x87 fab simple precision
void
_test ()
{
    TYPE x = -9;
    __asm__ volatile("fabs" : "+t"(x));
    printf ("%" FORMAT "\n", x);
}

DUMMY_MAIN
