/*
** EPITECH PROJECT, 2025
** star
** File description:
** main
*/

#include <stdlib.h>

int main(int ac, char **av)
{
    if (ac != 2) {
        write(2, "Usage: ./star <size>\n", 21);
        return 84;
    }

    unsigned int size = atoi(av[1]);
    if (size < 1) {
        write(2, "Size must be a positive integer.\n", 34);
        return 84;
    }

    star(size);
    return 0;
}
