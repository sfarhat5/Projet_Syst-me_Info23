/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

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
     ID = 258,
     NUM = 259,
     IF = 260,
     ELSE = 261,
     WHILE = 262,
     PRINT = 263,
     INT = 264,
     VOID = 265,
     RETURN = 266,
     EQ = 267,
     ASSIGN = 268,
     LBRACE = 269,
     RBRACE = 270,
     LPAREN = 271,
     RPAREN = 272,
     SEMI = 273,
     COMMA = 274,
     LT = 275,
     GT = 276,
     LTE = 277,
     GTE = 278,
     NEQ = 279,
     MINUS = 280,
     PLUS = 281,
     DIVIDE = 282,
     TIMES = 283,
     LOWER_THAN_ELSE = 284,
     UMINUS = 285
   };
#endif
/* Tokens.  */
#define ID 258
#define NUM 259
#define IF 260
#define ELSE 261
#define WHILE 262
#define PRINT 263
#define INT 264
#define VOID 265
#define RETURN 266
#define EQ 267
#define ASSIGN 268
#define LBRACE 269
#define RBRACE 270
#define LPAREN 271
#define RPAREN 272
#define SEMI 273
#define COMMA 274
#define LT 275
#define GT 276
#define LTE 277
#define GTE 278
#define NEQ 279
#define MINUS 280
#define PLUS 281
#define DIVIDE 282
#define TIMES 283
#define LOWER_THAN_ELSE 284
#define UMINUS 285




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 26 "cparser.y"
{
  char* id;
  int integer;
}
/* Line 1529 of yacc.c.  */
#line 114 "y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

