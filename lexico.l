%{
#include "global.h"
#include "sintatico.h"
#include "string.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define YY_DECL extern int yylex()
%}


branco 			[ \t]+
digito 			[0-9]
numero 			{digito}+
real 			[+-]?[0-9]+([.,][0-9]+)?([Ee][+-]?[0-9]+)?

caractere 		[a-zA-Z]
frase 			\"[a-zA-Z0-9].*\"

identificador 	{caractere}(_|{caractere}|{digito})*

%%
"algoritmo" 			return(ALGORITMO);
"fim-algoritmo"			return(FIM_ALGORITMO);


"/*"					return(I_COMENTARIO);
"*/"					return(F_COMENTARIO);

"+"					 	return(MAIS);
"-" 					return(MENOS);
"*"						return(MULTI);
"/" 					return(DIV);

"="						return(IGUAL);
">"						return(MAIOR);
"<" 					return(MENOR);
">=" 					return(MAIOR_IGUAL);
"<=" 					return(MENOR_IGUAL);
"!=" 					return(DIFERENTE);
":="					return(ATRIBUICAO);

"^"					 	return(OU_EXCL);
"ou" 					return(OU);
"nao" 					return(NAO);
"e" 					return(E);

";"						return(PONTO_VIRGULA);
"," 					return(VIRGULA);

"{"						return(CHAVE_ESQUERDA);
"}"						return(CHAVE_DIREITA);
"("						return(PAR_ESQ);
")"						return(PAR_DIR);
"[" 					return(COLCHETE_ESQUERDO);
"]" 					return(COLCHETE_DIREITO);
"?"						return(INTERROGACAO);

"\t"					return(TAB);
"\n"					return(FIM_LINHA);

"inteiro"				return (INTEIRO);
"real"					return (DECIMAL);
"caractere"				return (CARACTERE);
"texto"					return (TIPO_STRING);


"inclua"|"INCLUA"		return(INCLUA);
"defina"|"DEFINA"		return(DEFINA); 

"ler"					return(LER);
"mostrar"				return(MOSTRA);

"enquanto" 				return(ENQUANTO);
"faca" 					return(FACA);
"fim-enquanto" 			return(FIM_ENQUANTO);

"para"					return(PARA);
"de" 					return(DE);
"ate" 					return(ATE);
"passo"					return(PASSO);
"incremento"			return(INCREMENTO);
"fim-para" 				return(FIM_PARA);

"repita"				return(REPITA);

"se"					return(SE);
"entao"					return(ENTAO);
"senao"					return(SENAO);
"fim-senao"				return(FIM_SENAO);
"fim-se"				return(FIM_SE);

"escolha"				return(ESCOLHA);	 
"caso"					return(CASO);
"caso-contrario"	 	return(CASO_CONTRARIO);
"fim-escolha"			return(FIM_ESCOLHA);
"pare"					return(PARE);


{branco} { /* Ignora espaços em branco */ }

{numero} {
	yylval = (char*) malloc(sizeof(char)); 
	strcpy(yylval, yytext);
	return (NUMERO);
}

{real} {
	yylval = (char*) malloc(sizeof(char)); 
	strcpy(yylval, yytext);
	return (DECIMAL);	
}

{identificador} { 
	yylval = (char*) malloc(sizeof(char)); 
	strcpy(yylval, yytext);
	return (IDENTIFICADOR); 
}

{frase} {
	yylval = (char*) malloc(sizeof(char)); 
	strcpy(yylval, yytext);
	return (IDENTIFICADOR); 
}

%%


