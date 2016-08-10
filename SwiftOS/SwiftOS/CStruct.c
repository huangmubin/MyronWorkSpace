//
//  CStruct.c
//  SwiftOS
//
//  Created by 黄穆斌 on 16/8/9.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

// MARK: - include
//#include "CStruct.h"
#include <stdio.h>
#include <stdlib.h>

// MARK: - 线性表 Linear List

// MARK: 数据结构

#define ElementType int
typedef struct Node {
    ElementType Data;
    struct Node *Next;
} List;


// MARK: 操作方式

// 求表长
int Length(List *PtrL) {
    int j = 0;
    List *p = PtrL;
    // 遍历整个链表
    while (p) {
        p = p->Next;
        j++;
    }
    return j;
}

// 按序号进行查找
List *FindKth(int K, List *PtrL) {
    List *p = PtrL;
    int i = 1;
    // 遍历链表，如果 p 为空或 i >= K，则表示已经查到或链表已经遍历结束
    while (p != NULL && i < K) {
        p = p->Next;
        i++;
    }
    if (i == K) {
        return p;
    } else {
        return NULL;
    }
}

// 按值查找
List *Find(ElementType X, List *PtrL) {
    List *p = PtrL;
    // 遍历链表，如果为空则返回空，如果数据等于 X 则返回 p
    while (p != NULL && p->Data != X)
        p = p->Next;
    return p;
}

// 插入
List *Insert(ElementType X, int i, List *PtrL) {
    List *p, *s;
    if (i == 1) {
        s = (List *)malloc(sizeof(List));
        s->Data = X;
        s->Next = PtrL;
        return s;
    } else {
        p = FindKth(i-1, PtrL);
        if (p == NULL) {
            printf("参数 i 出错");
            return NULL;
        } else {
            s = (List *)malloc(sizeof(List));
            s->Data = X;
            // 先指向后面的指针，再把前面的指针指向新值，顺序不可乱，否则会丢失指针
            s->Next = p->Next;
            p->Next = s;
            return PtrL;
        }
    }
}

// 删除
List *Delete(int i, List *PtrL) {
    List *p, *s;
    if (i == 1) {
        s = PtrL;
        if (PtrL != NULL) {
            PtrL = PtrL->Next;
        } else {
            return NULL;
        }
        // 释放掉空间，否则会内存泄露。
        free(s);
        return PtrL;
    } else {
        p = FindKth(i-1, PtrL);
        if (p == NULL) {
            printf("第 %d 个结点不存在",i-1);
            return NULL;
        } else if (p->Next == NULL) {
            printf("第 %d 个结点不存在",i);
            return NULL;
        } else {
            s = p->Next;
            p->Next = s->Next;
            free(s);
            return PtrL;
        }
    }
}


// MAKR: - 广义表 Generalized List
typedef struct GNode {
    // 标志域，0 表示单元素，1 表示是广义表
    int Tag;
    union {
        // 数据
        ElementType Data;
        // 或广义表
        struct GNode *SubList;
    } URegion;
    // 指向下一个结点
    struct GNode *Next;
} GList;

// MARK: - 堆栈 Stack

// MARK: 数据结构
typedef struct StackNode {
    ElementType Data;
    struct StackNode *Next;
} LinkStack;

// MARK: 操作方法

// 建立空栈
LinkStack *CreateStack() {
    LinkStack *S;
    S = (LinkStack *)malloc(sizeof(struct StackNode));
    S->Next = NULL;
    return S;
}

// 判断是否为空
int IsEmpty(LinkStack *s) {
    return (s->Next == NULL);
}

// 入栈
void Push(ElementType item, LinkStack *s) {
    struct StackNode *tmpCell;
    tmpCell = (LinkStack *)malloc(sizeof(struct StackNode));
    tmpCell->Data = item;
    tmpCell->Next = s->Next;
    s->Next = tmpCell;
}

// 删除并返回栈顶元素
ElementType Pop(LinkStack *s) {
    struct StackNode *firstCell;
    ElementType topElem;
    if (IsEmpty(s)) {
        printf("堆栈空");
        return 0;
    } else {
        firstCell = s->Next;
        s->Next = firstCell->Next;
        topElem = firstCell->Data;
        free(firstCell);
        return topElem;
    }
}

//// MARK: 实例 表达式求值 ?? Error

