%{
#include<iostream>
#include<string>

using namespace std;

extern int yylex(void);
extern int yyparse(void);
extern void yyerror(const char *s);

extern FILE *dotcode;
extern FILE *traducao;
%}

/* Tokens */
%token EQ       /* == */
%token GE       /* >= */
%token LE       /* == */
%token GT       /* >  */
%token LT       /* <  */
%token NE       /* != */

%token SOMA     /* + */
%token SUB      /* - */
%token MULT     /* * */
%token DIV      /* / */
%token MOD      /* % */

%token AND      /* and */
%token OR       /* or  */
%token NOT      /* not */

%token ATR      /* |=      */
%token READ     /* read()  */
%token WRITE    /* write() */
%token CIN      /* >> */
%token COUT     /* << */

%token IF 
%token ELSE

%token WHILE
%token FOR

%token COMMENT    /* # */
%token ABREC      /* { */
%token FECHAC     /* } */
%token ABREP      /* ( */
%token FECHAP     /* ) */
%token SEPARADOR  /* , */
%token FIML       /* . */

%token ID        /* VARIAVEL */
%token FUNC_ID   /* IDIFICADOR DE FUNÇÕES */

%token TIPOINT    /* tipo INT */
%token TIPOREAL   /* tipo FLOAT */
%token TIPOLETRA  /* tipo CHAR */
%token STRING     /* tipo STRING */

%token INT      /* INT */
%token REAL     /* REAL */
%token LETRA    /* LETRA */
%token TRUE     /* TRUE */
%token FALSE    /* FALSE */

%token INICIO   /* begin  */
%token FIM      /* end    */
%token RETURN   /* return */
%token BREAK    /* break  */

%left SOMA SUB
%left MULT DIV

%%

inicio: funcao INICIO programa FIM
        | INICIO programa FIM
;

funcao: tipo FUNC_ID ABREP FECHAP
        | tipo FUNC_ID ABREP parametros FECHAP
;

parametros:     tipo ID
                | tipo ID SEPARADOR parametros
;
programa:   comandos programa
            | comandos
;

comandos:   atribuicao
            | declaracao
            | entrada
            | saida
            | if_comando 
            | for_comando
            | while_comando 
            | RETURN exp FIML
            | BREAK FIML
            | COMMENT
;

tipo:   INT
        | REAL
        | LETRA
;

declaracao: tipo ID FIML
            | tipo ID ATR exp FIML
;

atribuicao: ID ATR exp FIML 
;

exp:    exp aritmetico exp
        | ABREP exp FECHAP
        | ID
        | TIPOINT
        | TIPOREAL
        | TIPOLETRA
        | STRING
        | TRUE
        | FALSE
;

aritmetico: SOMA
            | SUB   
            | MULT
            | DIV
            | MOD
;

entrada:    READ entrada_exp FIML
;

entrada_exp:    ID
                | entrada_exp CIN entrada_exp
; 

saida:  WRITE saida_exp FIML
;

saida_exp: exp
           | saida_exp COUT saida_exp
;

teste:  ABREP teste FECHAP
        | teste relacional teste 
        | teste logico teste
        | NOT teste
        | exp
;

relacional: EQ
            | GE
            | LE
            | GT
            | LT
            | NE
;

logico: AND
        | OR
;

if_comando: IF ABREP teste FECHAP ABREC programa FECHAC 
    		|  IF ABREP teste FECHAP ABREC programa FECHAC ELSE if_comando
		|  IF ABREP teste FECHAP ABREC programa FECHAC ELSE ABREC programa FECHAC
;

while_comando:  WHILE ABREP teste FECHAP ABREC programa FECHAC 
;

for_comando:    FOR ABREP atribuicao_for SEPARADOR teste SEPARADOR exp FECHAP ABREC programa FECHAC
;

atribuicao_for: ID ATR exp
                | tipo ID ATR exp
;

%%

void yyerror(const char * s) {
        extern int yylineno;    
	extern char * yytext;   
	
  cout << "Erro (" << s << "): simbolo \"" << yytext << "\" (linha " << yylineno << ")\n";
}