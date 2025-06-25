/*
** EPITECH PROJECT, 2024
** B-CPE-100-LIL-1-1-countisland-theophile.riffe
** File description:
** count island
*/

#include <stddef.h>

void fill(char **world, int i, int j, int count)
{
    if (world[i][j] == 'X'){
        world[i][j] = count + '0';
        if (world[i + 1] != NULL)
            fill(world, i + 1, j, count);
        if (i != 0)
            fill(world, i - 1, j, count);
        if (world[i][j + 1] != '\0')
            fill(world, i, j + 1, count);
        if (j != 0)
            fill(world, i, j - 1, count);
    }
}

int check_line(char **world, int i, int count)
{
    for (int j = 0; world[i][j] != '\0'; j++)
        if (world[i][j] == 'X'){
            fill(world, i, j, count);
            count++;
        }
    return count;
}

int count_island(char **world)
{
    int count = 0;

    if (world == NULL)
        return 0;
    for (int i = 0; world[i] != NULL; i++)
        count = check_line(world, i, count);
    return count;
}
