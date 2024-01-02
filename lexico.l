%{
  #include "sintatico.tab.h"
  #include<iostream>
  #include<string>

  using namespace std;

  extern int yylex(void);
  extern int yyparse(void);
  extern void yyerror(const char *s);
  
  FILE *dotcode;
  FILE *traducao;
  bool saida;
%}

%option yylineno

/* DEFINIÇÕES GERAIS */
letra[a-zA-Z]
digito[0-9]
especiais[\"!#$%^&*()+=,/?-]

/* SÍMBOLOS ESPECIAIS */
ponto[.]

%%

 /* BLOCOS DE COMANDO */
"begin" {
  fprintf(dotcode,"(%2d,INICIO,\"%s\")\n",yylineno,  yytext);
  fprintf(traducao, "int main() {\n\t"); 
  return INICIO;
}
"end"   {
  fprintf(dotcode,"(%2d,END,\"%s\")\n",yylineno,  yytext);
  fprintf(traducao, "\n\treturn 0; \n}"); 
  return FIM;
}
"{"     {
  fprintf(dotcode,"(%2d,ABREC,\"%s\")\n",yylineno,  yytext);
  fprintf(traducao, "{ \n\t"); 
  return ABREC;
}
"}"     {
  fprintf(dotcode,"(%2d,FECHAC,\"%s\")\n",yylineno,  yytext);
  fprintf(traducao, "} "); 
  return FECHAC;
}
"("     {
  fprintf(dotcode,"(%2d,ABREP,\"%s\")\n",yylineno,  yytext);
  fprintf(traducao, "("); 
  return ABREP;
}
")"     {
  fprintf(dotcode,"(%2d,FECHAP,\"%s\")\n",yylineno,  yytext);
  fprintf(traducao, ")"); 
  return FECHAP;
}

 /* CONDICIONAIS */
"if"    {
    fprintf(dotcode,"(%2d,IF,\"%s\")\n",yylineno,  yytext);
    fprintf(traducao, "\nif"); 
    return IF;
}
"else"  {
    fprintf(dotcode,"(%2d,ELSE,\"%s\")\n",yylineno,  yytext);
    fprintf(traducao, "\n\telse "); 
    return ELSE;
}

 /* ITERATIVOS */
"while" {
    fprintf(dotcode,"(%2d,WHILE,\"%s\")\n",yylineno,  yytext);
    fprintf(traducao, "\n\twhile"); 
    return WHILE;
}
"for"   {
    fprintf(dotcode,"(%2d,FOR,\"%s\")\n",yylineno,  yytext);
    fprintf(traducao, "\n\tfor"); 
    return FOR;
}

 /* ENTRADA/SAÍDA DE DADOS */
"read"  {
    fprintf(dotcode,"(%2d,READ,\"%s\")\n",yylineno, yytext);
    fprintf(traducao, "cin >>"); 
    return READ;
}
"write" {
    fprintf(dotcode,"(%2d,WRITE,\"%s\")\n",yylineno, yytext);
    fprintf(traducao, "cout << "); 
    return WRITE;
}
 /* Comandos auxiliares para entrada e saída de dados em C++ */
">>"    {
    fprintf(dotcode,"(%2d,CIN,\"%s\")\n",yylineno, yytext);
    fprintf(traducao, " >> "); 
    return CIN;
}
"<<"    {
    fprintf(dotcode,"(%2d,COUT,\"%s\")\n",yylineno, yytext);
    fprintf(traducao, " << "); 
    return COUT;
}

 /* TIPOS DE DADOS */
"int"   {
    fprintf(dotcode,"(%2d,INT,\"%s\")\n",yylineno, yytext);
    fprintf(traducao, "int "); 
    return INT;
}
"real"  {
    fprintf(dotcode,"(%2d,REAL,\"%s\")\n",yylineno, yytext);
    fprintf(traducao, "float "); 
    return REAL;
}
"letra" {
    fprintf(dotcode,"(%2d,LETRA,\"%s\")\n",yylineno, yytext);
    fprintf(traducao, "char "); 
    return LETRA;
}

 /* ARITMÉTICOS */
"+" {
    fprintf(dotcode,"(%2d,SOMA,\"%s\")\n",yylineno, yytext);
    fprintf(traducao, "+ "); 
    return SOMA;
    }
"-" {
    fprintf(dotcode,"(%2d,SUB,\"%s\")\n",yylineno, yytext);
    fprintf(traducao, "- "); 
    return SUB;
    }
"*" {
    fprintf(dotcode,"(%2d,MULT,\"%s\")\n",yylineno, yytext);
    fprintf(traducao, "* ");
    return MULT;
}
"/" {
    fprintf(dotcode,"(%2d,DIV,\"%s\")\n",yylineno, yytext);
    fprintf(traducao, "/ "); 
    return DIV;
}
"%" {
    fprintf(dotcode,"(%2d,MOD,\"%s\")\n",yylineno, yytext);
    fprintf(traducao, "% "); 
    return MOD;
}
 /* LÓGICOS */
"and"   {
    fprintf(dotcode,"(%2d,AND,\"%s\")\n",yylineno, yytext);
    fprintf(traducao, "&& "); 
    return AND;
}
"or"    {
    fprintf(dotcode,"(%2d,OR,\"%s\")\n",yylineno, yytext);
    fprintf(traducao, "|| "); 
    return OR;
}
"not"   {
    fprintf(dotcode,"(%2d,NOT,\"%s\")\n",yylineno, yytext);
    fprintf(traducao, "not "); 
    return NOT;
}
 /* RELACIONAIS */
"=="    {
            fprintf(dotcode,"(%2d,EQ,\"%s\")\n",yylineno, yytext);
            fprintf(traducao, "== "); 
            return EQ;
        }
">="    {
            fprintf(dotcode,"(%2d,GE,\"%s\")\n",yylineno, yytext);
            fprintf(traducao, ">= "); 
            return GE;
        }
"<="    {
            fprintf(dotcode,"(%2d,LE,\"%s\")\n",yylineno, yytext);
            fprintf(traducao, "<= "); 
            return LE;
        }
">"     {
            fprintf(dotcode,"(%2d,GT,\"%s\")\n",yylineno, yytext);
            fprintf(traducao, "> "); 
            return GT;
        }
"<"     {
            fprintf(dotcode,"(%2d,LT,\"%s\")\n",yylineno, yytext);
            fprintf(traducao, "< "); 
            return LT;
        }
"!="    {
            fprintf(dotcode,"(%2d,NE,\"%s\")\n",yylineno, yytext);
            fprintf(traducao, "!= "); 
            return NE;
        }

 /*  ATRIBUIÇÃO */
"|="    {
            fprintf(dotcode,"(%2d,ATR,\"%s\")\n",yylineno, yytext);
            fprintf(traducao, "= "); 
            return ATR;
        }

 /* ESPECIAIS */
"break"    {
            fprintf(dotcode,"(%2d,BREAK,\"%s\")\n",yylineno, yytext);
            fprintf(traducao, "break"); 
            return BREAK;
        }
"return"    {
            fprintf(dotcode,"(%2d,RETURN,\"%s\")\n",yylineno, yytext);
            fprintf(traducao, "return"); 
            return RETURN;
        }

 /* NOMEAÇÃO DE VARIÁVEIS */
{letra}({digito}|{letra}|"_")*  {
    fprintf(dotcode,"(%2d,ID,\"%s\")\n",yylineno, yytext);
    fprintf(traducao, "%s ", yytext); 
    return ID;
}

 /* COMENTÁRIO DE LINHA */
[#][^\r\n]* {
    fprintf(dotcode,"(%2d,COMENTÁRIO,\"%s\")\n",yylineno, yytext);
    fprintf(traducao, "// %s\n", yytext);  
    return COMMENT;
}

 /* CAPTURANDO STRINGS */
["][^"]*["] {
    fprintf(dotcode,"(%2d,STRING,\"%s\")\n",yylineno, yytext);
    fprintf(traducao, "%s",  yytext); 
    return STRING;
}

 /* TIPOS DE DADOS - INTEIRO, REAL, LETRA E PALAVRA */
[+|-]?{digito}+   {
    fprintf(dotcode,"(%2d,TIPOINT,\"%s\")\n",yylineno, yytext);
    fprintf(traducao, "%s", yytext); 
    return TIPOINT;
}
[+|-]?{digito}+{ponto}{digito}+ {
    fprintf(dotcode,"(%2d,TIPOREAL,\"%s\")\n",yylineno,  yytext);
    fprintf(traducao, "%s", yytext); 
    return TIPOREAL;
}
[']({letra}|{digito})[']   {
    fprintf(dotcode,"(%2d,TIPOLETRA,\"%s\")\n",yylineno, yytext);
    fprintf(traducao, "%s", yytext); 
    return TIPOLETRA;
}
[;] {
        fprintf(dotcode,"(%2d,SEPARADOR,\"%s\")\n",yylineno, yytext);
        fprintf(traducao, ";"); 
        return SEPARADOR;
}

 /* FIM DE LINHA */
[.] {
        fprintf(dotcode,"(%2d,FIML,\"%s\")\n",yylineno, yytext);
        fprintf(traducao, "; \n\t"); 
        return FIML;
}

 /**/
[^\s] { }

%%

int yywrap();

int main(int argc, char *argv[]){
    FILE *arquivo = fopen(argv[1],"r");
    if (!arquivo) {
      printf("Arquivo nao existe!\n");
      return -1;
    }

    yyin = arquivo;
    dotcode = fopen(argv[2],"w");
    traducao = fopen(argv[3],"w");

    fprintf(traducao, "#include <iostream>\n#include <string>\nusing namespace std;\n\n");
    saida = false;

    
    yyparse();
    yylex();
    return 0;
}

int yywrap(){
    return 1;
}