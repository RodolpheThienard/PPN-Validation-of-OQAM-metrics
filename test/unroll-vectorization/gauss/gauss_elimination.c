
#include <stdlib.h>

// Methode de remontee pour résoudre un système triangulaire
double *
Back_Substitution (const double *restrict U, const double *restrict b,
                   const size_t n)
{

    void *x = NULL;
    posix_memalign (&x, 32, n * sizeof (double));
    double *p_x = __builtin_assume_aligned (x, 32);
    double *p_U = __builtin_assume_aligned (U, 32);
    double *p_b = __builtin_assume_aligned (b, 32);

    p_x[n - 1] = p_b[n - 1] / p_U[(n - 1) * n + (n - 1)];

    for (long long i = n - 2; i > 0; i--)
        {
            for (size_t j = i; j < n; j++)
                {
                    p_x[i]
                        = (p_b[i] - p_U[i * n + j] * p_x[j]) / p_U[i * n + i];
                }
        }

    return p_x;
}

// Elimination de Gauß pour triangulariser un système linéaire
double *
Gauss_Elimination (double *restrict A, double *restrict b, const size_t n)
{

    double *p_A = __builtin_assume_aligned (A, 32);
    double *p_b = __builtin_assume_aligned (b, 32);

    for (size_t k = 0; k < n - 1; k++)
        {
            for (size_t i = k + 1; i < n; i++)
                {

                    const double m = p_A[i * n + k] / p_A[k * n + k];
                    p_b[i] -= m * p_b[k];

                    for (size_t j = k + 1; j < n; j++)
                        {

                            p_A[i * n + j] -= m * p_A[k * n + j];
                        }
                }
        }

    return Back_Substitution (p_A, p_b, n);
}

int
main (void)
{

    // La taille est susceptible d'être changé pour avoir un temps d'exécution
    // assez long pour LProf
    const size_t n = 4096;
    void *A = NULL, *b = NULL;

    posix_memalign (&A, 32, n * n * sizeof (double));
    posix_memalign (&b, 32, n * sizeof (double));

    double *p_A = __builtin_assume_aligned (A, 32);
    double *p_b = __builtin_assume_aligned (b, 32);

    // Remplissage de la matrice et du vecteur
    for (size_t i = 0; i < n; i++)
        {
            p_b[i] = i * 0.1 + 1;
            for (size_t j = 0; j < n; j++)
                {
                    p_A[i * n + j] = i * 0.7 - j * 0.33 + 1;
                    if (p_A[i * n + j] == 0.0)
                        p_A[i * n + j] = 1.0;
                }
        }

    // Appel de la fonction
    double *x = Gauss_Elimination (p_A, p_b, n);

    free (p_A);
    free (p_b);
    free (x);

    return 0;
}
