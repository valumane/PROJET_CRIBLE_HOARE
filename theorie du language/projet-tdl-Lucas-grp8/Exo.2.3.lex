%{
#include "y.tab.h"

int est_bissextile(int annee) {
    return (annee % 4 == 0 && annee % 100 != 0) || (annee % 400 == 0);
}
%}

/*base*/
dossier 		     (D|d)(O|o)(S|s)(S|s)(I|i)(E|e)(R|r)
entier 					 [0-9]
codeDossier 		 {entier}{8}
RetourChariot    (\r\n)|(\n)
majuscule 			 [A-Z]+ 

/*prenomNom*/
nomComposer 		 {majuscule}\-{majuscule}
nomOuNomComposer ({majuscule}|{nomComposer})
PrenomNom        {nomOuNomComposer}\/{nomOuNomComposer}


codeconcert 		 T{entier}{2,6} 

/*nomConcert*/
motNC 	 				 ({majuscule}|{entier})+
blocNC 					 {motNC}+
nomconcert 			 ({blocNC}-)*{majuscule}{motNC}*(-{blocNC})*

/*date et heure*/
day 					   {entier}{2}
years						 {entier}{2}
ddm 						 {day}\/{entier}
ddmm						 {day}\/{entier}{2}
ddmyy						 {day}\/{entier}\/{years}
ddmmyy					 {day}\/{entier}{2}\/{years}
date						 {ddm}|{ddmm}|{ddmyy}|{ddmmyy}
heure						 {entier}{2}\:{entier}{2}

%%

{dossier}        {return DOSSIER ;}
{codeDossier}    {return CODEDOSSIER ;}
{RetourChariot}  {return RC ;}
{PrenomNom}      {return PRENOMNOM ;}
{codeconcert}    {return CODECONCERT ;}
{nomconcert}     {return NOMCONCERT ;}
[0-9]{1,2}       {yylval.nb = atoi(yytext); return NB;}/* chaque NB vaut 1 pour le comptage */
places           {return PLACES ;}
"-"					 		 {return TIR ;}
<<eof>>		 			 {return 0;}

{date} {
    int jour, mois, annee;
    int n;
    n = sscanf(yytext, "%2d/%2d/%2d", &jour, &mois, &annee);

    int erreur = 0;

		if (n == 3 || n == 2) 
		{
			if (mois < 1 || mois > 12 || jour < 1 || jour > 31) //mois negatif | mois > 12 | jour negatif | jour > 31
				erreur = 1;
			else if (mois == 2 && jour > 29)//février na jamais plus de 29 jours
    		erreur = 2; 
			else if (est_bissextile(annee) == 0 && mois == 2 && jour >28) //annee non bissextile mais fevrier depasse 28jour
				erreur = 3;
			else if ((mois == 4 || mois == 6 || mois == 9 || mois == 11) && jour > 30)  //avril juin sept nov mois a 30 jours
				erreur = 4;
    } else { erreur = 5; } //erreur format

    if (erreur) 
		{
			switch (erreur) 
			{
				case 1 ://erreur jour et moi
					fprintf(stderr, "Erreur : date impossible (%s)\n", yytext);
					break;
				case 2 ://erreur fevrier
					fprintf(stderr, "Erreur : pas plus de 29 jours en février (%s)\n", yytext);
					break;
				case 3 ://erreur annee bissextile
					fprintf(stderr, "Erreur : annee bissextile mais fevrier depasse 28jours (%s)\n",yytext);
					break;
				case 4 ://erreur mois
					fprintf(stderr, "Erreur : mois de 30 jours (%s)\n", yytext);
					break;
				case 5 ://erreur format
					fprintf(stderr, "Erreur : format date (%s)\n", yytext);
				break;
			}
			exit(1);
		}
		else {return DATE; } //print ""final""
}

{heure} {
		int heure, minute;
		int n;
		n=sscanf(yytext, "%2d:%2d", &heure, &minute);

		if(heure>23 || minute > 59 ){ //min<0 et heure<0 testé dans le lex 
			fprintf(stderr, "erreur heure (%s) \n",yytext);		
			exit(1);
		}
		else {return HEURE; }
}


{majuscule}(\-){2,}{majuscule} //evite les double+ tiret
[ \t\r]+			//evite les tab et espace
.

%%
