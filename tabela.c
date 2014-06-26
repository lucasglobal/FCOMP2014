#include "tabela.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void debugMensagens(const Tabela* tabela, const char* mensagem){
	if (tabela == NULL){
		return;}
	if (tabela->debugOpcao > 0){
		printf("%s\n", mensagem);}
	else {}
}

void mostrarCodigo(char* codigo, int parse_2) {
	if (parse_2) {
		printf("%s", codigo);}
}

Tabela* criarTabela(Simbolo* cabeca, int debugOpcao){
	Tabela* tabela = reinterpret_cast<Tabela *>(calloc(1, sizeof(Tabela)));
	tabela->cabeca = cabeca;
	if(debugOpcao > 0){
		tabela->debugOpcao = debugOpcao;}
		else {
		tabela->debugOpcao = 0;}
	return tabela;
}

void mostrarTabela(const Tabela *tabela) {
	Simbolo *atual;
	int i;
	debugMensagens(tabela, "PrintTable {\n");
	if (tabela == NULL){
		return;}
	if(tabela->debugOpcao > 0){
		for (atual = tabela->cauda, i = 0; atual; atual = atual->anterior, i++) {
			mostrarSimbolo(atual, i);}
		debugMensagens(tabela, "} PrintTable \n");}
}

void deletarTabela(Tabela* tabela){

	if(!tabela){
		return;}

	Simbolo* atual;
	Simbolo* temp = tabela->cauda;
	for(atual = tabela->cauda; atual; atual = temp->anterior){
		temp = temp->anterior;
		deletarSimbolo(atual);}
	free(tabela->cabeca);
	free(tabela->cauda);
	free(temp);
	free(tabela);
}

Simbolo* criarSimbolo(Simbolo* anterior,char* tipo, char* nome,char* valor, char* valorRetorno, int escopo){

	Simbolo* atual = reinterpret_cast<Simbolo *>(calloc(1, sizeof(Simbolo)));
		atual->tipo = tipo;
		atual->nome = nome;
		atual->valor = valor;
		atual->valorRetorno = valorRetorno;
		atual->escopo = escopo;
		atual->anterior = anterior;

	return atual;
}

void inserirSimbolo(Tabela* tabela, Simbolo* simbolo){
	if(tabela == NULL || simbolo == NULL){
		return;}
	if(tabela->cauda == NULL){
		tabela->cauda = simbolo;
		return;}
	simbolo->anterior = tabela->cauda;
	tabela->cauda = simbolo;
}

void mostrarSimbolo(const Simbolo* atual, int posicao){

	printf("	Posicao %d (%p):\n\
	tipo = %s\n\
	nome = %s\n\
	valorRetorno = %s\n\
	escopo = %d\n\
	valor = %s\n\
	anterior = %p\n\n", posicao, (void *) atual,atual->tipo,atual->nome,atual->valorRetorno,atual->escopo,atual->valor,
								 (void *) atual->anterior);
}

void deletarSimbolo(Simbolo* simbolo){
	free(simbolo->nome);
	free(simbolo->valor);
	free(simbolo->valorRetorno);
	free(simbolo);
}

int inserirVariavel(Tabela* tabela, char* tipo, char* nome,
		char* valor, char* valorRetorno, int escopo){

	debugMensagens(tabela, "InserirVariavel {\n");
	if (tabela == NULL){
		debugMensagens(tabela, "Funcao nao declarada\n");
		return FUNCAO_NAO_DECLARADA;}

	Simbolo* variavel = encontrarNome(tabela, nome);
	if (variavel != NULL && escopo == variavel->escopo) {
	debugMensagens(tabela, "Variavel ja declarada\n");
	return VARIAVEL_JA_DECLARADA;}
		else {
		variavel = criarSimbolo(tabela->cauda, tipo, nome, valor, valorRetorno, escopo);
			if (variavel == NULL){
			debugMensagens(tabela, "Simbolo nao inicializado\n");
			return SIMBOLO_NAO_INICIALIZADO;}
		inserirSimbolo(tabela, variavel);
		encontrarNome(tabela, nome);	
	}
	debugMensagens(tabela, "} InserirVariavel OK\n");
}

int definirVariavel(const Tabela* tabela, const char* nome, char* valor){
	Simbolo* variavel = encontrarNome(tabela, nome);
	if(variavel == NULL){
		debugMensagens(tabela, "Variavel nao declarada\n");
		return VARIAVEL_NAO_DECLARADA;
	}

	variavel->valor = valor;
}

Simbolo* encontrarNome(const Tabela* tabela, const char* nome) {
	debugMensagens(tabela, "	EncontrarNome {");
	if(!tabela){
		return NULL;}
	if(strcmp(nome, "") == 0){
		return NULL;}
	Simbolo* atual = NULL;
		for(atual = tabela->cauda; atual; atual = atual->anterior){
			if(strcmp(atual->nome, nome) == 0){
			break;}}
	debugMensagens(tabela, "	} EncontrarNome OK.\n");
	return atual;
}
