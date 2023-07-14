%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int c = 0;
int v = 0;
%}

%option noyywrap
%option yylineno

%%
[aeiouAEIOU] {v++;}
[a-zA-Z] {c++;}
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

    printf("The number of vowels and consonant in the input file are: %d %d", v, c);
    return 0;
}