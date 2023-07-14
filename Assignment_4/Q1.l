%{
#undef yywrap
#define yywrap() 1
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int count = 0;
%}

%option noyywrap
%option yylineno

%%
.+    {
                    int wordLength = strlen(yytext);
                    for(int i = 0; i < wordLength; i ++) {
                        if(yytext[i] == '!' || yytext[i] == '@' || yytext[i] == '#' || yytext[i] == '$'
                        || yytext[i] == '%' || yytext[i] == '^' || yytext[i] == '&' || yytext[i] == '*'
                        || yytext[i] == '(' || yytext[i] == ')' || yytext[i] == '-' || yytext[i] == '{'
                        || yytext[i] == '}' || yytext[i] == '[' || yytext[i] == ']' || yytext[i] == ':'
                        || yytext[i] == ';' || yytext[i] == '"' || yytext[i] == '\'' || yytext[i] == '<'
                        || yytext[i] == '>' || yytext[i] == '.' || yytext[i] == '/' || yytext[i] == '?'
                        || yytext[i] == '~' || yytext[i] == '`' ){
                            printf("String %s contains special characters\n", yytext);
                            count ++;
                            break;
                        }
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

    printf("The number of keywords in the input file is: %d", count);
    return 0;
}