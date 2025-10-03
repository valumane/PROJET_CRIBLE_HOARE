%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"

extern int CodeDossier;
extern int NbPlaces;

void yyerror(char *);
int yylex(void);
%}

%token DOSSIER CODEDOSSIER RC PRENOMNOM 
%token CODECONCERT NOMCONCERT DATE HEURE NB PLACES
%start entete

%%

entete : DOSSIER CODEDOSSIER RC PRENOMNOM RC concertList
         {
           printf("Le dossier %d concerne %d places\n", CodeDossier, NbPlaces);
         }
       ;

concertList :
            | concertList concert
            ;

concert : CODECONCERT NOMCONCERT DATE HEURE NB PLACES RC ;

%%

#include "lex.yy.c"

int main() {
    return yyparse();
}

void yyerror(char *s) {
    fprintf(stderr, "Erreur : %s\n", s);
}