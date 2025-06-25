#include <stdio.h>
#include <limits.h>

static void my_putchar(char c) {
    putchar(c);
}

static void print_sep(int n) {
    if (n == 9 || n == 89 || n == 789 || n == 6789 || n == 56789 || n == 456789
        || n == 3456789 || n == 23456789 || n == 123456789) {
        my_putchar('\n');
    } else {
        my_putchar(',');
        my_putchar(' ');
    }
}

static int my_put_nbr(int n)
{
    if (n == INT_MIN) {
        my_putchar('-');
        my_putchar('2');
        n = 147483648;
    } else if (n < 0) {
        my_putchar('-');
        n = -n;
    }
    if (n >= 10) {
        my_put_nbr(n / 10);
    }
    my_putchar(n % 10 + '0');
    return 0;
}

static void print_with_leading_zeros(int n, int curr_num)
{
    int num_digits = 0;
    int temp = curr_num;

    if (curr_num == 0)
        num_digits = 1;
    else {
        while (temp > 0) {
            num_digits++;
            temp /= 10;
        }
    }
    for (int i = 0; i < n - num_digits; i++)
        my_putchar('0');
    my_put_nbr(curr_num);
}

static void generate_combinations(int n, int start, int curr_num, int curr_digit)
{
    if (curr_digit == n) {
        print_with_leading_zeros(n, curr_num);
        //print_sep(curr_num);
        my_putchar('\n');
        return;
    }
    for (int i = start; i <= 9; i++)
        generate_combinations(n, i + 1, curr_num * 10 + i, curr_digit + 1);
}

static int my_print_combn(int n)
{
    if (n < 1 || n > 10)
        return 0;
    generate_combinations(n, 0, 0, 0);
    return 0;
}

int main()
{
    my_print_combn(4);
    return 0;
}
