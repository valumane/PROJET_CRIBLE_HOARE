%{
#include<stdio.h>
#include<stdlib.h>
void yyerror(char *);
int yylex(void);
%}
%token DOSSIER CODEDOSSIER RC PRENOMNOM 
%token CODECONCERT NOMCONCERT DATE HEURE NB PLACES
%start entete
%%
entete : DOSSIER CODEDOSSIER RC PRENOMNOM RC concertList
	     ;

concertList :
						| concertList concert
				 		;

concert : CODECONCERT NOMCONCERT DATE HEURE NB PLACES RC 
	      ;

%%

#include "lex.yy.c"

int main(){	
	if(yyparse()==0){
		printf("La commande est valide\n");
	}
	return 0;
}