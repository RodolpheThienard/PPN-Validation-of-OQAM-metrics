#ifndef _UTILS_H_
#define _UTILS_H_

#include <assert.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>

//
void init_f64 (double *restrict a, size_t n, const char m);

//
double *alloc_f64 (size_t n);

#endif /* _UTILS_H_ */
