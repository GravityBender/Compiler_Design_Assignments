%{#include <stdio.h>
#include <stdlib.h>
int yylex();
int yyerror(char* s);
extern FILE *yyin;
%}

%token WHILE EQEQ EQ OC CC OR CR SEMI ID

%%

loop : WHILE OR condition CR OC statement CC {
    printf("Parsed Successfully\n"); 
    YYACCEPT; 
}

condition : ID EQEQ ID  {};

statement : ID EQ ID SEMI | loop {};

%%

int main() {
  yyin=fopen("test.txt", "r");
  yyparse();
  return 0;
}

int yyerror(char *s) {
  printf("Error: %s\n", s);
  return 0;
}