typedef struct ExpressionsStackNode {
    double v;
    char c;
    struct ExpressionsStackNode *next;
} EStack;

EStack *CreateExpression() {
    EStack *s;
    s = (EStack *)malloc(sizeof(struct ExpressionsStackNode));
    s->c = ' ';
    s->v = 0;
    s->next = NULL;
    return s;
}

int IsEmptyExpression(EStack *s) {
    return (s->next == NULL);
}

void PushValue(double v, EStack *s) {
    EStack *tmp;
    tmp = (EStack *)malloc(sizeof(struct ExpressionsStackNode));
    tmp->v = v;
    tmp->next = s->next;
    s->next = tmp;
}

void PushChar(char v, EStack *s) {
    EStack *tmp;
    tmp = (EStack *)malloc(sizeof(struct ExpressionsStackNode));
    tmp->c = v;
    tmp->next = s->next;
    s->next = tmp;
}

double PopValue(EStack *s) {
    EStack *top;
    double v;
    if (IsEmptyExpression(s)) {
        return 0;
    } else {
        top = s->next;
        s->next = top->next;
        v = top->v;
        free(top);
        return v;
    }
}

char PopChar(EStack *s) {
    EStack *top;
    char v;
    if (IsEmptyExpression(s)) {
        return 0;
    } else {
        top = s->next;
        s->next = top->next;
        v = top->c;
        free(top);
        return v;
    }
}

void DeleteExpression(EStack *s) {
    EStack *tmp;
    while (s->next) {
        tmp = s->next;
        s = tmp->next;
        free(tmp);
    }
}

double ValueOfExpressions() {
    EStack *v, *s;
    v = CreateExpression();
    s = CreateExpression();
    PushValue(0, v);
    
    double value = 0;
    char sign;
    char count;
    double a, b;
    while (1) {
        if (scanf("%lf", &value)) {
            PushValue(value, v);
            // printf("value: %.2lf; ", value);
        } else if (scanf("%c", &sign)) {
            if (sign == '=') {
                count = PopChar(s);
                b = PopValue(v);
                a = PopValue(v);
                switch (count) {
                    case '+':
                        return a + b;
                    case '-':
                        return a - b;
                    case '*':
                        return a * b;
                    case '/':
                        return a / b;
                }
            } else if (IsEmptyExpression(s) && (sign == '+' || sign == '-' || sign == '(' || sign == '*' || sign == '/')) {
                PushChar(sign, s);
            } else {
                if (sign == '(' || s->next->c == '(') {
                    PushChar(sign, s);
                } else if (sign == '+' || sign == '-') {
                    count = PopChar(s);
                    b = PopValue(v);
                    a = PopValue(v);
                    switch (count) {
                        case '+':
                            PushValue(a + b, v);
                            break;
                        case '-':
                            PushValue(a - b, v);
                            break;
                        case '*':
                            PushValue(a * b, v);
                            break;
                        case '/':
                            PushValue(a / b, v);
                            break;
                    }
                    PushChar(sign, s);
                } else if (sign == '*' || sign == '/') {
                    if (s->next->c == '+' || s->next->c == '-') {
                        PushChar(sign, s);
                    } else {
                        count = PopChar(s);
                        b = PopValue(v);
                        a = PopValue(v);
                        switch (count) {
                            case '+':
                                PushValue(a + b, v);
                                break;
                            case '-':
                                PushValue(a - b, v);
                                break;
                        }
                        PushChar(sign, s);
                    }
                } else if (sign == ')') {
                    count = PopChar(s);
                    while (count != '(' && !IsEmptyExpression(s)) {
                        b = PopValue(v);
                        a = PopValue(v);
                        switch (count) {
                            case '+':
                                PushValue(a + b, v);
                                break;
                            case '-':
                                PushValue(a - b, v);
                                break;
                            case '*':
                                PushValue(a * b, v);
                                break;
                            case '/':
                                PushValue(a / b, v);
                                break;
                        }
                        count = PopChar(s);
                    }
                }
            }
        }
    }
}
// MARK: - Main Funcion
void cTestFunction() {
    char a;
    do {
        while (1) {
            scanf("%c", &a);
            if (a == '\n') {
                break;
            }
        }
//        if (a == ':') {
            printf("\nresult = %lf;\n", ValueOfExpressions());
//        } else {
//            return;
//        }
    } while (1);
}