# Tests de déroulage et de vectorisation

Cette batterie de tests nous permet de vérifier la cohérence des informations
de déroulage et de vectorisation fournies par MAQAO.

Il s'agit d'une collection de routines d'algèbre linéaire (daxpy dotprod reduc).

Pour chaque routine, plusieurs versions avec différents facteurs de déroulage
sont fournies. Les boucles sont déroulées en utilisant le bon `pragma` associé
au compilateur utilisé.

## macros

Certains macros permettent de modifier le fonctionnement des routines:

- `VECTORIZE` protège les macros de vectorisation (`pragma`).
- `ALIGN_PTR` protège les macros d'alignement (`__builtin_assume_aligned`).
- `ALIGNMENT` définit les alignements de pointeurs (à utiliser avec `ALIGN_PTR`).

## compilation

Le code peut être compilé avec `make`.

Les variables de `make` suivantes sont exposées:

- ALIGNMENT: puissance de 2 qui définit l'alignement des pointeurs (32 comme
  valeur de défaut)
- ALIGN_PTR: booléen représentant l'alignement des pointeurs (false comme valeur
  de défaut)
- VECTORIZE: booléen représentant l'utilisation de la vectorisation (false
  comme valeur de défaut)
- ARCH: architecture de la machine cible (Haswell comme valeur de défaut)
- CC: compilateur à utiliser pour compiler les fichiers sources (gcc comme
  valeur de défaut)
- OLVL: niveau d'optimisation (3 comme valeur de défaut)
- CFLAGS: options de compilation données au compilateur C

## oracle `lua`

Un oracle `lua` est disponible. Ce dernier essaie de déterminer la valeur du
coefficent de déroulage de la boucle 0 du binaire donné en argument. Il s'agit
d'un oracle partiel qui suppose qu'il y a un accès régulier en mémoire dans la
boucle. Ainsi, en analysant les instructions `ADD` et `SUB`, it peut deviner le
coefficent de déroulage.

Notons qu'il s'agit d'un oracle partiel, et donc que la sortie n'est pas
garantie pour toute boucle ou pour tout compilateur.

Pour lancer l'oracle:

```
maqao oracle path/to/binary
```
