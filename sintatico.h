/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_SINTATICO_TAB_H_INCLUDED
# define YY_YY_SINTATICO_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    ALGORITMO = 258,
    FIM_ALGORITMO = 259,
    I_COMENTARIO = 260,
    F_COMENTARIO = 261,
    MAIS = 262,
    MENOS = 263,
    MULTI = 264,
    DIV = 265,
    IGUAL = 266,
    MAIOR = 267,
    MENOR = 268,
    MAIOR_IGUAL = 269,
    MENOR_IGUAL = 270,
    DIFERENTE = 271,
    ATRIBUICAO = 272,
    OU_EXCL = 273,
    OU = 274,
    NAO = 275,
    E = 276,
    PONTO_VIRGULA = 277,
    VIRGULA = 278,
    CHAVE_ESQUERDA = 279,
    CHAVE_DIREITA = 280,
    PAR_ESQ = 281,
    PAR_DIR = 282,
    COLCHETE_ESQUERDO = 283,
    COLCHETE_DIREITO = 284,
    INTERROGACAO = 285,
    TAB = 286,
    FIM_LINHA = 287,
    INTEIRO = 288,
    DECIMAL = 289,
    CARACTERE = 290,
    TIPO_STRING = 291,
    INCLUA = 292,
    DEFINA = 293,
    LER = 294,
    MOSTRA = 295,
    ENQUANTO = 296,
    FACA = 297,
    FIM_ENQUANTO = 298,
    PARA = 299,
    DE = 300,
    ATE = 301,
    PASSO = 302,
    INCREMENTO = 303,
    FIM_PARA = 304,
    REPITA = 305,
    SE = 306,
    ENTAO = 307,
    SENAO = 308,
    FIM_SENAO = 309,
    FIM_SE = 310,
    ESCOLHA = 311,
    CASO = 312,
    PARE = 313,
    CASO_CONTRARIO = 314,
    FIM_ESCOLHA = 315,
    IDENTIFICADOR = 316,
    REAL = 317,
    FRASE = 318,
    NUMERO = 319
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_SINTATICO_TAB_H_INCLUDED  */
