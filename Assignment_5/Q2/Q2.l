%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int pos_int = 0;
int pos_frac = 0;
int neg_int = 0;
int neg_frac = 0;
%}

%option noyywrap
%option yylineno

%%
\+?[[:digit:]]+    {pos_int ++;}
-[[:digit:]]+       {neg_int ++;}
\+?[[:digit:]]*\.[[:digit:]]+   {pos_frac ++;}
-[[:digit:]]*\.[[:digit:]]+     {neg_frac ++;}
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

    printf("Positive Integers: %d\n", pos_int);
    printf("Negative Integers: %d\n", neg_int);
    printf("Positive Fractions: %d\n", pos_frac);
    printf("Negative Fractions: %d\n", neg_frac);
    return 0;
}