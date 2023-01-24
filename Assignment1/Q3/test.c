#include<stdio.h>
#include<string.h>

#define PI "3.145"

struct test
{
    int roll_Number;
    char name[10];
};

void fun () {
    //  Do Nothing
    printf("You are wrong!");
}

int main() {
    const int x[] = {0, 1};
    const char yChar ='3';
    struct test test1;
    strcpy(test1.name, "Garvit");
    test1.roll_Number = 78;

    for (int i = 0; i < 2; i++)
    {
        printf("Value: %d", x[i]);
    }
    

    fun();

    printf("The value of the struct is: %d: %s", test1.roll_Number, test1.name);

    return 0;
}
