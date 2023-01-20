Firstly use the command lex countKeywords.l
This would produce a file named `lex.yy.c`
Run this file using the command gcc lex.yy.c
This would produce an a.exe file
Run this executable file using the command ./a.exe

To remove the unwanted spaces in the terminal/cmd use the command gcc lex.yy.c -DECHO
