%{
    //  C Libraries
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    int yylex();
    void yyerror(char* s);  //  Function to print the errors
    int symbolVal(char* symbol);    //  Function to return the value of the symbols

    char* symbols[1000];
    int symbolValues[1000];
    /**
    *   This variable is responsible for keeping track of the
    *   term numbers, i.e. t1, t2, etc;
    **/
    int symbolCounter = 0;
    /**
    *   This variable is responsible for keeping track of the
    *   label numbers, i.e. L1, L2, etc;
    **/
    int labelCounter = 0;
    //  Variable responsible for storing string representation of a number
    char* numToString;
    char* labels;
    extern FILE* yyin;
    extern char *yytext;
    extern int yylineno;

    char* Temp();
    char* labelAssigner();
   
%}

%union {
    struct quadruple {
        int num;
        int isNum;  //  Flag for a term if it is a number or not
        char *arg1;
        char *arg2; //  To store labels
        char *result;
    } tuple;
}

%start  line
%token  <tuple> number
%token  TYPE
%token  IF
%token  ELSE
%token  <tuple> identifier
%token  <tuple> RELOP
%type  <tuple> line exp factor assignment term rel
%left   '+' '-'
%left   '*' '/'
%nonassoc ELSE

%%

line    :   assignment ';' {;}
        |   line assignment ';' {;}
        |   TYPE identifier ';' {printf("This is a declaration");}
        |   line exp ';' {;}
        |   line IF '(' rel {
                    labels = labelAssigner();
                    $4.arg2 = labels;
                    printf("If %s Goto %s \n", $4.result, labels);
                    printf("%s: ", $4.arg2);
                } ')' '{' line '}' {
                                    labels = labelAssigner();
                                    printf("%s :\n",labels, $4.arg2);
                                }
        |   IF '(' rel {
                labels = labelAssigner();
                $3.arg2 = labels;
                printf("If %s Goto %s \n", $3.result, labels);
                printf("%s: ", $3.arg2);
            } ')' '{' line '}' {
                                labels = labelAssigner();
                                printf("%s :\n",labels, $3.arg2);
                            }
        |   line ELSE '{' line '}' {
                                labels = labelAssigner();
                                printf("%s :\n",labels);
                            }
        ;

assignment  :   TYPE identifier '=' exp {printf("%s = %s\n", $2.result, $4.result);}
            |   identifier '=' exp {printf("%s = %s\n", $1.result, $3.result);}
            ;

exp :   term {;}
    |   '-''-' exp {printf("%s = %s - 1\n", $3.result, $3.result);}
    |   '+''+' exp {printf("%s = %s + 1\n", $3.result, $3.result);}
    |   exp '-''-' {printf("%s = %s - 1\n", $1.result, $1.result);}
    |   exp '+''+' {printf("%s = %s + 1\n", $1.result, $1.result);}
    | exp '+' term  { 
                        $$.arg1 = $1.result;
                        $$.arg2 = $3.result; 
                        $$.result = Temp(); 
                        $$.isNum = 0;  
                        if($1.isNum == 1) {
                            printf("%s = %d + %s\n",$$.result,$1.num,$3.result);
                        }else {
                            printf("%s = %s + %s\n",$$.result,$$.arg1,$$.arg2);
                        }
                    }
    | exp '-' term  {
                        $$.arg1 = $1.result;
                        $$.arg2 = $3.result;
                        $$.result = Temp(); 
                        $$.isNum = 0;
                        if($1.isNum == 1) {
                            printf("%s = %d - %s\n",$$.result,$1.num,$3.result);
                        }else {
                            printf("%s = %s - %s\n",$$.result,$$.arg1,$$.arg2);
                        }
                    }
    ;

rel :   exp RELOP exp   {
                            if($3.isNum == 1) {
                                $$.arg1 = Temp();
                                $$.result = Temp();
                                printf("%s = %d\n",$$.arg1,$3.num);
                                printf("%s = %s %s %s\n",$$.result,$1.result,$2.arg1,$$.arg1);
                            } else {
                                $$.result = Temp();
                                printf("%s = %s %s %s\n",$$.result,$1.result,$2.arg1,$3.result);
                            }
                        }

term    : factor {;}
        | term '*' factor   {
                                $$.arg1 = $1.result;
                                $$.arg2 = $3.result;
                                $$.result = Temp();
                                $$.isNum = 0;  
                                if($1.isNum == 1) {
                                    printf("%s = %d * %s\n",$$.result,$1.num,$3.result);
                                } else {
                                    printf("%s = %s * %s\n",$$.result,$$.arg1,$$.arg2);
                                }
                            }
        |   term '/' factor {
                                $$.arg1 = $1.result; 
                                $$.arg2 = $3.result; 
                                $$.result = Temp(); 
                                $$.isNum = 0;
                                if($1.isNum == 1) {
                                    printf("%s = %d / %s\n",$$.result,$1.num,$3.result);
                                } else {
                                    printf("%s = %s / %s\n",$$.result,$$.arg1,$$.arg2);
                                }
                            }
        ;

factor : number {
                    sprintf(numToString,"%d",$1.num);   //  Converting number to string
                    $1.isNum = 1;   //  Since `number` is a number hence flag = 1
                    $1.arg1 = numToString;
                    $1.result = numToString; 
                    $$ =$1;
                }
       | '(' exp ')' { $2.isNum=0;  $$ = $2; } 
       | identifier {  $$.result = $1.result; }
       ;
%%

/**
*   This function is responsible for returning the string representation of 
*   a result term, ex: let x = x * y;
*   then "x * y" would be stored into a result term "tX"
*   so "x * y" would become t1, then x = t1;
**/
char * Temp() {
    symbolCounter++;
    char *temp=(char *)malloc(sizeof(5*sizeof(char)));
    sprintf(temp,"t%d",symbolCounter);
    return temp;
}

/**
*   This function is responsible for returning the string representation of 
*   a label term, ex: let if(x == 1) {x = 2;} else {x = 3;}
*   then "x = 2" i.e the if block would be stored into a result term "LX"
*   while "x = 3" i.e the else block would be stored into a result term "L(X+1)"
*   so the if block would become L1 and the else block would become L2;
**/
char * labelAssigner(){
    labelCounter++;
    char *temp=(char *)malloc(sizeof(5*sizeof(char)));
    sprintf(temp,"L%d",labelCounter);
    return temp;   
}

int main() {
    FILE* yyout;
    numToString = malloc(11 * sizeof(char));
    labels = malloc(10 * sizeof(char));
    yyin = fopen("input.txt", "r");
    yyparse();
    fclose(yyout);
}

// Function to print error
void yyerror (char *s) {
    fprintf (stderr, "Line No:%d: \t%s %s\n",yylineno, s, yytext);
}