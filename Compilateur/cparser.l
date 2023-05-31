%option noyywrap
%option noinput
%option nounput


%{
#include <stdio.h> 
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
%}

IDENTIFIERS  [a-zA-Z][a-zA-Z0-9]*
INTEGERS     0x[0-9a-f]*|[0-9]+ 
COMMENT      "//".*\n|"/*"(.|\n)*"*/"
ENDLINE      [ ]*\n

%%

{ENDLINE}

{COMMENT}

"if"                      { return IF; }
"else"                    { return ELSE; }
"while"                   { return WHILE; }
"print"                   { return PRINT; }
"int"                     { return INT; }
"void"                    { return VOID; }
"return"                  { return RETURN; }

{IDENTIFIERS}             { yylval.id=(char*)malloc(sizeof(char*));
                            strcpy(yylval.id,yytext); 
                            return ID; }
{INTEGERS}                { yylval.integer = atof(yytext); 
                            return NUM; }

"=="                      { return EQ; }
"="                       { return ASSIGN; }
"{"                       { return LBRACE; }
"}"                       { return RBRACE; }
"("                       { return LPAREN; }
")"                       { return RPAREN; }
";"                       { return SEMI; }
"+"                       { return PLUS; }
"-"                       { return MINUS; }
"*"                       { return TIMES; }
"/"                       { return DIVIDE; }
"<"                       { return LT; }
">"                       { return GT; }
"<="                      { return LTE; }
">="                      { return GTE; }
"!="                      { return NEQ; }
[,]                       { return COMMA; }
                         

%%

