FILE1=Exo.1.1
FILE2=Exo.1.2
FILE3=Exo.2.1
FILE4=Exo.2.2
FILE5=Exo.2.3

all : 1.1 1.2 2.1 2.2 2.3

1.1: $(FILE1).lex
	@echo "\e[36m=============\e[0m"
	lex $(FILE1).lex
	cc lex.yy.c -o $(FILE1).out -ll
	@echo "$(FILE1) compilé -> ./$(FILE1).out"
	@printf "\e[33m->\e[0m "
	cat commandeBillet.txt | ./$(FILE1).out
	@echo "\e[36m=============\e[0m"


1.2 : $(FILE2).lex
		@echo "\e[36m=============\e[0m"
		lex $(FILE2).lex
		cc lex.yy.c -o $(FILE2).out -ll
		@echo "$(FILE2) compilé -> ./$(FILE2).out"
		@printf "\e[33m->\e[0m "
		cat commandeBillet.txt | ./$(FILE2).out
		@echo "\e[36m=============\e[0m"

2.1 : $(FILE3).yacc $(FILE3).lex
		@echo "\e[36m=============\e[0m"
		yacc $(FILE3).yacc
		lex $(FILE3).lex
		cc y.tab.c -o Exo.2.1.out -ly -ll
		@echo "$(FILE3) compilé -> ./$(FILE3).out"
		@printf "\e[33m->\e[0m "
		cat commandeBillet.txt | ./$(FILE3).out
		@echo "\e[36m=============\e[0m"
	

2.2 : $(FILE4).yacc $(FILE4).lex
		@echo "\e[36m=============\e[0m"
		lex $(FILE4).lex
		yacc -d $(FILE4).yacc
		cc y.tab.c -o Exo.2.2.out -ly -ll
		@echo "$(FILE4) compilé -> ./$(FILE4).out"
		@printf "\e[33m->\e[0m "
		cat commandeBillet.txt | ./$(FILE4).out
		@echo "\e[36m=============\e[0m"

2.3 : $(FILE5).yacc $(FILE5).lex
		@echo "\e[36m=============\e[0m"
		yacc -d $(FILE5).yacc
		lex $(FILE5).lex
		cc y.tab.c lex.yy.c -o $(FILE5).out -ly -ll
		@echo "$(FILE5) compilé -> ./$(FILE5).out"
		@printf "\e[33m->\e[0m "
		cat VadeGrelet.exempleCommande.txt | ./$(FILE5).out
		@echo "\e[36m=============\e[0m"

clean:
		rm -f *.out y.tab.c y.tab.h lex.yy.c
		@echo "fichier generé supprimé "
