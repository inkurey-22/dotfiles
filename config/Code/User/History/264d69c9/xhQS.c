/*
** EPITECH PROJECT, 2025
** star
** File description:
** main
*/

#include <stdio.h>
#include <stdlib.h>

#include "star.h"

int main(int ac, char **av)
{
    if (ac != 2) {
        fprintf(stderr, "Usage: %s <size>\n", av[0]);
        return 1;
    }

    unsigned int size = atoi(av[1]);
/*     if (size < 1) {
        fprintf(stderr, "Size must be a positive integer.\n");
        return 1;
    } */
    star(size);
    return 0;
}