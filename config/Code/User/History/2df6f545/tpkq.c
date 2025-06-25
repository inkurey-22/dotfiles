/*
** EPITECH PROJECT, 2023
** my_putstr
** File description:
** day04
*/

#include "../../include/lib.h"

void my_putstr(char const *str)
{
    write(1, str, my_strlen(str));
}
