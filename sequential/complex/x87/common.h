#ifndef _COMMON_H_
#define _COMMON_H_

/*
 * As for Jan 1 2022, CQA with a object file is broken.
 * Adding a macro to create a dummy main.
 */
#define DUMMY_MAIN                                                            \
    int main ()                                                               \
    {                                                                         \
        _test ();                                                             \
                                                                              \
        return 0;                                                             \
    }

#ifdef DOUBLE_PRECISION
#define ISN_SUFFIX "l"
#define FORMAT "lf"
#define TYPE double
#else
#define ISN_SUFFIX "s"
#define FORMAT "f"
#define TYPE float
#endif

#endif /* _COMMON_H_ */
