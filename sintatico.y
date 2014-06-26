%{
#include "global.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tabela.h"

Tabela* tabela;
int debugOpcao;
int numeroLinha = 1;
int escopo = 0;
int tem_erro = 0;
int parse_2 = 0;

//Coisas do flex que o bison precisa
extern int yylex();
extern int yyparse();
extern FILE *yyin;

int yyerror(char *s);

%}
%token ALGORITMO FIM_ALGORITMO

%token I_COMENTARIO F_COMENTARIO

%token MAIS MENOS MULTI DIV

%token IGUAL MAIOR MENOR MAIOR_IGUAL MENOR_IGUAL DIFERENTE ATRIBUICAO

%token OU_EXCL OU NAO E

%token PONTO_VIRGULA VIRGULA 

%token CHAVE_ESQUERDA CHAVE_DIREITA PAR_ESQ PAR_DIR COLCHETE_ESQUERDO COLCHETE_DIREITO INTERROGACAO

%token TAB FIM_LINHA

%token INTEIRO DECIMAL CARACTERE TIPO_STRING

//Include e Define
%token INCLUA DEFINA

//Entrada e Saída
%token LER MOSTRA 

//While - repetição
%token ENQUANTO FACA FIM_ENQUANTO

//For - repetição
%token PARA DE ATE PASSO INCREMENTO FIM_PARA REPITA 

//IF - Condicional
%token SE ENTAO SENAO FIM_SENAO FIM_SE 

//switch - Condicional
%token ESCOLHA CASO PARE CASO_CONTRARIO FIM_ESCOLHA 

%token IDENTIFICADOR
%token REAL
%token FRASE
%token NUMERO


%start Entrada

%%

Entrada:
		| Entrada Linha
;


Linha:
	FIM_LINHA {
		numeroLinha++;
	}
	| ALGORITMO {
		Simbolo* main = criarSimbolo(NULL, "void", "main", "", "int", escopo);
		tabela = criarTabela(main, debugOpcao);
		mostrarCodigo("<?php\n",parse_2);
	}
	| Expressoes {
		mostrarTabela(tabela);
		mostrarCodigo("\n", parse_2);
	}
	| FIM_ALGORITMO{
		mostrarCodigo("\n?>",parse_2);
		if(!tabela){
			deletarTabela(tabela);
		}
	}
;

Expressoes:
	AtribuicaoExpressao
	| ExpressaoDeclaracao
	| Inclua
	| Mostra
	| Se
	| Enquanto
	| Para
	| Escolha
	| error FIM_LINHA{
		numeroLinha++;
		yyerrok;
	}
;

AtribuicaoExpressao:
	IDENTIFICADOR ATRIBUICAO AtribuicaoTipo {
		definirVariavel(tabela,$1,$3);
		char *atribuicao = (char*) malloc(sizeof(char));
		sprintf(atribuicao,"\n\t $%s = %s;", $1, $3);
		mostrarCodigo(atribuicao, parse_2);
	}
;

//Tipos para atribuicoes
AtribuicaoTipo:
	NUMERO {
		$$ = $1;
	}
	| DECIMAL {
		$$ = $1;
	}
	| FRASE {
		$$ = $1;
	}
;

ExpressaoDeclaracao:
	Tipo IDENTIFICADOR{
		inserirVariavel(tabela,$1,$2,NULL,NULL,escopo);
	}
	| Tipo IDENTIFICADOR ATRIBUICAO AtribuicaoTipo {
		inserirVariavel(tabela,$1,$2,$4,NULL,escopo);
		char *declaracao = (char*) malloc(sizeof(char));
		sprintf(declaracao,"\t $%s = %s;", $2,$4);
		mostrarCodigo(declaracao, parse_2);
	}
;

Tipo:
	INTEIRO{
		$$ = "int";
	}
	| DECIMAL{
		$$ = "float";
	}
	| TIPO_STRING{
		$$ = "string";
	}
	| CARACTERE{
		$$ = "char";
	}


//Reconhecimento dos comparadores para condição do if/while
Comparador:
	IGUAL {
		$$ = "==";
	}
	| MAIOR {
		$$ = ">";
	}
	| MENOR {
		$$ = "<";
	}
	| MAIOR_IGUAL {
		$$ = ">=";
	}
	| MENOR_IGUAL {
		$$ = "<=";
	}
	| DIFERENTE {
		$$ = "!=";
	}
;

//Reconhecimento dos elementos para laço for
Incremento:
	MAIS {
		$$ = "+";
	}
	| MENOS {
		$$ = "-";
	}
;

Parametro:
	IDENTIFICADOR Comparador IDENTIFICADOR {
		char *parametro = (char *) malloc (sizeof(char));
		strcat(parametro, "$");
		strcat(parametro, $1);
		strcat(parametro, " ");
		strcat(parametro, $2);
		strcat(parametro, " $");
		strcat(parametro, $3);
		$$ = parametro;
	}
;

//Identificador ou numero
Variavel: 
	IDENTIFICADOR {
		$$ = $1;
	}
	| NUMERO {
		$$ = $1;
	}
	| DECIMAL {
		$$ = $1;
	}
