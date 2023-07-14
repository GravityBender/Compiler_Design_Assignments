%{
#include<stdio.h>
#include<stdlib.h>
#include"Q1.tab.h"
int yyerror(char* s);
%}

digit[0-9]
letter[a-zA-Z_]
space[ \n\t]
number[+-]?[0-9]+(.[0-9]+)?

%%

\n|\t|" " {};

"while" {
    return WHILE;
};

{letter}({letter}|{digit})*|{number} {
    return ID;
};


"==" {
    return EQEQ;
};

"=" {
    return EQ;
};

"{" {
    return OC;
};

"}" {
    return CC;
};

"(" {
    return OR;
};

")" {
    return CR;
};

";" {
    return SEMI;
};

. {
    yyerror("Lexical Error\n");
};

%%

int yywrap(){
    return 1;
}