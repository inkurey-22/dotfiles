/*
** EPITECH PROJECT, 2024
** my_lib
** File description:
** my_put_nbr
*/

#include <limits.h>
void my_putchar(char);

int my_put_nbr2(int n)
{
    if (n >= 10)
        my_put_nbr2(n / 10);
    my_putchar(n % 10 + '0');
    return 0;
}

int my_put_nbr(int n)
{
    if (n == INT_MIN) {
        my_putchar('-');
        my_putchar('2');
        n = 147483648;
    } else if (n < 0){
        my_putchar('-');
        n = - n;
    }
    my_put_nbr2(n);
    return 0;
}

int special_cases(int n)
{
    if (n == INT_MIN) {
        my_putchar('-');
        my_putchar('2');
        n = 147483648;
    } else if (n < 0) {
        my_putchar('-');
        n *= -1;
    }
    return n;
}

int my_put_nbr_it(int n)
{
    int digits[10];
    int i = 0;

    if (n == 0) {
        my_putchar('0');
        return 0;
    }
    n = special_cases(n);
    while (n > 0) {
        digits[i] = n % 10;
        i++;
        n /= 10;
    }
    for (int j = i - 1; j >= 0; j--)
        my_putchar(digits[j] + '0');
    return 0;
}

int main(void)
{
    my_put_nbr_it(123456789);
    my_putchar('\n');
    my_put_nbr_it(-123456789);
    my_putchar('\n');
    my_put_nbr_it(0);
    my_putchar('\n');
    my_put_nbr_it(INT_MIN);
    return 0;
}
