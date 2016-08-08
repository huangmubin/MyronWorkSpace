// MARK: 5-1 厘米换算英尺英寸

#include "stdio.h"

int main() {
    int a, b, c;
    double t;
    scanf("%d", &a);
    if (a < 0)
        return 0;
    
    t = (double)a / 100 / 0.3048;
    b = (int)t;
    c = (int)((t-b)*12);
    printf("%d %d", b, c);
}


//// MARK: 4-11 求自定类型元素序列的中位数
//
//#include <stdio.h>
//
//#define MAXN 10
//typedef float ElementType;
//
//ElementType Median( ElementType A[], int N );
//
//int main ()
//{
//    ElementType A[MAXN];
//    int N, i;
//    
//    scanf("%d", &N);
//    for ( i=0; i<N; i++ )
//        scanf("%f", &A[i]);
//    printf("%.2f\n", Median(A, N));
//    
//    return 0;
//}
//
//// 交互位置
//void Swap(ElementType *a, ElementType *b){
//    ElementType temp = *a;
//    *a = *b;
//    *b = temp;
//}
//
//
//ElementType Median3(ElementType A[], int Left, int Right){
//    int Center = (Left + Right) / 2;
//    if(A[Left]>A[Center])
//        Swap( &A[Left], &A[Center] );
//    if(A[Left]>A[Right])
//        Swap( &A[Left], &A[Right] );
//    if(A[Center]>A[Right])
//        Swap( &A[Center], &A[Right] );
//    Swap( &A[Center], &A[Right-1] );
//    return A[Right-1];
//}
//
//void QSort(ElementType A[], int Left, int Right){
//    if(Left>=Right) return;
//    ElementType Pivot = Median3(A, Left, Right);
//    int i = Left, j = Right - 1;
//    while(1){
//        while( A[++i] < Pivot ) { }
//        while( A[--j] > Pivot) { }
//        if( i<j )
//            Swap(&A[i], &A[j]);
//        else break;
//    }
//    Swap(&A[i], &A[Right-1]);
//    QSort(A, Left, i-1);
//    QSort(A, i+1, Right);
//}
//
//ElementType Median( ElementType A[], int N ){
//    QSort(A, 0, N-1);
//    return A[N/2];
//}