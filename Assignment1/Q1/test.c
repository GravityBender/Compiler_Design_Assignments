#include<stdio.h>
#include<string.h>

struct test
{
    int roll_Number;
    char name[10];
};

void fun() {
    //  Do Nothing
}

void fun(int x) {
    //  Do Nothing
}

int main() {
    
    struct test test1;
    strcpy(test1.name, "Garvit");
    test1.roll_Number = 78;

    printf("The value of the struct is: %d: %s", test1.roll_Number, test1.name);

    return 0;
}
