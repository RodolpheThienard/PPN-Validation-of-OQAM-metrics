# Validation de la métrique `total time` pour OpenMP

Ces codes ont pour but de vérifier la détection de la topologie ainsi que de la mesure du temps par MAQAO.

## Compilation

Un simple `make` permet de compiler les binaires.

Le compilateur C peut être spécifier avec `CC=` et le compilateur FORTRAN avec `FORT=`.

## Execution

Des fichiers de configuration en lua sont présentes dans ce dossier pour permettre de lancer plusieurs runs avec scalabilité sur les binaires.

```bash
$ maqao oneview -R1 -WS -c=scalability-[].lua
```

Le fichier de configuration `schedule.lua` permet d'utiliser le multiruns de MAQAO pour tester le meilleur ordonnancement pour notre réduction.

### `reduc_omp`

```
USAGE: OMP_NUM_THREADS=n ./reduc_omp [taille_vecteur] nb_itérations
```
avec n le nombre de processus léger à lancer.

Ce programme calcule une réduction sur un vecteur dont la taille peut être spécifié en argument un nombre donné de fois.
La taille par défaut est 4096 flottants double précision (32 ko).
Il affiche sur la sortie standard le résultat. 

Il écrit dans un fichier `resultats.dat` le nombre de threads dans la première région parallèle (la seule si `OMP_NESTED` est faux) le temps d'exécution calculé avec `clock\_gettime` et `omp_get_wtime`.

### `reduc_omp_nested`

```
USAGE: OMP_NUM_THREADS=n OMP_NESTED=true ./reduc_omp_nested [taille_vecteur] nb_itérations nb_region_imbrique_dans_la_principale
```

Ce programme calcule une réduction sur un vecteur dont la taille peut-être spécifié en argument un nombre donné de fois.
Il fait cette réduction en arbre en créant un nouvelle région parallèle à chaque invocation jusqu'à atteindre le nombre de régions imbriquées spécifiées.
Il affiche sur la sortie standard le résultat.

Il écrit dans un fichier `resultats.dat` le nombre de threads créés en théorie et les temps d'exécution comme précédemment.

### `reduc_omp_fort`

```
USAGE: OMP_NUM_THREADS=n ./reduc_omp_fort [nombre_itérations]
```

Ce programme calcule une réduction sur un vecteur de 8092 entiers (32 ko) un nombre qui peut être spécifié de fois (par défaut 500 000).
Il affiche sur la sortie standard le résultat.

Il écrit dans un fichier `resultats.dat` le nombre de threads dans la région parallèle et le temps d'exécution calculé à l'aide de `OMP_GET_WTIME`.
