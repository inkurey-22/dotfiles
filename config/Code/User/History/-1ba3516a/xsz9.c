/*
** EPITECH PROJECT, 2024
** B-CPE-100-LIL-1-1-cpoolday11-theophile.riffe
** File description:
** add in sorted list
*/

#include "mylist.h"
#include <stdlib.h>

void my_add_in_sorted_list(linked_list_t **begin, void *data, int (*cmp)())
{
    linked_list_t *new = malloc(sizeof(linked_list_t));
    linked_list_t *current;

    if (new == NULL)
        return;
    new->data = data;
    if (*begin == NULL || cmp(data, (*begin)->data) < 0) {
        new->next = *begin;
        *begin = new;
        return;
    }
    current = *begin;
    while (current->next != NULL && cmp(data, current->next->data) >= 0)
        current = current->next;
    new->next = current->next;
    current->next = new;
}