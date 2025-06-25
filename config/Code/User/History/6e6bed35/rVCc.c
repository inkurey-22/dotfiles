/*
** EPITECH PROJECT, 2023
** my_put_nbr
** File description:
** lib
*/

#include "../../include/lib.h"

void my_put_nbr(int nb)
{
    int i = 1;
    int del_nb = 1;

    if (nb < 0) {
        my_putchar('-');
        nb = nb * (-1);
    }
    while (nb / i >= 10) {
        i = i * 10;
    }
    while (i != 1) {
        del_nb = nb / i;
        my_putchar(del_nb + 48);
        nb = nb - del_nb * i;
        i = i / 10;
    }
    my_putchar(nb + 48);
}
