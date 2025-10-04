============================================================
Mini-projet Lex/Yacc – L2 Info 2024-2025
Monôme : Lucas
============================================================

1. Contenu de l’archive
----------------------
Exo.1.1.lex          # analyse lexique – affichage de tous les tokens  
Exo.1.2.lex          # idem + comptage de concerts  
Exo.2.1.lex/yacc     # validation simple d’une commande  
Exo.2.2.lex/yacc     # validation + total de places  
Exo.2.3.lex/yacc     # version « n° de places »  
Makefile             # tout compiler / tester / nettoyer  
commandeBillet.txt   # jeu d’essai pour Exo 1.x et 2.1–2.2  
Lucas.*         # jeu d’essai pour Exo 2.3  
Lucas.ExplicationPlaces.txt   # explication des choix de syntaxe pour les n° de place  
Lucas.exempleCommande.txt     # exemple conforme à cette syntaxe  
README.txt (ce fichier)


2. Prérequis rapides
--------------------
- lex / yacc / gcc / make  
- Testé sous Ubuntu 22.04.5  LTS


3. Compiler / exécuter
----------------------
Tout compilé et executé :  
    $ make              		# enchaîne les 5 exos et lance les tests

Un seul exercice :  
    exemple : $ make 2.2    # n’exécute que la cible 2.2 (Exo.2.2.*)

Nettoyer (enlever .out, y.tab.*, lex.yy.c) :  
    $ make clean

4. Que fait chaque cible ?
--------------------------
1.1  → lit *commandeBillet.txt*, affiche la suite exacte  
       « dossier codeDossier RC … FinFichier ».  
1.2  → même entrée ; imprime « PrenomNom a acheté … concerts ».  
2.1  → valide simplement la syntaxe ; « La commande est valide ».  
2.2  → valide + affiche « Le dossier XXXXXXXX concerne NN places ».  
2.3  → valide la variante avec liste de numéros de places.


5. Exemples express
-------------------

$ cat commandeBillet.txt | ./Exo.2.2.out
Le dossier 12345678 concerne 17 places


6. Mini-explication : comprendre le Makefile
-----------------------------------------
all : 1.1 1.2 2.1 2.2 2.3  
   – cible par défaut exécutée quand on tape simplement `make`.

1.1 : Exo.1.1.lex  
   – flex -> *lex.yy.c*  
   – gcc  -> Exo.1.1.out  
   – exécution automatique du test (cat commandeBillet.txt | …)

Schéma des autres cibles :  
   *lex* seul  →  lex + cc    (1.1, 1.2)  
   *lex + yacc* → yacc(-d) + flex + cc (2.x)  
   L’option -ll lie la librairie de lex (fonction yywrap)  
   L’option -ly lie la librairie de yacc.

7. aide :
----------
chatgpt : generation du readme
fichier presentation lex et yacc : updago
presentation make : updago
aide lex : https://www.epaperpress.com/lexandyacc/ 
aide yacc ( Exo.2.1 et 2.3 pour creation du y.tab.h ) : https://www.gnu.org/software/bison/manual/bison.pdf

