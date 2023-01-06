# Test du jeu d'instructions x87

Cette batterie de tests permet de vérifier que MAQAO identifie correctement
les instructions flottantes du jeu x87, qui est moins performant que celles
issues des jeux d'instructions SSE ou AVX.

Il s'agit d'une collection de fonctions qui sont implémentées avec des
instructions x87.

La sortie CQA pour chaque binaire est transmise à grep, qui va vérifier
que le message notifiant de la présence d'instructions x87 est bien
présent.

Pour lancer le test, utiliser la commande suivante:

```
$ ./run_tests.sh
```
