// C++ program for the above approach

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

char *digits = "0123456789", *sign = "+-";
char *dot = ".", *ex = "eE";
int dfa[11][5];

void makeDFA()
{
    dfa[0][0] = 1;

    dfa[1][0] = 1;
    dfa[1][2] = 3;
    dfa[1][3] = 2;
    dfa[1][4] = 6;

    dfa[3][0] = 4;

    dfa[4][0] = 4;
    dfa[4][3] = 5;
    dfa[4][4] = 6;

    dfa[6][0] = 8;
    dfa[6][1] = 7;

    dfa[7][0] = 8;

    dfa[8][0] = 8;
    dfa[8][3] = 9;
}

void buildDFA()
{
    for (int i = 0; i < 11; i++)
        for (int j = 0; j < 5; j++)
            dfa[i][j] = 10;

    makeDFA();
}

bool checkDFA(char *s)
{
    buildDFA();

    int currentstate = 0;

    int stringSize = sizeof(s);

    for (int i = 0; i < stringSize; i++)
    {

        if (strchr(digits, s[i]) != NULL)
            currentstate = dfa[currentstate][0];

        else if (strchr(sign, s[i]) != NULL)
            currentstate = dfa[currentstate][1];

        else if (strchr(dot, s[i]) != NULL)
            currentstate = dfa[currentstate][2];

        else if (strchr(ex, s[i]) != NULL)
            currentstate = dfa[currentstate][4];

        else
            currentstate = dfa[currentstate][3];
    }

    if (currentstate == 1 || currentstate == 4 || currentstate == 8)
        return true;
    else
        return false;
}

// Driver Code
int main()
{
    char *num1 = "-78-e-9";
    checkDFA(num1) ? printf("The number: %s, is an unsigned integer\n", num1) : printf("The number: %s, is not an unsigned integer\n", num1);

    char *num2 = "78e-10";
    checkDFA(num2) ? printf("The number: %s, is an unsigned integer\n", num2) : printf("The number: %s, is not an unsigned integer\n", num2);

    return 0;
}
