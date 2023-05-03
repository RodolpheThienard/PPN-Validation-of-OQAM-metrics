#Etude des bottlenecks
Les bottlenecks, ou goulot d'étranglements sont dû à un surmenage d'une unité de calcul ou de la mémoire, cela provoque un ralentissement du programme. Ici on étudie d'abord les bottlenecks dans un nbody 2D qui se révèlent être provoqués par un nombre de sqrt trop grand, puis on provoque un bottleneck en surchageant les divisions dans div.c et on suit les directives de MAQAO.

On utilise les commandes suivantes pour compiler le nbody et/ou div.c:
```bash
#Pour compiler les 2 programmes
make
#Pour le nbody
make nbody
#Pour le programme surchargeant les divisions
make div
```
