#include <stdio.h>
#include "LINKLIST.H"
#define NULL 0

struct node *mknode(n) int n; {
    struct node* x;
    x = alloc(4);
    x->num = n;
    x->next = NULL;
    return x;
}
struct node* insertBeforeNode(head, newval, beforeval)
struct node* head;
int newval;
int beforeval;
{
    struct node* x;
    struct node* prev;
    struct node* cur;

    if (head == NULL) {
        return mknode(newval);
    }

    if (head->num == beforeval) {
        x = mknode(newval);
        x->next = head;
        return x;
    }

    prev = head;
    cur  = head->next;

    while (cur != NULL) {
        if (cur->num == beforeval) {
            x = mknode(newval);
            x->next = cur;
            prev->next = x;
            return head;
        }
        prev = cur;
        cur = cur->next;
    }
    
    return head;
}
