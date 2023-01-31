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
            if (strcmp(c, "#define") == 0 || strcmp(c, "const") == 0)
            {
                count_constants++;
            };
        }
        break;

    case SAW_SLASH:
        switch (c[0])
        {
        case '/':
            state = SINGLE_COMMENT;
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

int main()
{
    FILE *filePtr;
    filePtr = fopen("test.c", "r");
    char line[256];

    if (NULL == filePtr)
    {
        printf("File can't be opened\n");
        return -1;
    }

    while (fgets(line, sizeof(line), filePtr))
    {
        char *c = strtok(line, " ");
        countConstants(c);
    }
    fclose(filePtr);
    printf("No. of constants in file: %d\n", count_constants);
    return 0;
}
