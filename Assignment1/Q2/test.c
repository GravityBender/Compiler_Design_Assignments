#include<stdio.h>
#include<string.h>

struct test
{
    int rollNumber;
    char name[10];
};


int main() {
    
    struct test test1;
    strcpy(test1.name, "Garvit");
    test1.rollNumber = 78;

    printf("The value of the struct is: %d: %s", test1.rollNumber, test1.name);

    return 0;
}
