/*
** EPITECH PROJECT, 2021
** star.c
** File description:
** star
*/

#include <stdlib.h>
#include <unistd.h>

static void my_putchar(char c)
{
    write(1, &c, 1);
}

static int my_size(unsigned int n)
{
    return 6 * n - 3;
}

static void print_upward_cone(int stars)
{
    for (int k = 1; k <= stars; k++) {
        if (k == 1 || k == stars)
            my_putchar('*');
        else
            my_putchar(' ');
    }
}

void print_head(unsigned int n)
{
    int total_spaces = 0;
    int stars = 0;

    for (int i = 1; i <= (int)n; i++) {
        total_spaces = (n == 1 ? 1 : 0) + (n * 2) + (n - i);
        for (int s = 0; s < total_spaces; s++)
            my_putchar(' ');
        stars = 2 * i - 1;
        print_upward_cone(stars);
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

// Helper to print a single line of the body
static void print_body_line(int line_len, int first_star, int second_star)
{
    for (int i = 0; i <= line_len; i++) {
        if (i == first_star || i == second_star)
            my_putchar('*');
        else
            my_putchar(' ');
        if (i == second_star)
            break;
    }
    my_putchar('\n');
}

// Upper part of the body
static void print_body_upper(unsigned int s, int bs)
{
    int first_star = 0;
    int second_star = 0;

    for (int l = 0; l < (int)s; l++) {
        first_star = l + 1;
        second_star = (s == 1) ? 5 : bs - l;
        print_body_line(bs, first_star, second_star);
    }
}

// Lower part of the body
static void print_body_lower(unsigned int s, int bs)
{
    for (int l = 0; l < (int)s - 1; l++) {
        int first_star = s - l - 1;
        int second_star = (bs + (l - s)) + 2;
        print_body_line(bs, first_star, second_star);
    }
}

void print_body(unsigned int s)
{
    int bs = (s == 1) ? 8 : my_size(s);
    print_body_upper(s, bs);
    print_body_lower(s, bs);
}

static void print_downward_cone(int stars)
{
    for (int k = 1; k <= stars; k++) {
        if (k == 1 || k == stars)
            my_putchar('*');
        else
            my_putchar(' ');
    }
}

void print_foot(unsigned int n)
{
    int rows = n;
    int total_spaces = 0;
    int stars = 0;

    for (int i = rows; i >= 1; i--) {
        total_spaces = (n == 1 ? 1 : 0) + (n * 2) + (rows - i);
        for (int s = 0; s < total_spaces; s++)
            my_putchar(' ');
        stars = 2 * i - 1;
        print_downward_cone(stars);
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
