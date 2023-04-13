# Validation des métriques de MAQAO 

## INTRODUCTION

[MAQAO](http://maqao.org/) (Modular Assembly Quality Analyzer and Optimizer) est un outil d'analyse statique et dynamique de code. 
Il travaille au niveau du binaire pour aider les développeurs à améliorer les performances de leur application.

Pour cela, il collecte des données sur le binaire analysé et l'exécution de ce dernier.
Le but de ce projet scolaire est de valider les mesures et conclusions faites par MAQAO.

Ce dépôt contient des benchmarks permettant de tester les différentes fonctionnalités de MAQAO.

## USAGE

Les benchmarks sont séparés selon si ils sont séquentiels ou parallèles (afin de correspondre aux objectifs des différents semestres).
Chaque dossier contient le code source de benchmarks qui peut être compilé en utilisant la commande

```bash
$ make
```

La manière principale que nous avons utilisé pour faire une analyse avec MAQAO est grâce à la commande

```bash
$ maqao oneview -R1 -- <executable>
```

Certains tests nécessitent l'utilisation d'un fichier de configuration qui peut être passé à l'outil en utilisant 

```bash
$ maqao oneview -R1 -c=<config-file>
```

Pour plus de détails sur l'utilisation de MAQAO, vous pouvez vous rediriger vers le site [](http://maqao.org/) ou les pages de manuel de celui-ci.

Pour plus de détails sur les différents codes, un `README.md` se trouve dans chaque dossier.

## CRÉDITS

MAQAO est développé par **MAQAO team**.

Notre projet de validation est encadré par **Emmanuel Oseret** et **Cédric Valensi** de l'équipe MAQAO.

## AUTEURS

- Corentin BEAULIEU
- Zakaria  EJJED
- Ny Aina  PEDERSEN
- Rodolphe THIENARD