;

Inclua: //4
	INCLUA MENOR IDENTIFICADOR MAIOR
	{	
		char *inclua = (char*) malloc(sizeof(char));
		sprintf(inclua,"include('%s.php');", $3);
		mostrarCodigo(inclua,parse_2);
	}
;

Mostra: // DONE
	MOSTRA FRASE
	{
		char *string = (char*) malloc(sizeof(char));
		sprintf(string,"\n\techo %s;\n\techo\"<br>\";", $2);
		mostrarCodigo(string,parse_2);
	}
	| MOSTRA IDENTIFICADOR{
		Simbolo* variavel = encontrarNome(tabela, $2);
		if(variavel = NULL){
			printf("Erro! A variavel %s nao foi declarada!", $2);
			return VARIAVEL_NAO_DECLARADA;
		}
		char *string = (char*) malloc(sizeof(char));
		sprintf(string,"\n\techo %s ;\n\techo\"<br>\";", $2);
		mostrarCodigo(string,parse_2);
	}
;


Se: //DONE
	SE PAR_ESQ Parametro PAR_DIR ENTAO{
		char *se = (char*) malloc(sizeof(char));
		sprintf(se,"\n\tif( %s ){", $3);
		mostrarCodigo(se, parse_2);
		escopo++; 
	}
	| SENAO{
		char *senao = (char*) malloc(sizeof(char));
		sprintf(senao,"\n\telse{ ");
		mostrarCodigo(senao,parse_2);
		escopo++;
	}
	| FIM_SENAO{
		char *fimsenao = (char*) malloc(sizeof(char));
		sprintf(fimsenao,"\n\t}");
		mostrarCodigo(fimsenao,parse_2);
		escopo--;
	}
	| FIM_SE {
		char *fimse = (char*) malloc(sizeof(char));
		sprintf(fimse,"\n\t}");
		mostrarCodigo(fimse,parse_2);
		escopo--;
	}
;

Enquanto: //DONE
	ENQUANTO PAR_ESQ Parametro PAR_DIR FACA{
		char *enquanto = (char*) malloc(sizeof(char));
		sprintf(enquanto,"\n\twhile( %s ){", $3);
		mostrarCodigo(enquanto, parse_2);
		escopo++;
	}
	| FIM_ENQUANTO{
		char *fimenquanto = (char*) malloc(sizeof(char));
		sprintf(fimenquanto,"\n\t}");
		mostrarCodigo(fimenquanto,parse_2);
		escopo--;
	}
;

Para: //12
	PARA PAR_ESQ IDENTIFICADOR DE Variavel ATE Variavel PASSO IDENTIFICADOR Incremento PAR_DIR FACA{
		char *para = (char*)malloc(sizeof(char));
		sprintf (para,"\n\tfor($%s=%s ; $%s<%s ; $%s%s%s){", $3,$5,$3,$7,$9,$10,$10);
		mostrarCodigo(para, parse_2);
		escopo++;
	}
	| FIM_PARA{
		char *fimpara = (char*)malloc(sizeof(char));
		sprintf (fimpara,"\n\t}");
		mostrarCodigo(fimpara, parse_2);
		escopo--;
	}	
;

//switch - Condicional
//%token CASO CONDICAO IGUAL_A  CASO_CONTRARIO FIM_CASO 

Escolha: 
	ESCOLHA PAR_ESQ Variavel PAR_DIR{
		char *escolha = (char*) malloc(sizeof(char));
		sprintf(escolha,"\n\tswitch( $%s ){", $3);
		mostrarCodigo(escolha, parse_2);
		escopo++;	
	}
	|CASO Variavel{
		char *caso = (char*) malloc(sizeof(char));
		sprintf(caso,"\n\t\tcase %s:", $2);
		mostrarCodigo(caso, parse_2);
	}
	|PARE{
		char *pare = (char*) malloc(sizeof(char));
		sprintf(pare,"\t\tbreak;");
		mostrarCodigo(pare, parse_2);
	}
	| CASO_CONTRARIO{
		char *caso_contrario = (char*) malloc(sizeof(char));
		sprintf(caso_contrario,"\n\tdefault: ");
		mostrarCodigo(caso_contrario, parse_2);	
	}
	|FIM_ESCOLHA{
		char *fim_escolha = (char*) malloc(sizeof(char));
		sprintf(fim_escolha,"\n\t}");
		mostrarCodigo(fim_escolha, parse_2);
		escopo--;
	}
;
%%

int yyerror(char *s) {
	tem_erro = 1;
   	printf("Erro: %s, linha %d\n",s, numeroLinha);
}

int main(int argc, char *argv[]) {

	if(argv[1] != NULL){
		if(strcmp(argv[1], "-debug") == 0){ 
			debugOpcao = 1;
		} else {
			debugOpcao = 0;
		}
	}
	
	yyparse();	
	
	if (tem_erro == 0) {
		parse_2 = 1;
		fseek(stdin, 0, SEEK_SET);
		yyparse();
	} 

	exit(EXIT_SUCCESS); 
}
