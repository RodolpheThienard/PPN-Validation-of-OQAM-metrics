# Vérification des points chauds (hotpoints)

Les points chauds sont les parties du code qui demande le plus 
de temps lors de l'exécution. Pour vérifier les points chauds,
nous avons mis en place une vérification sur un code dgemm. Les points
chaud sont verifiés grace aux nombres d'instructions. Pour se faire,
nous avons encadré chaque fonction de calcul d'une fonction nommée 
rdtsc : 
```c
unsigned long long rdtsc(void)
{
    unsigned long long a, d;

    __asm__ volatile("rdtsc"
                     : "=a"(a), "=d"(d));

    return (d << 32) | a;
}```
Ce code permet de donner à un moment T, le numéro de l'instruction 
actuel. Pour se faire, on recupère simplement la valeur du compter du
cpu.

## Utilisation
Compilation :
`make main`

Test manuel :
`./a.out 256 256`

Test maqao : 
`maqao oneview -sampling-rate=high -R1 -xp=cover -- ./a.out 256 256`
