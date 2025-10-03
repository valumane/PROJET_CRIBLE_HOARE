%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(char *);
int  yylex (void);
%}

/* définit que nb transporte un int */
%union { int nb; }

%token DOSSIER CODEDOSSIER PRENOMNOM
%token CODECONCERT NOMCONCERT DATE HEURE
%token <nb> NB
%token RC PLACES TIR

/* demande et listPlaces sont des entiers (type nb / int) */
%type  <nb> demande listPlaces

%start entete
%%

entete : DOSSIER CODEDOSSIER RC PRENOMNOM RC concertList ;

concertList : concert
            | concertList concert
            ;

demande : NB { $$ = $1; }  
				;

/*             1           2      3     4      5      6    7       8     9 */
concert : CODECONCERT NOMCONCERT DATE HEURE demande PLACES RC listPlaces RC
          {
            if ($5 != $8) { /* test si somme = nb */
               yyerror("nombre de places incohérent");
               YYERROR; /* force l'arret   */
          }
           /*printf("-> demande : %d places, liste : %d numéros\n", $5, $8);*/	}
        ;

listPlaces : NB { $$ = 1; }
           | listPlaces TIR NB { $$ = $1 + 1; }
           ;
%%
int main(void)
{
    if (yyparse() == 0){
        printf("La commande est valide\n");
    return 0;
		}
}
void yyerror(char *s){ fprintf(stderr,"Syntax error : %s\n", s); }
