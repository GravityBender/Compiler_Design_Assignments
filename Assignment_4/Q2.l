%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int i = 0;
%}

%option noyywrap
%option yylineno

%%
[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]+ {
        int wordLength = strlen(yytext);
        int count = 0;
        //printf("The word is: %s\n", yytext);
        for(int j = 0; j < wordLength; j ++) {
            if(yytext[j] >= 65 && yytext[j] <= 90) {
                count ++;
            }
        }
        if(count == 1) {
            printf("The matched word with capital letter is: %s\n", yytext);
            i ++;
        }
    }
.  ;
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