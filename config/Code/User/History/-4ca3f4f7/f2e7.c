/*
** EPITECH PROJECT, 2021
** star.c
** File description:
** star
*/

#include <stdlib.h>
#include <unistd.h>

void my_putchar(char c)
{
    write(1, &c, 1);
}

int my_size(unsigned int n)
{
    return 6 * n - 3;
}

void print_head(unsigned int n)
{
    int width = my_size(n);

    for (unsigned int i = 1; i <= n; i++) {
        int stars = 2 * i - 1;
        int spaces = (width - stars) / 2 + 1;
        for (int j = 0; j < spaces; j++)
            my_putchar(' ');
        for (int j = 0; j < stars; j++)
            my_putchar((j == 0 || j == stars - 1) ? '*' : ' ');
        my_putchar('\n');
    }
}

void print_arm(unsigned int n)
{
    int limitStars = n * 2 + 1;
    int limitSpace = 2 * n - 3;

    if (n == 1) {
        limitStars = 3;
        limitSpace = 1;
    }
    for (int i = 0; i < limitStars; i++)
        my_putchar('*');
    for (int i = 0; i < limitSpace; i++)
        my_putchar(' ');
    for (int i = 0; i < limitStars; i++)
        my_putchar('*');
    my_putchar('\n');
}

void print_body(unsigned int s)
{
    int bs = my_size(s);

    if (s == 1)
        bs = 8;
    for (int l = 0; l < s; l++) {
        for (int i = 0; i <= bs; i++) {
            int limit = bs - l;
            if (s == 1)
                limit = 5;
            if (i == (l + 1)) {
                my_putchar('*');
            } else if (i == limit) {
                my_putchar('*');
                break;
            } else {
                my_putchar(' ');
            }
        }
        my_putchar('\n');
    }
    for (int l = 0; l < s - 1; l++) {
        for (int i = 0; i <= bs; i++) {
            int limit = (bs + (l - s)) + 2;
            if (i == (s - l - 1)) {
                my_putchar('*');
            } else if (i == limit) {
                my_putchar('*');
                break;
            } else {
                my_putchar(' ');
            }
        }
        my_putchar('\n');
    }
}

void print_foot(unsigned int n)
{
    int i, j, k, m = 1;
    int rows = n;

    for (i = rows; i >= 1; i--) {
        if (n == 1)
            my_putchar(' ');
        for (int m = 0; m < (rows * 2 - 1); m++)
            my_putchar(' ');
        for (j = 1; j <= m; j++)
            my_putchar(' ');
        for (k = 1; k <= (2 * i - 1); k++) {
            if (k == 1 || k == (2 * i - 1))
                my_putchar('*');
            else
                my_putchar(' ');
        }
        m++;
        my_putchar('\n');
    }
}

void star(unsigned int s)
{
    if (s >= 1) {
        print_head(s);
        print_arm(s);
        print_body(s);
        print_arm(s);
        print_foot(s);
    }
}

int main(int ac, char **av)
{
    star(atoi(av[1]));
    return 0;
}
