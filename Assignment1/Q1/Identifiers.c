#include <stdbool.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int count_identifiers = 0;

bool isDelimiter(char ch)
{
    if (ch == ' ' || ch == '+' || ch == '-' || ch == '*' ||
        ch == '/' || ch == ',' || ch == ';' || ch == '>' ||
        ch == '<' || ch == '=' || ch == '(' || ch == ')' ||
        ch == '[' || ch == ']' || ch == '{' || ch == '}' ||
        ch == '\n')
        return (true);
    return (false);
}

bool isType(char *str)
{
    if (!strcmp(str, "int") || !strcmp(str, "char") ||
        !strcmp(str, "bool") || !strcmp(str, "float") ||
        !strcmp(str, "void") || !strcmp(str, "struct") ||
        !strcmp(str, "union") || !strcmp(str, "enum") ||
        !strcmp(str, "const"))
        return true;
    return false;
}

// Returns 'true' if the character is an OPERATOR.
bool isOperator(char ch)
{
    if (ch == '+' || ch == '-' || ch == '*' ||
        ch == '/' || ch == '>' || ch == '<' ||
        ch == '=')
        return (true);
    return (false);
}

// Returns 'true' if the string is a VALID IDENTIFIER.
bool isValidIdentifier(char *str)
{
    if (str[0] == '0' || str[0] == '1' || str[0] == '2' ||
        str[0] == '3' || str[0] == '4' || str[0] == '5' ||
        str[0] == '6' || str[0] == '7' || str[0] == '8' ||
        str[0] == '9' || str[0] == '\'' || str[0] == '\"' ||
        str[0] == ' ' || isDelimiter(str[0]) == true ||
        isOperator(str[0]) == true || isType(str) == true)
        return (false);
    return (true);
}

// Extracts the SUBSTRING.
char *subString(char *str, int left, int right)
{
    int i;
    char *subStr = (char *)malloc(
        sizeof(char) * (right - left + 2));

    for (i = left; i <= right; i++)
        subStr[i - left] = str[i];
    subStr[right - left + 1] = '\0';
    return (subStr);
}

// Parsing the input STRING.
void parse(char *str)
{
    int left = 0, right = 0;
    int len = strlen(str);
    bool isTypeFirst = false;

    while (right < len && left <= right)
    {

        //  If the line contains even a single instance of ", ', * or // assume that it is a string literal or a comment
        //  and hence break the processing of the current line
        if (str[right] == "\'" || str[right] == '\"' || str[right] == '*' || str[right] == '/')
        {
            return;
        }

        if (isDelimiter(str[right]) == false)
            right++;

        if (isDelimiter(str[right]) == true && left == right)
        {
            right++;
            left = right;
        }
        else if (isDelimiter(str[right]) == true && left != right || (right == len && left != right))
        {
            char *subStr = subString(str, left, right - 1);

            if (isType(subStr) == true)
                isTypeFirst = true;
            else if (isTypeFirst && (isValidIdentifier(subStr) == true && isDelimiter(str[right - 1]) == false))
            {
                printf("%s IS A VALID IDENTIFIER\n", subStr);
                isTypeFirst = false;
                count_identifiers++;
            }
            left = right;
        }
    }
    return;
}

void readLine(FILE *filePtr, char c)
{

    char line[256];

    if (c == '\n')
        return;
    fseek(filePtr, -1, SEEK_CUR);
    int charLen = 0;
    for (int i = 0; c != '\n'; i++)
    {
        fscanf(filePtr, "%c", &c);
        charLen++;
        line[i] = c;
    }

    char *actualLine = (char *)malloc(charLen * sizeof(char));
    for (int i = 0; i < charLen; i++)
    {
        actualLine[i] = line[i];
    }

    // for (int i = 0; i < charLen; i++)
    // {
    //     printf("%c", actualLine[i]);
    // }

    parse(actualLine);
}

// DRIVER FUNCTION
int main()
{
    // maximum length of string is 100 here
    FILE *filePtr;
    char c;
    char line[256];
    filePtr = fopen("test.c", "r");

    if (NULL == filePtr)
    {
        printf("File can't be opened\n");
        return -1;
    }

    while ((c = fgetc(filePtr)) != EOF)
    {
        readLine(filePtr, c);
    }

    fclose(filePtr);

    return (0);
}
