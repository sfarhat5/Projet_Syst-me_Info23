%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "table_symboles.h"




int yylex();
int yyerror();
extern int yylineno;

int index_temp = 127;
int index_asm = 0;
int res_condition;
int index_retour; 
int index_retour_else; 
int index_before_while; 
char ASM[256][256];

FILE* fileasm;

%}

%union {
  char* id;
  int integer;
}

%token <id> ID
%token <integer> NUM
%token IF ELSE WHILE PRINT INT VOID RETURN
%token EQ ASSIGN LBRACE RBRACE LPAREN RPAREN SEMI COMMA
%token LT GT LTE GTE NEQ
%type <integer> expr


%left PLUS MINUS
%left TIMES DIVIDE

%nonassoc LT GT LTE GTE EQ NEQ
%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE
%nonassoc UMINUS
%nonassoc LPAREN RPAREN

%%

program: func_list {printf("debut prog OK \n");}
;

func_list: func_list func
    | func
    ;

func: VOID ID LPAREN param_list RPAREN compound_stmt {
    printf("%s \n", ASM[0]);
    printf("Void ID OK \n");
}
    | INT ID LPAREN param_list RPAREN compound_stmt {
    printf("%s \n", ASM[0]);
    printf("int main ID OK \n");
}
    | INT ID LPAREN param_list RPAREN LBRACE stmt_list RETURN expr SEMI RBRACE {
    printf("%s \n", ASM[0]);
    printf("int ID with return OK \n");
}
    ;

param_list: /* empty */
    | INT ID {
        add_symbol($2, 0);
        sprintf(ASM[index_asm], "INP %d\n", index_symbol($2));
        index_asm++;
    }
    | VOID
    | param_list COMMA INT ID {
        add_symbol($4, 0);
        sprintf(ASM[index_asm], "INP %d\n", index_symbol($4));
        index_asm++;
    }
    ;

compound_stmt: LBRACE stmt_list RBRACE
    ;

stmt_list: /* empty */
    | stmt_list stmt
    ;

stmt: expr_stmt
    | compound_stmt
    | selection_stmt
    | iteration_stmt
    | print_stmt
    | assign_stmt SEMI
    | decl SEMI
    | call_fun SEMI
    ;

call_fun: ID LPAREN arguments_fun RPAREN 
    | ID LPAREN RPAREN 
    ;

arguments_fun: INT ID 
    | arguments_fun COMMA INT ID
    ;

decl: INT ID {
    printf("int id ok : %s\n", $2);
    add_symbol($2, 0);
    //init_symbol($2);
}
    | INT assign_stmt 
    | decl COMMA ID {
    printf("int id, id ok");
    add_symbol($3, 0);
}
    | decl COMMA assign_stmt
    ;

assign_stmt: ID ASSIGN expr {
    add_symbol($1, 1); 
    int index_a = index_symbol($1);
    int index_b = $3; 
    if (index_a != -1) {
        sprintf(ASM[index_asm+1], "COP %d %d\n", index_a, index_b);
        index_asm += 2;
        index_temp--; 
    }
}
    | ID ASSIGN call_fun
    ;

expr_stmt: expr SEMI
    | SEMI
    ;

selection_stmt: IF LPAREN expr RPAREN {
    res_condition = $3;
    index_retour = index_asm; 
    index_asm++; 
    printf("Selection Statement if else Ok\n"); 
    } stmt {
        index_asm = index_asm + 2;
        sprintf(ASM[index_retour], "JMF %d %d\n", res_condition, index_asm);
        index_retour_else = index_asm; 
        index_asm++;
        printf("Selection Statement if avec else2 Ok\n");
    } else_stmt 
    ;

else_stmt: /*empty*/
        | ELSE stmt { 
        sprintf(ASM[index_retour_else], "JMP %d %d\n", res_condition, index_asm - 1);
    };
   



