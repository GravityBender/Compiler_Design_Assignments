%{
#include<stdio.h>
#include<stdio.h>
int i = 0;
%}

TYPE int|float|char
VARNAME [_[:alpha:]_][_[:alnum:]_]*
LITERALS \"(\\.|[^"\\])*\"
/* This tells flex to read only one input file */
/*
*
* When the scanner receives an end-of-file indication from YY_INPUT, it then checks the yywrap() function. 
* If yywrap() returns false (zero), then it is assumed that the function has gone ahead and set up yyin to point to another input file, 
* and scanning continues. 
* If it returns true (non-zero), then the scanner terminates, returning 0 to its caller. Note that in either case, 
* the start condition remains unchanged; it does not revert to INITIAL.
*
*/
%option noyywrap
%option yylineno

%%
define[[:space:]]{VARNAME}[[:space:]][[:alnum:]]?{LITERALS}?   {printf("The matched constant is: %s\n", yytext); i++;}
const[[:space:]]{TYPE}[[:space:]]{VARNAME}[][[:space:]]*=[[:space:]]*.+  {printf("The matched constant is: %s\n", yytext); i++;}
.   ;
%%

int main() {
    FILE *filePtr = fopen("test.c", "r");

    if(filePtr == NULL) {
        printf("File can't be opened\n");
        return -1;
    }

    yyin = filePtr;
    yylex();
    fclose(filePtr);

    printf("The total number of constants in this program is: %d", i);

    return 0;
}
