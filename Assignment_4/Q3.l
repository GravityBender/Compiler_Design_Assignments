%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int id = 0;
int key = 0;
%}

KEYWORDS1   auto|break|case|char
KEYWORDS2   const|continue|default|do
KEYWORDS3   double|else|enum|extern
KEYWORDS4   float|for|goto|if
KEYWORDS5   int|long|register|return
KEYWORDS6   short|signed|sizeof|static
KEYWORDS7   struct|switch|typedef|union
KEYWORDS8   unsigned|void|volatile|while
TYPE int|char|bool|float|void|struct|union|enum
MAIN main
LITERALS \"(\\.|[^"\\])*\"
%option noyywrap
%option yylineno

%%
{LITERALS}   ;   /*This rule matches string literals*/
{KEYWORDS1}|{KEYWORDS2}|{KEYWORDS3}|{KEYWORDS4}  {printf("The matched text is: %s\n", yytext); key++;}    /*These two rules are responsible for matching the keywords defined*/
{KEYWORDS5}|{KEYWORDS6}|{KEYWORDS7}|{KEYWORDS8}  {printf("The matched text is: %s\n", yytext); key++;}
{TYPE}[[:space:]]{MAIN} ;   /*This is rule is responsible for not considering the main function*/
{TYPE}|{TYPE}[[:space:]][_[:alpha:]_][_[:alnum:]_]*   {printf("The matched identifier and it is part of keyword: %s\n", yytext); id++; key ++;}   /*This rule is responsible for matching words(identifiers) other than the keywords*/
[_[:alpha:]_][_[:alnum:]_]*\(^{LITERALS}\) {printf("The matched identifier is: %s\n", yytext); id++;}    /*This rule is responsible for matching fucntions*/
.  ;   /*Match everything else*/
%%

int main() {
    FILE *filePtr;
    filePtr = fopen("test.c", "r");

    if(NULL == filePtr) {
        printf("File can't be opened\n");
        return -1;
    }
        
    
    yyin = filePtr;
    yylex();
    fclose(filePtr);

    printf("The number of identifiers in the input c file is: %d\n", id);
    printf("The number of keywords in the input c file is: %d", key);
    return 0;
}