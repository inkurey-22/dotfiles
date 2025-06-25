/*
** EPITECH PROJECT, 2024
** B-CPE-100-LIL-1-1-cpoolday10-theophile.riffe
** File description:
** sort word array
*/

#include "my.h"

/* static int word_array_len(char **tab)
{
    int i = 0;

    while (tab[i] != NULL)
        i++;
    return i;
}

static void sort_params_step(char **tab, int i, int len)
{
    int j = i + 1;
    char *tmp = NULL;

    while (j < len) {
        if (my_strcmp(tab[i], tab[j]) > 0) {
            tmp = tab[i];
            tab[i] = tab[j];
            tab[j] = tmp;
        }
        j++;
    }
}

int my_sort_word_array(char **tab)
{
    int i = 0;
    int len = word_array_len(tab);

    while (i < len - 1) {
        sort_params_step(tab, i, len);
        i++;
    }
    return tab;
} */