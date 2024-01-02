
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
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


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     EQ = 258,
     GE = 259,
     LE = 260,
     GT = 261,
     LT = 262,
     NE = 263,
     SOMA = 264,
     SUB = 265,
     MULT = 266,
     DIV = 267,
     MOD = 268,
     AND = 269,
     OR = 270,
     NOT = 271,
     ATR = 272,
     READ = 273,
     WRITE = 274,
     CIN = 275,
     COUT = 276,
     IF = 277,
     ELSE = 278,
     WHILE = 279,
     FOR = 280,
     COMMENT = 281,
     ABREC = 282,
     FECHAC = 283,
     ABREP = 284,
     FECHAP = 285,
     SEPARADOR = 286,
     FIML = 287,
     ID = 288,
     FUNC_ID = 289,
     TIPOINT = 290,
     TIPOREAL = 291,
     TIPOLETRA = 292,
     STRING = 293,
     INT = 294,
     REAL = 295,
     LETRA = 296,
     TRUE = 297,
     FALSE = 298,
     INICIO = 299,
     FIM = 300,
     RETURN = 301,
     BREAK = 302
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


