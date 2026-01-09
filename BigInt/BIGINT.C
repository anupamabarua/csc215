#include <stdio.h>
#include "BIGINT.H"

void set_bigint(numstr, num)
char *numstr;
struct bigint *num;
{
    char last_pos, i;
    num->negative = (numstr[0] == '-');
    num->numdigits = strlen(numstr) - num->negative;
    num->digits = alloc(num->numdigits);
    last_pos = num->numdigits + (num->negative ? 0 : -1);

    for (i = 0; i < num->numdigits; i++) {
        num->digits[i] = numstr[last_pos-i];
    }
}

char* get_bigint(num)
struct bigint *num;
{
   char *numstr;
   char start_pos, i;
   numstr = alloc(num->numdigits + (num->negative ? 2 : 1));
   start_pos = num->negative;
   if (start_pos == 1) numstr[0] = '-';
   for (i = 0; i < num->numdigits; i++) {
       numstr[i+start_pos] = num->digits[num->numdigits-(i+1)];
   }
   numstr[num->numdigits+start_pos] = '\0';
   return numstr;
}

void add_bigints(num1, num2, result)
struct bigint *num1;
struct bigint *num2;
struct bigint *result;
{
    char maxdigits, i, carry, digit1, digit2, sum;
    char leading_zeros;
    
    maxdigits = (num1->numdigits > num2->numdigits) ? num1->numdigits : num2->numdigits;
    result->digits = alloc(maxdigits + 1);
    result->negative = 0;
    carry = 0;
    
    for (i = 0; i < maxdigits; i++) {
        if (i < num1->numdigits) {
            digit1 = num1->digits[i] - '0';
        } else {
            digit1 = 0;
        }
        
        if (i < num2->numdigits) {
            digit2 = num2->digits[i] - '0';
        } else {
            digit2 = 0;
        }
        
        sum = digit1 + digit2 + carry;
        carry = sum / 10;
        result->digits[i] = (sum % 10) + '0';
    }
    
    if (carry > 0) {
        result->digits[maxdigits] = carry + '0';
        result->numdigits = maxdigits + 1;
    } else {
        result->numdigits = maxdigits;
    }
    
    leading_zeros = 0;
    for (i = result->numdigits - 1; i > 0; i--) {
        if (result->digits[i] == '0') {
            leading_zeros++;
        } else {
            break;
        }
    }
    result->numdigits -= leading_zeros;
}