iteration_stmt: WHILE LPAREN expr RPAREN {
    res_condition = $3; 
    index_retour = index_asm; 
    index_before_while = index_asm-2; 
    index_asm++; 
    printf("Iteration Statement Ok\n");
    sprintf(ASM[index_retour], "JMF %d %d\n", res_condition, index_asm+2);
}
    stmt {
        
        sprintf(ASM[index_asm], "JMP %d %d\n", res_condition, index_before_while); 
    }
    ;

print_stmt: PRINT LPAREN expr RPAREN SEMI {
    sprintf(ASM[index_asm], "PRI %d\n", $3);
    index_asm++;
    printf("print ok\n");
}
    ;

expr: ID { int index = index_symbol($1);
            if(index>=0){
                $$ = index;
            }
            else{
                printf("ERREUR : variable non initialisée\n");
            }
    }  
    | NUM {
        sprintf(ASM[index_asm], "AFC %d %d\n", index_temp, $1);
        index_asm++;
        $$ = index_temp; 
        index_temp--; 
    }

    | expr PLUS expr {
    sprintf(ASM[index_asm], "ADD %d %d %d\n", index_temp, $1, $3);
    index_asm++;
    $$ = index_temp;
    index_temp--;
    printf("Je suis dans le ADD\n");
}
     | expr MINUS expr {
    sprintf(ASM[index_asm], "SUB %d %d %d\n", index_temp, $1, $3);
    printf("Je suis dans le SUB\n");
    index_asm++;
    $$ = index_temp;
    index_temp--;
}

    | expr TIMES expr {
    sprintf(ASM[index_asm], "MUL %d %d %d\n", index_temp, $1, $3);
    printf("Je suis dans le MUL \n"); 
    index_asm++;
    $$ = index_temp;
    index_temp--;
}
    | expr DIVIDE expr {
    sprintf(ASM[index_asm], "DIV %d %d %d\n", index_temp, $1, $3);
    printf("Je suis dans le DIV \n"); 
    index_asm++;
    $$ = index_temp;
    index_temp--;
}
    | LPAREN expr RPAREN {
    $$ = $2;
}
    | MINUS expr %prec UMINUS {
    sprintf(ASM[index_asm], "NEG %d %d\n", index_temp, $2);
    index_asm++;
    $$ = index_temp;
    index_temp--;
}
    | expr LT expr {
    sprintf(ASM[index_asm], "CMP_LT %d %d %d\n", index_temp, $1, $3);
    index_asm++;
    $$ = index_temp;
    index_temp--;
}
    | expr GT expr {
    sprintf(ASM[index_asm], "CMP_GT %d %d %d\n", index_temp, $1, $3);
    index_asm++;
    $$ = index_temp;
    index_temp--;
}
    | expr LTE expr {
    sprintf(ASM[index_asm], "CMP_LTE %d %d %d\n", index_temp, $1, $3);
    index_asm++;
    $$ = index_temp;
    index_temp--;
}
    | expr GTE expr {
    sprintf(ASM[index_asm], "CMP_GTE %d %d %d\n", index_temp, $1, $3);
    index_asm++;
    $$ = index_temp;
    index_temp--;
}
    | expr EQ expr {
    sprintf(ASM[index_asm], "CMP_EQ %d %d %d\n", index_temp, $1, $3);
    index_asm++;
    $$ = index_temp;
    index_temp--;
}
    | expr NEQ expr {
    sprintf(ASM[index_asm], "CMP_NEQ %d %d %d\n", index_temp, $1, $3);
    index_asm++;
    $$ = index_temp;
    index_temp--;
}
;

%%

int yyerror() {
    printf("Erreur à la ligne %d\n", yylineno);
    return 0;
}

int main() {
    fileasm = fopen("fileasm", "w");

    yydebug = 1;
    yyparse();

    for(int i = 0; i < 256; i++) {
        fprintf(fileasm, "%s", ASM[i]);
    }

   fclose(fileasm);
     
    

    print_symbol_table();
     
    //executeASM("fileasm");

    return 0;
}
