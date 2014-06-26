portugolphp: sintatico.c lexico.c tabela.c
	g++ -o portugolphp sintatico.c lexico.c tabela.c -lfl -lm

create: portugolphp
	./portugolphp <portugol.prg> codigophp.php

recreate: portugolphp
	rm codigophp.php
	./portugolphp <portugol.prg> codigophp.php

sintatico.c: sintatico.y tabela.c
	bison -v -d sintatico.y
	mv sintatico.tab.h sintatico.h
	mv sintatico.tab.c sintatico.c

lexico.c: lexico.l sintatico.c
	flex lexico.l 
	mv lex.yy.c lexico.c

clean:
	rm sintatico.c sintatico.h lexico.c rm portugolphp rm codigophp.php
