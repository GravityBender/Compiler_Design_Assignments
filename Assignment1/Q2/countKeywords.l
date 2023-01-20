%{
#undef yywrap
#define yywrap() 1
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int i = 0;
%}

KEYWORDS1   auto|break|case|char
KEYWORDS2   const|continue|default|do
KEYWORDS3   double|else|enum|extern
KEYWORDS4   float|for|goto|if
KEYWORDS5   int|long|register|return
KEYWORDS6   short|signed|sizeof|static
KEYWORDS7   struct|switch|typedef|union
KEYWORDS8   unsigned|void|volatile|while
TYPE int|char|bool|float|void|for|do|while|if|else|return|void
%option noyywrap
%option yylineno

%%
\"(\\.|[^"\\])*\"   ;   /*This rule matches string literals*/
{KEYWORDS1}|{KEYWORDS2}|{KEYWORDS3}|{KEYWORDS4}  {/*printf("The matched text is: %s\n", yytext);*/ i++;}    /*These two rules are responsible for matching the keywords defined*/
{KEYWORDS5}|{KEYWORDS6}|{KEYWORDS7}|{KEYWORDS8}  {/*printf("The matched text is: %s\n", yytext);*/ i++;}
[a-zA-Z]+[a-zA-Z0-9]*   ;   /*This rule is responsible for matching any other words then the keywords*/
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

    printf("The number of keywords in the input c file is: %d", i);
    return 0;
}
