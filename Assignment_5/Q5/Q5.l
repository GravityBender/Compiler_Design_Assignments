%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int i = 0;
%}

%option noyywrap
%option yylineno

%%
[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]+      {
            int wordLength = strlen(yytext);
            int alphaCount = 0;
            for(int i = 0; i < wordLength; i ++) {
                if((yytext[i] >= 'a' && yytext[i] <= 'z') || (yytext[i] >= 'A' && yytext[i] <= 'Z'))
                    alphaCount ++;
            }
            
            if(alphaCount >=3 && alphaCount <= 5) {
                printf("The string having 3 to 5 alphabets is: %s\n", yytext);
                i ++;
            }
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

    printf("The string having 3 to 5 alphabets alphabets is: %d\n", i);
    
    return 0;
}