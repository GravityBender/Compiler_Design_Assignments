%{
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

%option noyywrap
%option yylineno

%%
[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]*{KEYWORDS1}+[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]*  {
        printf("Matched string is: %s\n", yytext);
        i ++;
    }
[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]*{KEYWORDS2}+[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]*  {
        printf("Matched string is: %s\n", yytext);
        i ++;
    }
[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]*{KEYWORDS3}+[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]*  {
        printf("Matched string is: %s\n", yytext);
        i ++;
    }
[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]*{KEYWORDS4}+[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]*  {
        printf("Matched string is: %s\n", yytext);
        i ++;
    }
[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]*{KEYWORDS5}+[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]*  {
        printf("Matched string is: %s\n", yytext);
        i ++;
    }
[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]*{KEYWORDS6}+[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]*  {
        printf("Matched string is: %s\n", yytext);
        i ++;
    }
[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]*{KEYWORDS7}+[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]*  {
        printf("Matched string is: %s\n", yytext);
        i ++;
    }
[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]*{KEYWORDS8}+[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]*  {
        printf("Matched string is: %s\n", yytext);
        i ++;
    }
. ;
%%

int main() {
    FILE *filePtr;
    filePtr = fopen("test.txt", "r");

    if(NULL == filePtr) {
        printf("File can't be opened\n");
        return -1;
    }
        
    
    yyin = filePtr;
    yylex();
    fclose(filePtr);

    printf("The strings having a C keyword as substring: %d\n", i);
    
    return 0;
}