
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

// La taille peut être changé en fonction de l'architecture
// Elle doit être assez grande pour contrer la granularité du chronomètre
#define VEC_SIZE (1028 * 1028)

// Le nombre de répétition des réductions.
// Il doit être changé pour permettre à MAQAO d'avoir assez d'échantillons
#define NB_REP (10000)

// Reduction d'un vecteur avec une addition
double
add_reduc (double *restrict a, const size_t size)
{

    double *p_a = __builtin_assume_aligned (a, 32);

    double ret = 0.0;

    for (size_t i = 0; i < size; i++)
        {

            ret += p_a[i];
        }

    return ret;
}

// Réduction d'un vecteur avec une soustraction
double
sub_reduc (double *restrict a, const size_t size)
{

    double *p_a = __builtin_assume_aligned (a, 32);

    double ret = 0.0;

    for (size_t i = 0; i < size; i++)
        {

            ret -= p_a[i];
        }

    return ret;
}

int
main (void)
{

    double *a = aligned_alloc (32, VEC_SIZE * sizeof (double));
    double x = 0.0;
    double y = 0.0;

    struct timespec before, after;
    memset (&before, 0, sizeof (struct timespec));
    memset (&after, 0, sizeof (struct timespec));

    // Mesure première boucle
    clock_gettime (CLOCK_MONOTONIC_RAW, &before);
    for (size_t i = 0; i < NB_REP; i++)
        {
            y = add_reduc (a, VEC_SIZE);
        }
    clock_gettime (CLOCK_MONOTONIC_RAW, &after);

    double add_elapsed = (double)(after.tv_sec - before.tv_sec) * 1000000000
                         + (double)(after.tv_nsec - before.tv_nsec);

    // Mesure deuxième boucle
    clock_gettime (CLOCK_MONOTONIC_RAW, &before);
    for (size_t i = 0; i < NB_REP; i++)
        {
            x = sub_reduc (a, VEC_SIZE);
        }
    clock_gettime (CLOCK_MONOTONIC_RAW, &after);

    double sub_elapsed = (double)(after.tv_sec - before.tv_sec) * 1000000000
                         + (double)(after.tv_nsec - before.tv_nsec);

    // Affichage des mesures
    printf ("add = %10.0lf ns = %5.3lf s => %2.2lf %%\nsub = %10.0lf ns = "
            "%5.3lf s => %2.2lf %%\n",
            add_elapsed, add_elapsed / 1000000000,
            add_elapsed / (add_elapsed + sub_elapsed) * 100, sub_elapsed,
            sub_elapsed / 1000000000,
            sub_elapsed / (add_elapsed + sub_elapsed) * 100);

    // Ce dernier printf est obligatoire pour que le compilateur ne considère
    // pas les appels aux fonctions du dead code
    printf ("x = %f y = %f\n", x, y);

    free (a);

    return 0;
}
