# Tests de racines carrées (`sqrt`)

Les racines carrées sont des instructions complexes. En effet, le calcul
d'une racine carrée demande plusieurs micros opérations, et peut coûter
très cher.

Cette batterie de tests fournie des codes avec des instructions des jeux d'instructions
SSE et AVX. Le but est de vérifier que le rapport de CQA notifie l'utilisateur de la
présence des racines carrées.

## Compilation

La compilation de la batterie de test peut se faire avec la commande:

```bash
make
```

## Lecture des rapports de CQA

La partie importante du rapport CQA à vérifier concerne les racines carrées.
Une manière simple de lire directement ces informations peut être l'utilisation
de `grep`.

```bash
# pipe CQA ouput to grep
# read all lines that contain sqrt with 5 lines of context (before and after)
maqao cqa fct-body=_test conf=all ./target_binary | grep -i sqrt -C5
```
