#include <stdio.h>
#include <stdlib.h>
void Print_Factorial ( const int N );

int main()
{
    int N;
    
    scanf("%d", &N);
    Print_Factorial(N);
    return 0;
}


typedef struct {
    int Data;
    struct Node *next;
} List;

void Print_Factorial(const int N) {
    if (N < 0)
        printf("Invalid input");
    
    List *top;
    top = (List *)malloc(sizeof(List));
    
}