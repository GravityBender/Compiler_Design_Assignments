%{
#include "test.tab.h"
#include <string.h>
char * split(char* s,char* delimeter);
%}


relop >=|<=|>|<|==|!=
letter [a-zA-Z]
digit [0-9]
ws  [ \t\r\f\v]+
identifier (_|{letter})({letter}|{digit}|_){0,31}

%%
[\n]    ;
{ws}	;
"if" {return IF;}
"else" {return ELSE;}
"int"|"string"|"char"|"double"|"float" { return TYPE;}
{identifier} 	{ yylval.tuple.result = strdup(yytext); return identifier;	}
[+\-]?{digit}+[lLuU]?  {yylval.tuple.num= atoi(yytext); return number;}
{relop} { yylval.tuple.arg1 =strdup(yytext); return RELOP;}
[-+*=/;] {return yytext[0];}
[(){}]               {return yytext[0];}
%%

int yywrap(void)
{
	return 1;
}