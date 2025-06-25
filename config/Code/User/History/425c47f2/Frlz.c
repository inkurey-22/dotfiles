#include <stdio.h>
#include <limits.h>

static void my_putchar(char c) {
    putchar(c);
}

static void print_sep(int n, int curr_num) {
    if (n == 1 && curr_num == 9)
        my_putchar('\n');
    else if (n == 2 && curr_num == 89)
        my_putchar('\n');
    else if (n == 3 && curr_num == 789)
        my_putchar('\n');
    else if (n == 4 && curr_num == 6789)
        my_putchar('\n');
    else if (n == 5 && curr_num == 56789)
        my_putchar('\n');
    else if (n == 6 && curr_num == 456789)
        my_putchar('\n');
    else if (n == 7 && curr_num == 3456789)
        my_putchar('\n');
    else if (n == 8 && curr_num == 23456789)
        my_putchar('\n');
    else if (n == 9 && curr_num == 123456789)
        my_putchar('\n');
    else
        my_putchar(',');
    my_putchar(' ');
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
        print_sep(n, curr_num);
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
    my_print_combn(3);
    return 0;
}
