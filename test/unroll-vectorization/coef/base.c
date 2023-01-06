#include <immintrin.h>
#include <stdio.h>
#include <stdlib.h>

//
unsigned long long
rdtsc (void)
{
    unsigned long long a, d;

    __asm__ volatile("rdtsc" : "=a"(a), "=d"(d));

    return (d << 32) | a;
}

//
void
function (int k)
{
    double a = 10;
    double b = 20;
    for (int i = 0; i < k; i++)
        {
            b = 2 * a + 2;
        }
    return;
}

void
function_optimised (int k)
{
    __m512d a = _mm512_set1_pd (10.0);
    __m512d b = _mm512_set1_pd (20.0);
    __m512d c = _mm512_set1_pd (2.0);
    for (int i = 0; i < k; i += 8)
        {
            b = _mm512_fmadd_pd (a, c, b);
        }
    double m = _mm512_reduce_add_pd (a);
    return;
}

//
int
main (int argc, char **argv)
{
    double a = (double)rdtsc ();
    function_optimised (atoi (argv[1]));
    double b = (double)rdtsc ();

    printf ("%lf\n", b - a);
    return 0;
}
