# Approximation des décimales de Pi à l'aide d'un algorithme de Monte Carlo

## Concept

L'aire du cercle unité (de rayon $r = 1$) est $\pi \times r \times r = \pi$.
En tirant aléatoirement des points dans le carré unité (de côté de longueur 1),
on peut ainsi approximer les décimales de Pi. En effet, plus le nombre de tirage
augmente, plus la proportion des points tirés appartenant également au cercle unité
se rapproche de Pi.

Dans notre cas, on réduit l'expérience au cadrant supérieur droit du carré unité.
Il suffit de multiplier la proportion trouvé par 4 pour trouver $pi$.

## Propriétés et phénomènes à observer avec `maqao`

Cette batterie de test offre un algorithme à scalabilité linéaire.
En effet, les algorithmes de Monte Carlo sont qualifiés de "embarrassingly parallel".
Aucune communication inter-processus n'est nécessaire pour résoudre les tâches.
Pour paralléliser ces algorithmes, il suffit de dupliquer les tirages aléatoires
sur les unités de calcul disponibles.

Sur `maqao`, on s'attend donc à des indices de scalabilité parfaits (proche de 1).
De plus, vu qu'il n'y aucune communication inter-processus et que le temps séquentiel
est négligeable, on s'attend à avoir des indices de distribution des tâches parfaits.

Cette batterie de test offre les fichiers de configuration `maqao` pour les tests de
scalabilité faible et forte. Ces fichiers de configuration sont disponibles dans
le sous-dossier `maqao_configs`. Notons qu'il peut être nécessaire d'adapter le
nombre de cœurs et la taille du problème en fonction de la machine.

## Compilation et utilisation

### Dépendances

Ce jeu de tests dépend d'`openMP`, de `pthread`, de `MPI` et de la `gsl` (GNU
Scientific Library). La `gsl` fournit une implémentation d'un générateur pseudo
aléatoire thread-safe, tandis que `openMP`, `pthread` et `MPI` permettent
d'implémenter les modèles parallèles et distribués. Une implémentation de
`cblas` est également nécessaire pour le bon fonctionnement de la `gsl`.

### Compilation

Un simple `make` permet de compiler les binaires `monte_carlo_mpi`,
`monte_carlo_omp`, `monte_carlo_pthread`, `monte_carlo_pthread_mpi` et
`monte_carlo_hybrid`. Ces binaires correspondent aux versions parallèles
implémentée de manière hybride ou non.

Pour tester plusieurs compilateurs la variable `CC` est définie: `make CC=clang`.

### Utilisation

Les deux binaires `monte_carlo_mpi` et `monte_carlo_omp` prennent comme argument
le nombre d'itérations.

Les runs `maqao` peuvent ainsi être lancés comme cela:

```bash
# Compilation avec clang
make CC=clang

# Rapport de la version OpenMP (scalabilité forte)
maqao oneview -WS --create-report=one --config=maqao_configs/config_omp_strong.lua

# Rapport de la version MPI (scalabilité faible)
maqao oneview -WS --create-report=one --config=maqao_configs/config_mpi_strong.lua

# Ou avec les recettes Make
make report_omp TEST=strong
make report_mpi TEST=weak
make report_pthread_mpi TEST=weak
make report_pthread TEST=strong

# Version locale de maqao
make report_mpi TEST=strong MAQAO=/path/to/maqao
```
