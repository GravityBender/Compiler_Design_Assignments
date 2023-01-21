%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int i = 0;
%}

TYPE int|char|bool|float|void|struct|union|enum
MAIN main
LITERALS \"(\\.|[^"\\])*\"
%option noyywrap
%option yylineno

%%
{LITERALS}   ;   /*This rule matches string literals*/
{TYPE}[[:space:]]{MAIN} ;   /*This is rule is responsible for not considering the main function*/
{TYPE}[[:space:]][_[:alpha:]_][_[:alnum:]_]*   {printf("The matched identifier is: %s\n", yytext); i++;}   /*This rule is responsible for matching words(identifiers) other than the keywords*/
[_[:alpha:]_][_[:alnum:]_]*\(^{LITERALS}\) {printf("The matched identifier is: %s\n", yytext); i++;}    /*This rule is responsible for matching fucntions*/
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

    printf("The number of identifiers in the input c file is: %d", i);
    return 0;
}
