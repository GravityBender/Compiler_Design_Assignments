#include <stdbool.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int count_keywords = 0;

// Returns 'true' if the character is a DELIMITER.
bool isDelimiter(char ch)
{
	if (ch == ' ' || ch == '+' || ch == '-' || ch == '*' ||
		ch == '/' || ch == ',' || ch == ';' || ch == '>' ||
		ch == '<' || ch == '=' || ch == '(' || ch == ')' ||
		ch == '[' || ch == ']' || ch == '{' || ch == '}')
		return (true);
	return (false);
}

// Returns 'true' if the string is a KEYWORD.
bool isKeyword(char *str)
{
	if (!strcmp(str, "auto") || !strcmp(str, "break") ||
		!strcmp(str, "case") || !strcmp(str, "char") ||
		!strcmp(str, "const") || !strcmp(str, "continue") ||
		!strcmp(str, "default") || !strcmp(str, "do") ||
		!strcmp(str, "double") || !strcmp(str, "else") ||
		!strcmp(str, "enum") || !strcmp(str, "extern") ||
		!strcmp(str, "float") || !strcmp(str, "for") ||
		!strcmp(str, "goto") || !strcmp(str, "if") ||
		!strcmp(str, "int") || !strcmp(str, "long") ||
		!strcmp(str, "register") || !strcmp(str, "return") ||
		!strcmp(str, "short") || !strcmp(str, "signed") ||
		!strcmp(str, "sizeof") || !strcmp(str, "static") ||
		!strcmp(str, "struct") || !strcmp(str, "switch") ||
		!strcmp(str, "typedef") || !strcmp(str, "union") ||
		!strcmp(str, "unsigned") || !strcmp(str, "void") ||
		!strcmp(str, "volatile") || !strcmp(str, "while"))
		return (true);
	return (false);
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

	while (right <= len && left <= right)
	{

		//  If the line contains even a single instance of ", ', * or // assume that it is a string literal or a comment
		//  and hence break the processing of the current line
		if (str[right] == '\'' || str[right] == '\"' || str[right] == '*' || str[right] == '/')
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

			if (isKeyword(subStr) == true)
			{
				printf("'%s' IS A KEYWORD\n", subStr);
				count_keywords++;
			}

			left = right;
		}
	}
	return;
}

// DRIVER FUNCTION
int main()
{
	FILE *filePtr;
	char *line;
	filePtr = fopen("test.c", "r");

	if (NULL == filePtr)
	{
		printf("File can't be opened\n");
		return -1;
	}

	while ((fgets(line, 128, filePtr)) != NULL)
	{
		parse(line);
	}

	printf("The number of keywords in the given program is: %d", count_keywords);

	fclose(filePtr);

	return (0);
}
