%{
    /* C Declaration section */

    #include<stdio.h>
    #include<stdlib.h>
    void yyerror(char *s);
%}

/*  YACC declarations  */
%token ZERO ONE

/* Rule Section */
%%
    N:  L {printf("\n%d", $$);}

    L:  L B {$$ = $1 * 2 + $2;}
        | B {$$ = $1;}

    B:  ZERO {$$ = $1;}
        | ONE {$$ = $1;};
%%

int main() {
    while(yyparse());
}

void yyerror(char *s) {
    fprintf(stdout, "\n%s", s);
}

