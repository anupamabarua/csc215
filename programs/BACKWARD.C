#include <stdio.h>
#define MAXLINE 1024

void reverse(char s[]) {
    int i, j;
    char temp;
    
    // length of string
    i = 0;
    while (s[i] != '\0') {
        i++;
    }