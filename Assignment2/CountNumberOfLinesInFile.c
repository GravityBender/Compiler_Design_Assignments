#include <stdbool.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

/**
 * Garvit Verma
 * BT20CSE078
 **/

int count_newlines = 0;

void readLine(FILE *filePtr, char c)
{

    char line[256];

    if (c == '\n')
    {
        count_newlines++;
        return;
    }
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

    count_newlines++;
}

int main()
{
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

    printf("The number of newlines in this program is: %d", count_newlines);

    fclose(filePtr);

    return (0);
}
