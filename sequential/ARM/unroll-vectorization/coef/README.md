# Coefficient de vectorisation
Maqao nous fournit plusieurs coefficient dans oneview dans la rubrique
mesures globales. Je role de ce test est de valider ou non la partie
concernant la vectorisation. Pour se faire, nous avons utiliser la
fonction rdtsc. Nous avons 2 fonctions, l'une faisant une axpy a partir
de double et la seconde utilisant des intrinsics avec de l'AVX512, ses 
registres ZMM et des FMA.

## Compilation
`make coef`

## Utilisation
`./a.out n` 
avec n un nombre choisit ( prendre un nombre suppérieur à 10e9) 

## Test
Voici des valeurs de coefficient obtenues :

Maqao = 3.8
Calculé = 3.5
