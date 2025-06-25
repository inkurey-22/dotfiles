/*
** EPITECH PROJECT, 2024
** B-CPE-100-LIL-1-1-cpoolday10-theophile.riffe
** File description:
** do_op
*/

#include "../include/my.h"
#include "do_op.h"

static int add(int a, int b)
{
    return a + b;
}

static int sub(int a, int b)
{
    return a - b;
}

static int mul(int a, int b)
{
    return a * b;
}

static int divide(int a, int b)
{
    return a / b;
}

static int mod(int a, int b)
{
    return a % b;
}

int do_op(int a, char op, int b)
{
    op_t ops[] = {
        {'+', add},
        {'-', sub},
        {'*', mul},
        {'/', divide},
        {'%', mod},
    };
    for (int i = 0; i < 5; i++) {
        if (ops[i].op == op)
            return ops[i].func(a, b);
    }
    return 0;
}

int main(int ac, char **av)
{
    int a = 0;
    int b = 0;

    if (ac != 4)
        return 84;
    a = my_getnbr(av[1]);
    b = my_getnbr(av[3]);
    if (av[2][0] != '+' && av[2][0] != '-' && av[2][0] != '*' &&
        av[2][0] != '/' && av[2][0] != '%')
        return 84;
    if (av[2][1] != '\0')
        return 84;
    if (b == 0 && av[2][0] == '/')
        return 84;
    my_put_nbr(do_op(a, av[2][0], b));
    my_putchar('\n');
    return 0;
}
