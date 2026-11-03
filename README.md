# Crible de Hoare — Projet C avancé

Projet de Licence 3 Informatique, année 2025–2026, à l’Université de Poitiers, réalisé par Lucas et Leonard.

Ce programme détermine si un entier est premier à l’aide du **crible de Hoare**, une version du crible d’Ératosthène organisée en pipeline de processus. Il met en pratique la création de processus, les communications interprocessus et la synchronisation en C sous Linux.

Cette présentation s’appuie sur le [sujet du projet](cc2_projet.pdf), le [rapport](rapport.pdf) et le code du dossier [`src`](src/).

## Fonctionnement

Trois exécutables coopèrent :

- **`client`** interprète la commande de l’utilisateur, transmet une requête au master et affiche sa réponse.
- **`master`** crée les ressources de communication, lance le premier worker et coordonne les calculs. Il conserve le nombre de nombres premiers découverts et le plus grand d’entre eux.
- **`worker`** représente un nombre premier et filtre ses multiples. Les workers se créent en cascade avec `fork` et `exec` pour prolonger le pipeline.

```text
client ←── FIFO ──→ master ── tube ──→ worker(2) → worker(3) → worker(5) → …
                     ↑                      │           │           │
                     └──── tube de retour commun aux workers ───────┘
```

Chaque worker recevant un nombre `N` applique les règles suivantes :

1. Si `N` est son propre nombre premier, il signale un succès au master.
2. Si `N` est un multiple de son nombre premier, il signale un échec.
3. Sinon, il transmet `N` au worker suivant, ou crée ce worker s’il n’existe pas encore.

Le master envoie les entiers dans l’ordre : une demande portant sur `N` entraîne aussi le calcul des entiers intermédiaires encore inconnus. Par exemple, après avoir testé jusqu’à 10, une demande pour 17 fait passer les nombres de 11 à 17 dans le pipeline. Un nombre déjà testé peut être soumis à nouveau sans augmenter le compteur de nombres premiers.

## Prérequis et compilation

Utiliser Linux avec GCC, GNU Make et les bibliothèques système POSIX, notamment les threads `pthread` et les sémaphores System V. La commande `showworker` utilise également `ps` et `grep`.

Depuis la racine du dépôt :

```bash
cd prog-c/PROJET_CRIBLE_HOARE/src
make
```

Le Makefile produit `client`, `master` et `worker`, avec les options `-Wall -Wextra -pedantic -std=c99`, et lie les bibliothèques `m` et `pthread`.

## Utilisation

Lancer les programmes depuis **le même dossier `src`** : les exécutables, les FIFO et le fichier `master.c` utilisé par `ftok` sont référencés par des chemins relatifs. Utiliser une seule instance du master dans ce dossier.

Dans un premier terminal :

```bash
./master
```

Dans un second terminal, placé dans le même dossier :

```bash
./client compute 17
./client compute 25
./client howmany
./client highest
./client stop
```

Sur un master fraîchement lancé, cette séquence indique que 17 est premier, que 25 ne l’est pas, puis renvoie un compteur de **9** nombres premiers et un maximum de **23**.

| Commande | Rôle |
| --- | --- |
| `./client compute N` | Tester la primalité de l’entier `N`, avec `N >= 2`. |
| `./client howmany` | Afficher le nombre de nombres premiers découverts depuis le démarrage. |
| `./client highest` | Afficher le plus grand nombre premier découvert. |
| `./client stop` | Demander l’arrêt du master et du pipeline, puis la libération des ressources IPC. |
| `./client showworker` | Afficher les processus `worker` via `ps`. |
| `./client local N` | Afficher les nombres premiers jusqu’à `N`, sans utiliser le master. |

Au démarrage, le worker associé à 2 existe déjà : le compteur vaut donc 1 et le maximum vaut 2. Plusieurs clients peuvent envoyer des requêtes ; leurs échanges avec le master sont traités un par un.

### Mode local multithreadé

```bash
./client local 30
```

Ce mode fonctionne sans master et affiche les nombres premiers jusqu’à 30 : `2 3 5 7 11 13 17 19 23 29`.

Il utilise un tableau de booléens et un thread par diviseur de 2 à `floor(sqrt(N))`. Chaque thread marque les multiples de son diviseur ; un mutex commun protège les écritures dans le tableau. Ce choix de synchronisation est imposé par le sujet et limite le parallélisme.

## Communications et synchronisation

| Échange | Mécanisme | Données |
| --- | --- | --- |
| Client → master | FIFO `client_to_master.fifo` | Ordre, puis entier à tester si nécessaire. |
| Master → client | FIFO `master_to_client.fifo` | Résultat ou accusé de réception. |
| Master → premier worker | Tube anonyme | Entier à tester ou ordre d’arrêt `-1`. |
| Worker → worker suivant | Tube anonyme créé dynamiquement | Entier transmis ou ordre d’arrêt. |
| Workers → master | Tube anonyme commun | Nombre premier en cas de succès, `0` sinon. |

Deux sémaphores System V complètent les FIFO : `sem_mutex` réserve le dialogue à un seul client et `sem_sync` permet au master d’attendre que ce client ait terminé sa lecture. Pour l’arrêt, le master accuse réception de la commande puis transmet `-1` au pipeline ; chaque worker propage cet ordre et attend son successeur avant de terminer.

## Organisation des fichiers

| Fichier | Contenu |
| --- | --- |
| [`src/client.c`](src/client.c) | Analyse des arguments et dialogue côté client. |
| [`src/master.c`](src/master.c) | Initialisation, traitement des requêtes et gestion du pipeline. |
| [`src/worker.c`](src/worker.c) | Filtrage des nombres et création du worker suivant. |
| [`src/master_client.c`](src/master_client.c), [`src/master_client.h`](src/master_client.h) | Ordres, FIFO, sémaphores, affichage et calcul local multithreadé. |
| [`src/master_worker.c`](src/master_worker.c), [`src/master_worker.h`](src/master_worker.h) | Module d’interface entre master et workers. |
| [`src/myassert.c`](src/myassert.c), [`src/myassert.h`](src/myassert.h) | Assertions accompagnées de messages de diagnostic. |
| [`src/Makefile`](src/Makefile) | Compilation et nettoyage. |
| [`src/0README`](src/0README) | Instructions techniques fournies avec le projet. |
| [`src/rmsempipe.sh`](src/rmsempipe.sh) | Script de nettoyage manuel des ressources IPC. |

## Nettoyage et limites

Arrêter le système avec `./client stop` avant de nettoyer les fichiers compilés :

```bash
make clean       # Supprime les fichiers .o et .d
make distclean   # Supprime aussi les trois exécutables
```

Après une interruption brutale, des FIFO ou des sémaphores peuvent subsister. Le script `rmsempipe.sh` fourni supprime les deux FIFO et recherche les sémaphores de l’utilisateur ayant les droits `641`. Ce nettoyage peut aussi toucher les sémaphores d’autres programmes de l’utilisateur ayant les mêmes droits : vérifier les ressources concernées avant de lancer `bash rmsempipe.sh`, uniquement après l’arrêt des processus du projet.

Le pipeline conserve un processus par nombre premier découvert : les grandes valeurs peuvent atteindre les limites système de processus ou de descripteurs. Le projet est destiné à l’apprentissage des mécanismes système ; les exemples utilisent de petites valeurs.
