#include "utils.h"

//
void
init_f64 (double *restrict a, size_t n, const char m)
{
    // Random value per entry
    if (m == 'r' || m == 'R')
        {
            for (size_t i = 0; i < n; i++)
                a[i] = (double)RAND_MAX / (double)rand ();
        }
    else // Zeroing up the array
        if (m == 'z' || m == 'Z')
            {
                for (size_t i = 0; i < n; i++)
                    a[i] = 0.0;
            }
        else // Same value per entry
            if (m == 'c' || m == 'C')
                {
                    double c = (double)RAND_MAX / (double)rand ();

                    for (size_t i = 0; i < n; i++)
                        a[i] = c;
                }
            else // Not implemented
                assert (0);
}

//
double *
alloc_f64 (size_t n)
{
    double *p = aligned_alloc (32, sizeof (double) * n);

    return assert (p), p;
}
