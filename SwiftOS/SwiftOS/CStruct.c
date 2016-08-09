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
        return NULL;
    } else {
        firstCell = s->Next;
        s->Next = firstCell->Next;
        topElem = firstCell->Data;
        free(firstCell);
        return topElem;
    }
}

// MARK: 实例 表达式求值
union {
    // 数据
    ElementType Data;
    // 或广义表
    struct GNode *SubList;
} URegion;
#define TestDataType int
typedef struct TestStackNode {
    union {
        TestDataType v;
        char c;
    } uregion;
    struct TestStackNode *next;
} TestStack;

// 建立空栈
TestStack *CreateTestStack() {
    TestStack *S;
    S = (TestStack *)malloc(sizeof(struct TestStackNode));
    S->next = NULL;
    return S;
}

// 判断是否为空
int TestIsEmpty(TestStack *s) {
    return (s->next == NULL);
}

// 入栈
void TestPush(TestDataType item, TestStack *s) {
    TestStack *tmp;
    tmp = (TestStack *)malloc(sizeof(struct TestStackNode));
    tmp->uregion.v = item;
    tmp->next = s->next;
    s->next = tmp;
}

// 删除并返回栈顶元素
TestDataType TestPop(TestStack *s) {
    TestStack *firstCell;
    TestDataType topElem;
    if (TestIsEmpty(s)) {
        printf("堆栈空");
        return 0;
    } else {
        firstCell = s->next;
        s->next = firstCell->next;
        topElem = firstCell->uregion.v;
        free(firstCell);
        return topElem;
    }
}


TestDataType ValueOfExpressions() {
    ValueStack *v;
    SignStack *s;
    v = (ValueStack *)malloc(sizeof(ValueStack));
    s = (SignStack *)malloc(sizeof(SignStack));
    
    TestDataType result;
    char c;
    while (1) {
        if (scanf("%d", &result)) {
            
            printf("input a int %d\n", result);
        } else if (scanf("%c", &c)) {
            switch (c) {
                case '(':
                    printf("(\n");
                    break;
                case ')':
                    printf(")\n");
                    break;
                case '+':
                    printf("+\n");
                    break;
                case '-':
                    printf("-\n");
                    break;
                case '*':
                    printf("*\n");
                    break;
                case '/':
                    printf("/\n");
                    break;
                case '%':
                    printf("%%\n");
                    break;
                default:
                    break;
            }
        }
    }
    
    return result;
}


// MARK: - Main Funcion
void cTestFunction() {
    ValueOfExpressions();
}