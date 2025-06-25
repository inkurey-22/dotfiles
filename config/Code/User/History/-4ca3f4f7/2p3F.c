/*
** EPITECH PROJECT, 2021
** star.c
** File description:
** star
*/

#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>

void my_putchar(char c)
{
    write(1, &c, 1);
}

int my_size(unsigned int n)
{
    return 4 * n - 1;
}

void print_head(unsigned int n)
{
    int width = my_size(n);
    for (unsigned int i = 1; i <= n; i++) {
        int stars = 2 * i - 1;
        int spaces = (width - stars) / 2;
        for (int j = 0; j < spaces; j++)
            my_putchar(' ');
        for (int j = 0; j < stars; j++)
            my_putchar((j == 0 || j == stars - 1) ? '*' : ' ');
        my_putchar('\n');
    }
}

void print_arm(unsigned int n)
{
    int width = my_size(n);
    int arm = 2 * n + 1;
    int gap = width - 2 * arm;
    for (int i = 0; i < arm; i++)
        my_putchar('*');
    for (int i = 0; i < gap; i++)
        my_putchar(' ');
    for (int i = 0; i < arm; i++)
        my_putchar('*');
    my_putchar('\n');
}

void print_body(unsigned int n)
{
    int width = my_size(n);
    for (unsigned int l = 0; l < n; l++) {
        for (int i = 0; i < width; i++) {
            if (i == l + 1 || i == width - l - 2)
                my_putchar('*');
            else
                my_putchar(' ');
        }
        my_putchar('\n');
    }
    for (unsigned int l = 1; l < n; l++) {
        for (int i = 0; i < width; i++) {
            if (i == n - l - 1 || i == width - (n - l))
                my_putchar('*');
            else
                my_putchar(' ');
        }
        my_putchar('\n');
    }
}

void print_foot(unsigned int n)
{
    int width = my_size(n);
    for (int i = n; i >= 1; i--) {
        int stars = 2 * i - 1;
        int spaces = (width - stars) / 2;
        for (int j = 0; j < spaces; j++)
            my_putchar(' ');
        for (int j = 0; j < stars; j++)
            my_putchar((j == 0 || j == stars - 1) ? '*' : ' ');
        my_putchar('\n');
    }
}

void star(unsigned int n)
{
    if (n >= 1) {
        print_head(n);
        print_arm(n);
        print_body(n);
        print_arm(n);
        print_foot(n);
    }
}

int main(int ac, char **av)
{
    if (ac != 2) {
        write(2, "Usage: ./star <size>\n", 21);
        return 84;
    }
    int n = atoi(av[1]);
    if (n < 1) {
        write(2, "Size must be >= 1\n", 18);
        return 84;
    }
    star((unsigned int)n);
    return 0;
}
