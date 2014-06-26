#ifndef TABELA_H
#define TABELA_H

#define FUNCAO_NAO_DECLARADA -1
#define VARIAVEL_JA_DECLARADA -2
#define SIMBOLO_NAO_INICIALIZADO -3
#define VARIAVEL_NAO_DECLARADA -4

typedef struct simbolo {
	char* tipo;
	char* nome;
	char* valor;
	char* valorRetorno;
	int escopo;
	struct simbolo* anterior;
} Simbolo;

typedef struct tabela {
	Simbolo* cabeca;
	Simbolo* cauda;
	int debugOpcao;
} Tabela;

void debugMensagens(const Tabela* tabela, const char* mensagem);

void mostrarCodigo(char* codigo, int parse_2);

Tabela* criarTabela(Simbolo* cabeca, int debugOpcao);
void mostrarTabela(const Tabela *tabela);
void deletarTabela(Tabela* tabela);

Simbolo* criarSimbolo(Simbolo* anterior, char* tipo, char* nome, char* valor, char* valorRetorno, int escopo);
void inserirSimbolo(Tabela* tabela, Simbolo* simbolo);
void deletarSimbolo(Simbolo* simbolo);

Simbolo* encontrarNome (const Tabela* tabela, const char* nome);

int inserirVariavel(Tabela* tabela, char* tipo, char* nome, char* valor, char* valorRetorno, int escopo);
int definirVariavel(const Tabela* tabela, const char* nome, char* valor);

void mostrarSimbolo(const Simbolo* atual, int posicao);


#endif
