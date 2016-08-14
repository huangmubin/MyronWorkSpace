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
} List, QueueNote;

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

typedef struct StackNode {
    ElementType data;
    struct StackNode *next;
} Stack;

Stack *createStack() {
    Stack *s;
    s = (Stack *)malloc(sizeof(struct StackNode));
    s->data = 0;
    s->next = NULL;
    return s;
}

int isEmptyStack(Stack *s) {
    return s->next == NULL;
}

void deleteStack(Stack *s) {
    Stack *p;
    while (s != NULL) {
        p = s->next;
        free(s);
        s = p;
    }
}

void printfStack(Stack *s) {
    Stack *p;
    p = s->next;
    while (p != NULL) {
        printf("%d - ", p->data);
        p = p->next;
    }
}

void pushStack(Stack *s, ElementType item) {
    Stack *new;
    new = (Stack *)malloc(sizeof(struct StackNode));
    new->data = item;
    new->next = s->next;
    s->next = new;
}

ElementType popStack(Stack *s) {
    ElementType data;
    Stack *top;
    top = s->next;
    data = top->data;
    s->next = top->next;
    free(top);
    return data;
}

ElementType topStack(Stack *s) {
    return s->next->data;
}

int countOfStack(Stack *s) {
    Stack *p;
    int number = 0;
    p = s->next;
    while (p != NULL) {
        number += 1;
        p = p->next;
    }
    return number;
}

// MARK: - 队列 Queue

// Node 添加 QueueNode
typedef struct QueueStruct {
    QueueNote *front;
    QueueNote *rear;
} Queue;

Queue *createQueue() {
    Queue *q = (Queue *)malloc(sizeof(struct QueueStruct));
    q->front = q->rear = (QueueNote *)malloc(sizeof(struct Node));
    q->front->Data = 0;
    q->front->Next = 0;
    return q;
}

void deleteQueue(Queue *q) {
    while (q->front) {
        q->rear = q->front->Next;
        free(q->front);
        q->front = q->rear;
    }
    free(q);
}

void clearQueue(Queue *q) {
    while (q->front->Next) {
        q->rear = q->front->Next;
        free(q->front);
        q->front = q->rear;
    }
}

int isEmptyQueue(Queue *q) {
    return q->front == q->rear;
}

int countQueue(Queue *q) {
    int i;
    QueueNote *t = q->front;
    while (t != q->rear) {
        i++;
        t = t->Next;
    }
    return i;
}

ElementType topQueueItem(Queue *q) {
    return q->front->Data;
}

ElementType popQueue(Queue *q) {
    ElementType i;
    QueueNote *t;
    if (isEmptyQueue(q)) {
        printf("Queue is Empty, can't pop.\n");
        exit(1);
    } else {
        t = q->front->Next;
        free(q->front);
        q->front = t;
        i = t->Data;
        return i;
    }
}

void pushQueue(Queue *q, ElementType i) {
    QueueNote *t = (QueueNote *)malloc(sizeof(struct Node));
    t->Data = i;
    t->Next = NULL;
    q->rear->Next = t;
    q->rear = t;
}

void printQueue(Queue *q) {
    if (isEmptyQueue(q)) {
        printf("Queue is Empty");
        return;
    }
    QueueNote *t = q->front->Next;
    while (t) {
        printf("%d ", t->Data);
        t = t->Next;
    }
    printf("\n");
}

// MARK: - Tree

typedef struct TreeNode {
    ElementType data;
    struct TreeNode *left;
    struct TreeNode *right;
} BinTree;

/**
 先序遍历
 1. 访问根节点
 2. 先序遍历左子树
 3. 先序遍历右子树
 */
void preOrderTraversal(BinTree *bt) {
    // /* 递归法
    if (bt) {
        printf("%d", bt->data);
        preOrderTraversal(bt->left);
        preOrderTraversal(bt->right);
    }
    // */
    /* 非递归法，使用堆栈进行
    BinTree *t = bt;
     */
}

/**
 中序遍历
 1. 中序遍历左子树
 2. 根节点
 3. 中序遍历右子树
 */
void inOrderTraversal(BinTree *bt) {
    // /* 递归法
    if (bt) {
        preOrderTraversal(bt->left);
        printf("%d", bt->data);
        preOrderTraversal(bt->right);
    }
    //  */
    // /* 非递归法，使用堆栈进行
    BinTree *t = bt;
    Stack *s = createStack();
    while (t || !isEmptyStack(s)) {
        while (t) {
            pushStack(s, t->data);
            t = t->left;
        }
        if (!isEmptyStack(s)) {
            printf("%5d", popStack(s));
            t = t->right;
        }
    }
    //  */
}

/**
 后序遍历
 1. 后序遍历左子树
 2. 后序遍历右子树
 3. 访问根节点
 */
void postOrderTraversal(BinTree *bt) {
    if (bt) {
        preOrderTraversal(bt->left);
        preOrderTraversal(bt->right);
        printf("%d", bt->data);
    }
}


// MARK: - Main Funcion
void cTestFunction() {
    
    Queue *q = createQueue();
    
    for (int i = 0; i < 10; i++)
        pushQueue(q, i);
    
    printQueue(q);
    deleteQueue(q);
    printQueue(q);
}