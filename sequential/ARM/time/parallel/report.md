# Validation du calcul en temps de Maqao pour les versions parallele.

## Pour le cas de Time.h
Afin de valider le calcul du temps de chacun des threads, on a mis en place
un calcul simple prennant 10sec(environ) par thread et ici ne cherchant pas
à vouloir démontrer la scalabilité, le temps de calcul est fixé pour tous.
On a également voulu vérifier les métriques en utilisant différents 
moyen pour faire du calcul en parallele. On a utilisé MPICC, OMP ainsi 
que pthread.h. Afin de correctement vérifier le temps, on a demander au 
programme de sortir explicitement le temps de calcul et on a vérifié avec
le temps fournit par maqao.

|Temps calculé pour 4 threads|pthread|omp|mpi
---|---|---|---
10.94|10.95|10.90|10.94

## Pour le cas du décompte des opérations
