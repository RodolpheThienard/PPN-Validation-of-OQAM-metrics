
#include <vector>

// Méthode de rémontée pour résoudre un système triangularisé
std::vector<double>
Back_Substitution (std::vector<double> const &U, std::vector<double> const &b,
                   const unsigned long n)
{

    std::vector<double> x (n * n);

    x[n - 1] = b[n - 1] / U[(n - 1) * n + (n - 1)];

    for (unsigned long i = n - 2; i > 0; i--)
        {
            for (unsigned long j = i; j < n; j++)
                {
                    x[i] = (b[i] - U[i * n + j] * x[j]) / U[i * n + i];
                }
        }

    return x;
}

// Elimination de Gauß pour triangularisé un système linéaire
std::vector<double>
Gauss_Elimination (std::vector<double> &A, std::vector<double> &b,
                   const unsigned long n)
{

    for (unsigned long k = 0; k < n - 1; k++)
        {
            for (unsigned long i = k + 1; i < n; i++)
                {

                    const double m = A[i * n + k] / A[k * n + k];
                    b[i] -= m * b[k];

                    for (unsigned long j = k + 1; j < n; j++)
                        {

                            A[i * n + j] -= m * A[k * n + j];
                        }
                }
        }

    return Back_Substitution (A, b, n);
}

int
main (void)
{

    // La taille peut changer pour le temps d'exécution pour que LProf puisse
    // faire ses mesures avec suffisamment d'échantillon
    const unsigned long n = 4096;

    std::vector<double> A (n * n);
    std::vector<double> b (n);

    // Remplissage de la matrice et du vecteur
    for (unsigned long i = 0; i < n; i++)
        {
            b[i] = i * 0.1 + 1;
            for (unsigned long j = 0; j < n; j++)
                {
                    A[i * n + j] = i * 0.7 - j * 0.33 + 1;
                    if (A[i * n + j] == 0.0)
                        A[i * n + j] = 1.0;
                }
        }

    // Appel de la fonction
    std::vector<double> x = Gauss_Elimination (A, b, n);

    return 0;
}
