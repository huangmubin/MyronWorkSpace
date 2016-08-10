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

//// MARK: 实例 表达式求值

typedef struct ExpressionsStackNode {
    // 0: Value; 1: Sign;
    int tag;
    union {
        double v;
        char c;
    } data;
    struct ExpressionsStackNode *next;
} EStack;

EStack *CreateExpression() {
    EStack *s;
    s = (EStack *)malloc(sizeof(struct ExpressionsStackNode));
    s->next = NULL;
    return s;
}

int IsEmptyExpression(EStack *s) {
    return (s->next == NULL);
}

void PushExpression(double v, EStack *s) {
    EStack *tmp;
    tmp = (EStack *)malloc(sizeof(struct ExpressionsStackNode));
    tmp->data.v = v;
    tmp->next = s->next;
    s->next = tmp;
}

double PopExpression(EStack *s) {
    EStack *top;
    double v;
    if (IsEmptyExpression(s)) {
        return 0;
    } else {
        top = s->next;
        s->next = top->next;
        v = top->data.v;
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
    v->tag = 0;
    s->tag = 1;
    
    double result = 0;
    double a;
    double d;
    char c;
    while (1) {
        
    }
}
// MARK: - Main Funcion
void cTestFunction() {
    
}