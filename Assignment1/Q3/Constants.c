#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int count_constants = 0;

// An enum structure for holding the different states possible for the input
enum states
{
    TEXT,
    SAW_SLASH,
    SAW_STAR,
    SINGLE_COMMENT,
    MULTI_COMMENT
} state = TEXT;

//  This function is used for counting the number of constants in the passed line
int countConstants(char *c)
{

    switch (state)
    {
    case TEXT:
        switch (c[0])
        {
        case '/':
            state = SAW_SLASH;
            break;
        default:
            if (!strcmp(c, "#define") || !strcmp(c, "const"))
            {
                count_constants++;
            };
        }
        break;

    case SAW_SLASH:
        switch (c[0])
        {
        case '/':
            switch (c[1])
            {
            case '/':
                state = SINGLE_COMMENT;
                break;

            case '*':
                state = MULTI_COMMENT;
                break;

            default:
                break;
            }
            break;
        case '*':
            state = MULTI_COMMENT;
            break;
        default:
            state = TEXT;
            break;
        }
        break;

    case SAW_STAR:
        switch (c[0])
        {
        case '/':
            state = TEXT;
            break;
        case '*':
            switch (c[1])
            {
            case '/':
                state = TEXT;
                break;

            default:
                state = MULTI_COMMENT;
                break;
            }
            break;
        default:
            state = MULTI_COMMENT;
            break;
        }
        break;

    case SINGLE_COMMENT:
        switch (c[0])
        {
        case '\n':
            state = TEXT;
        default:
            break;
        }
        break;

    case MULTI_COMMENT:
        switch (c[0])
        {
        case '*':
            state = SAW_STAR;
            break;
        default:
            break;
        }
        break;

    default:
        break;
    }
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

    // for (int i = 0; i < charLen; i++)
    // {
    //     printf("%c", actualLine[i]);
    // }

    char arrayToSend[charLen];
    for (int i = 0; i < charLen; i++)
    {
        arrayToSend[i] = line[i];
    }

    char *c1 = strtok(arrayToSend, " ");
    countConstants(c1);
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

    fclose(filePtr);
    printf("No. of constants in file: %d\n", count_constants);
    return 0;
}
