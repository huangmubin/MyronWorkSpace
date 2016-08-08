//
//  Test.c
//  CProject
//
//  Created by 黄穆斌 on 16/8/8.
//  Copyright © 2016年 Myron. All rights reserved.
//

// MARK: 4-2 多项式求值
/*
#include <stdio.h>

#define MAXN 10

double f( int n, double a[], double x );

int main()
{
    int n, i;
    double a[MAXN], x;
				
    scanf("%d %lf", &n, &x);
    for ( i=0; i<=n; i++ )
        scanf("%lf", &a[i]);
    printf("%.1f\n", f(n, a, x));
    return 0;
}

double f(int n, double a[], double x) {
    double sum = a[0];
    double num = 1;
    for (int i = 1; i <= n; i++) {
        num = num * x;
        sum = sum + a[i] * num;
    }
    return sum;
}
*/

// MARK: 4-3 简单求和
/*
#include <stdio.h>

#define MAXN 10

int Sum ( int List[], int N );

int main ()
{
    int List[MAXN], N, i;
    
    scanf("%d", &N);
    for ( i=0; i<N; i++ )
        scanf("%d", &List[i]);
    printf("%d\n", Sum(List, N));
    
    return 0;
}

int Sum(int List[], int N) {
    int sum;
    for(int i = 0; i < N; i++)
        sum += List[i];
    return sum;
}
*/

// MARK: 4-4 求自定类型元素的平均
/*
#include <stdio.h>

#define MAXN 10
typedef float ElementType;

ElementType Average( ElementType S[], int N );

int main ()
{
    ElementType S[MAXN];
    int N, i;
    
    scanf("%d", &N);
    for ( i=0; i<N; i++ )
        scanf("%f", &S[i]);
    printf("%.2f\n", Average(S, N));
    
    return 0;
}

ElementType Average(ElementType S[], int N) {
    ElementType sum = 0;
    for(int i = 0; i < N; i++)
        sum += S[i];
    return sum / N;
}
*/
// MARK: 4-5 求自定类型元素的最大值
/*
#include <stdio.h>

#define MAXN 10
typedef float ElementType;

ElementType Max( ElementType S[], int N );

int main ()
{
    ElementType S[MAXN];
    int N, i;
    
    scanf("%d", &N);
    for ( i=0; i<N; i++ )
        scanf("%f", &S[i]);
    printf("%.2f\n", Max(S, N));
    
    return 0;
}

ElementType Max(ElementType S[], int N) {
    ElementType Max = S[0];
    for(int i = 1; i < N; i++)
        if (Max < S[i])
            Max = S[i];
    return Max;
}
*/
// MARK: 4-6 求单链表结点的阶乘和
/*
#include <stdio.h>
#include <stdlib.h>

typedef struct Node *PtrToNode;
struct Node {
    int Data;
    PtrToNode Next;
};
typedef PtrToNode List;

int FactorialSum( List L );

int main()
{
    int N, i;
    List L, p;
    
    scanf("%d", &N);
    L = NULL;
    for ( i=0; i<N; i++ ) {
        p = (List)malloc(sizeof(struct Node));
        scanf("%d", &p->Data);
        p->Next = L;  L = p;
    }
    printf("%d\n", FactorialSum(L));
    return 0;
}

int FactorialSum(List L) {
    int total = 0;
    int sum;
    while (L != NULL) {
        sum = 1;
        for (int i = 2; i <= L->Data; i++) {
            sum *= i;
        }
        total += sum;
        L = L->Next;
    }
    return total;
}
*/
// MARK: 4-7 统计某类完全平方数
/*
#include <stdio.h>
#include <math.h>

int IsTheNumber ( const int N );

int main()
{
    int n1, n2, i, cnt;
				
    scanf("%d %d", &n1, &n2);
    cnt = 0;
    for ( i=n1; i<=n2; i++ ) {
        if ( IsTheNumber(i) )
            cnt++;
    }
    printf("cnt = %d\n", cnt);
    
    return 0;
}

//
int IsTheNumber(const int N) {
    int n = (int)sqrt(N);
    if (n*n == N) {
        int s[10]= {0};
        int clip = 10;
        int result;
        while (N * 10 > clip) {
            result = N % clip;
            result /= (clip / 10);
            clip *= 10;
            s[result] += 1;
            if (s[result] > 1) {
                return 1;
            }
        }
    }
    return 0;
}
*/

// MARK: 4-8 简单阶乘计算
/*
#include <stdio.h>

int Factorial( const int N );

int main()
{
    int N, NF;
				
    scanf("%d", &N);
    NF = Factorial(N);
    if (NF)  printf("%d! = %d\n", N, NF);
    else printf("Invalid input\n");
    
    return 0;
}

int Factorial(const int N) {
    int total = 1;
    if (N < 0)
        return 0;
    for (int i = 2; i <= N; i++)
        total *= i;
    return total;
}
*/
// MARK: 4-9 统计个位数字
/*
#include <stdio.h>

int Count_Digit ( const int N, const int D );

int main()
{
    int N, D;
				
    scanf("%d %d", &N, &D);
    printf("%d\n", Count_Digit(N, D));
    return 0;
}

int Count_Digit(const int N, const int D) {
    int c = N;
    int t = 0;
    if (c < 0)
        c = -c;
    if (c == 0 && c == D)
        t = 1;
    while (c > 0) {
        if (c % 10 == D)
            t++;
        c /= 10;
    }
    return t;
}
*/
// MARK: 4-10 阶乘计算升级版
/*
#include <stdio.h>

void Print_Factorial ( const int N );

int main()
{
    int N;
				
    scanf("%d", &N);
    Print_Factorial(N);
    return 0;
}

#define MAX 10
#define SIZE 3000

void Print_Factorial(const int N) {
    if (N < 0) {
        printf("Invalid input");
    } else {
        int total[SIZE] = {0};
        total[0] = 1;
        int big = 1;
        int add = 0;
        int j = 0;
        for (int i = 2; i <= N; i++) {
            if (i == 15) {
                printf("");
            }
            for (j = 0; j < big; j++) {
                total[j] *= i;
                total[j] += add;
                add = total[j] / MAX;
                total[j] %= MAX;
            }
            while (add > 0) {
                big++;
                total[big-1] = add % MAX;
                add /= MAX;
            }
            //            printf("i = %d; ", i);
            //            for (int m = big; m > 0; m--) {
            //                printf("%d", total[m-1]);
            //            }
            //            printf("\n");
        }
        
        for (; big > 0; big--) {
            printf("%d", total[big-1]);
        }
    }
}
*/