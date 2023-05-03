#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdint.h>

void
IJK (double *a, double *b, double *c, int n)
{
    for (int i = 0; i < n; i++)
        {
            for (int j = 0; j < n; j++)
                {
                    for (int k = 0; k < n; k++)
                        {
                            c[i * n + j] += a[i * n + k] * b[k * n + j];
                        }
                }
        }
}

void
IKJ (double *a, double *b, double *c, int n)
{
    for (int i = 0; i < n; i++)
        {
            for (int k = 0; k < n; k++)
                {
                    for (int j = 0; j < n; j++)
                        {
                            c[i * n + j] += a[i * n + k] * b[k * n + j];
                        }
                }
        }
}

void
IEX (double *a, double *b, double *c, int n)
{
    for (int i = 0; i < n; i++)
        {
            for (int k = 0; k < n; k++)
                {
                    const double _a_ = a[i * n + k];
                    for (int j = 0; j < n; j++)
                        {
                            c[i * n + j] += _a_ * b[k * n + j];
                        }
                }
        }
}

void
IEX_UNROLL (double *a, double *b, double *c, int n)
{
#define UNROLL 4
    for (int i = 0; i < n; i++)
        {
            for (int k = 0; k < n; k++)
                {
                    const double _a_ = a[i * n + k];
                    for (int j = 0; j < (n - (n & (UNROLL - 1))); j += UNROLL)
                        {
                            c[i * n + j] += _a_ * b[k * n + j];
                            c[i * n + j + 1] += _a_ * b[k * n + j + 1];
                            c[i * n + j + 2] += _a_ * b[k * n + j + 2];
                            c[i * n + j + 3] += _a_ * b[k * n + j + 3];
                        }
                    for (int j = (n - (n & (UNROLL - 1))); j < n; j++)
                        {
                            c[i * n + j] += _a_ * b[k * n + j];
                        }
                }
        }
}

// Give the instructions number at the moment
unsigned long long
rdtsc (void)
{
    uint64_t value;
    asm volatile("mrs %0, cntvct_el0" : "=r" (value)); // permet de renvoyer la valeur du compteur d'horloge
    return value;
}


int
main (int argc, char **argv)
{
    double start, end;
    double elapsed, elapsedijk, elapsedikj, elapsediex, elapsedunroll;
    double startall, endall;
    startall = (double)rdtsc ();
    int n = atoi (argv[1]), r = atoi (argv[2]);

    double *a = calloc (n * n, sizeof (double));
    double *b = calloc (n * n, sizeof (double));
    for (int i = 0; i < n; i++)
        {
            for (int j = 0; j < n; j++)
                {
                    a[i * n + j] = i + j;
                    b[i * n + j] = i * j;
                }
        }
    double *c = calloc (n * n, sizeof (double));

    start = (double)rdtsc ();
    for (int _ = 0; _ < r; _++)
        IJK (a, b, c, n);
    end = (double)rdtsc ();
    elapsedijk = end - start;
    printf ("IJK:%f\n", elapsedijk);
    start = (double)rdtsc ();
    for (int _ = 0; _ < r; _++)
        IKJ (a, b, c, n);
    end = (double)rdtsc ();
    elapsedikj = end - start;
    printf ("IKJ:%f\n", elapsedikj);
    start = (double)rdtsc ();
    for (int _ = 0; _ < r; _++)
        IEX (a, b, c, n);
    end = (double)rdtsc ();
    elapsediex = end - start;
    printf ("IEX:%f\n", elapsediex);
    start = (double)rdtsc ();
    for (int _ = 0; _ < r; _++)
        IEX_UNROLL (a, b, c, n);
    end = (double)rdtsc ();
    elapsedunroll = end - start;
    printf ("UNROLL:%f\n", elapsedunroll);

    free (a);
    free (b);
    free (c);

    endall = (double)rdtsc ();
    elapsed = endall - startall;
    printf ("ALL:%f\n", elapsed);
    printf ("IJK:%f%%\nIKJ:%f%%\nIEX:%f%%\nUNROLL:%f%%\n",
            elapsedijk * 100 / elapsed, elapsedikj * 100 / elapsed,
            elapsediex * 100 / elapsed, elapsedunroll * 100 / elapsed);
    return 0;
}
