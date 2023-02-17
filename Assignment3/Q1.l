%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int i = 0;
%}

%option noyywrap
%option yylineno

%%
[[:alnum:]]+  {
        if(yytext[1] == 'a') {
            printf("The matched word with second letter as 'a' is: %s\n", yytext);
            i++;
        }
    }
.   ;
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

    printf("The number of matched strings in the text file is: %d", i);
    return 0;
}
