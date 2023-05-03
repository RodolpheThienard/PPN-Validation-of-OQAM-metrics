
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

// La taille peut être changé en fonction de l'architecture.
// Elle doit être assez grande pour contrer la granularité du chronomètre.
#define VEC_SIZE (1028 *1028 * 1028)

// Le nombre de répétitions des conversions.
// Il doit être changé pour permettre à MAQAO d'avoir assez d'échantillons.
#define NB_REP 40

// On souhaite un avertissement pour ces conversions (instructions cheres)
void
From_Int_To_Double (int *restrict a, double *restrict b, const size_t size)
{

    for (size_t i = 0; i < size; i++)
        {
            b[i] = (double)a[i];
        }
}

// On souhaite un avertissement pour ces conversions aussi (instructions
// cheres)
void
From_Double_To_Int (int *restrict a, double *restrict b, const size_t size)
{

    for (size_t i = 0; i < size; i++)
        {
            a[i] = (int)b[i];
        }
}

int
main (void)
{

    int *a = aligned_alloc (64, VEC_SIZE * sizeof (int));
    double *b = aligned_alloc (64, VEC_SIZE * sizeof (double));

    struct timespec before, after;
    memset (&before, 0, sizeof (struct timespec));
    memset (&after, 0, sizeof (struct timespec));

    double intToDoubleElapsed = 0.0;
    double doubleToIntElapsed = 0.0;

    // On mesure la première boucle
    for (size_t i = 0; i < NB_REP; i++)
        {
            clock_gettime (CLOCK_MONOTONIC_RAW, &before);
            From_Int_To_Double (a, b, VEC_SIZE);
            clock_gettime (CLOCK_MONOTONIC_RAW, &after);
            intToDoubleElapsed
                += (double)(after.tv_sec - before.tv_sec) * 1000000000
                   + (double)(after.tv_nsec - before.tv_nsec);
        }

    // On mesure la deuxième boucle
    for (size_t i = 0; i < NB_REP; i++)
        {
            clock_gettime (CLOCK_MONOTONIC_RAW, &before);
            From_Double_To_Int (a, b, VEC_SIZE);
            clock_gettime (CLOCK_MONOTONIC_RAW, &after);
            doubleToIntElapsed
                += (double)(after.tv_sec - before.tv_sec) * 1000000000
                   + (double)(after.tv_nsec - before.tv_nsec);
        }

    // Affichage des mesures
    printf (
        "i2d = %10.0lf ns = %5.3lf s => %2.2lf %%\nd2i = %10.0lf ns = %5.3lf "
        "s => %2.2lf %%\n",
        intToDoubleElapsed, intToDoubleElapsed / 1000000000,
        intToDoubleElapsed / (doubleToIntElapsed + intToDoubleElapsed) * 100,
        doubleToIntElapsed, doubleToIntElapsed / 1000000000,
        doubleToIntElapsed / (doubleToIntElapsed + intToDoubleElapsed) * 100);

    // Ce dernier printf est obligatoire pour que le compilateur ne considère
    // pas les appels aux fonctions comme du dead code
    printf ("%d %f\n", a[0], b[VEC_SIZE - 1]);

    free (a);
    free (b);

    return 0;
}
