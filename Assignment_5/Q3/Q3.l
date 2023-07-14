%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int i = 0;
%}

%option noyywrap
%option yylineno

%%
.+      {
            int wordLength = strlen(yytext);
            int alphaCount = 0;
            for(int i = 0; i < wordLength; i ++) {
                if((yytext[i] >= 'a' && yytext[i] <= 'z') || (yytext[i] >= 'A' && yytext[i] <= 'Z'))
                    alphaCount ++;
            }
            
            if(alphaCount == 2) {
                printf("The string containing only two alphabets is: %s\n", yytext);
                i ++;
            }
        }
[[:space:]]+ ;
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

    printf("The string containing only two alphabets is: %d\n", i);
    
    return 0;
}