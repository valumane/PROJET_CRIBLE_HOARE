%{
char prenomNom[100];
int nbConcerts = 0;
%}
/*base*/
entier 					 [0-9]
majuscule 			 [A-Z]+ 

/*prenomNom*/
nomComposer 		 {majuscule}\-{majuscule}
nomOuNomComposer ({majuscule}|{nomComposer})
PrenomNom        {nomOuNomComposer}\/{nomOuNomComposer}

codeconcert 		 T{entier}{2,6}

RetourChariot    (\r\n)|(\n)

%%
{PrenomNom}     {strcpy(prenomNom,yytext);}
{codeconcert}   {nbConcerts++;}
<<eof>>					{printf("%s a acheté des places de %d concerts.\n",prenomNom,nbConcerts);
				 		     return 0;
								}
{RetourChariot} 
.
%%