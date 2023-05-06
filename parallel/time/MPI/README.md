# Validation de la métrique `profiled time` pour MPI

Ces codes ont pour but de vérifier la bonne prise de mesure du temps de MAQAO ainsi que la bonne identification du nombre de processus MPI de manière générale.

## Compilation

Un simple `make` permet de compiler les binaires.

Pour pouvoir utiliser la version Intel de `mpifort`, il faut penser à utiliser la variable `MPIFORT=mpiifort`.

## Execution

Des fichiers de configuration en lua sont présents dans ce dossier pour permettre de lancer plusieurs runs avec scalabilité sur les binaires.

```bash
$ maqao oneview -R1 -WS -c=multi-mpi-[].lua
```

### `reduc_mpi`

```
USAGE: mpirun -np <nombre_processus> ./reduc_mpi [<taille_vecteur>] <nombre_itérations>
```

Ce programme calcule une réduction d'un vecteur dont la taille peut être spécifié en arguments un nombre donné de fois.
La taille par défaut est 4096 flottants double précision (32 ko).
Il affiche sur la sortie standard le résultat.

Il écrit dans un fichier `resultats.dat` le nombre de processus, le temps d'exécution du plus long calculé avec `clock\_gettime` et le temps d'exécution du plus long calculé avec `MPI_Wtime`.

### `reduc_mpi_alltimes`

```
USAGE: mpirun -np <nombre_processus> ./reduc_mpi_alltimes [<taille_vecteur>] <nombre_itérations>
```

Ce programme calcule une réduction d'un vecteur dont la taille peut être spécifié en arguments un nombre donné de fois.
La taille par défaut est 4096 flottants double précision (32 ko).
Il affiche sur la sortie standard le résultat.

Chaque processus écrit dans un fichier portant son pid comme nom (avec l'extension .dat) son temps d'exécution calculé avec `clock\_gettime` et `MPI\_Wtime`.


### `reduc_mpi_fort`

```
USAGE: mpirun -np <nombre_processus> ./reduc_mpi_fort
```

Ce programme calcule la réduction d'un vecteur de 8192 entiers (32 ko) 50 000 000 fois.
Il affiche sur la sortie standard le résultat.

Il écrit dans un fichier `resultats.dat` le nombre de processus et le temps d'exécution du processus le plus long calculé avec `MPI\_WTIME` 


### `reduc_mpi_fort_alltimes`

```
USAGE: mpirun -np <nombre_processus> ./reduc_mpi_fort
```

Ce programme calcule la réduction d'un vecteur de 8192 entiers (32 ko) 50 000 000 fois.
Il affiche sur la sortie standard le résultat.


Chaque processus écrit dans un fichier portant son pid comme nom (avec l'extension .dat) son temps d'exécution calculé avec `MPI\_WTIME`.
