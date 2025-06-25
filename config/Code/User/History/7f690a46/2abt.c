/*
** EPITECH PROJECT, 2023
** B-CPE-200-LIL-2-1-amazed-yanis.monte
** File description:
** utils.c
*/

#include "amazed.h"

void remove_link(node_link_list_t *link, char *room)
{
    node_link_list_t *tmp = link;

    if (link == NULL)
        return;
    if (strcmp(link->link->room, room) == 0) {
        link = link->next;
        free(tmp);
        return;
    }
    if (link->next == NULL)
        return;
    while (link->next->next != NULL && strcmp(link->link->room, room) != 0)
        link = link->next;
    if (strcmp(link->next->link->room, room) != 0
    && strcmp(link->link->room, room) != 0)
        return;
    tmp = link->next;
    link->next = link->next->next;
    free(tmp);
    return;
}

int is_link(node_t *node, node_t *node_link)
{
    for (node_link_list_t *tmp = node->link_list; tmp; tmp = tmp->next)
        if (strcmp(tmp->link->room, node_link->room) == 0)
            return (1);
    return (0);
}

node_t *get_node(node_link_list_t *node_list, char *room)
{
    for (node_link_list_t *tmp = node_list; tmp; tmp = tmp->next)
        if (strcmp(room, tmp->link->room) == 0)
            return (tmp->link);
    return (NULL);
}

void connect_node(node_t *node1, node_t *node2)
{
    node_link_list_t *temp = node1->link_list;
    node_link_list_t *link_list = malloc(sizeof(node_link_list_t));

    link_list->next = temp;
    link_list->link = node2;
    node1->link_list = link_list;
}

node_t *create_node(int dist_to_end, char *room)
{
    node_t *node = malloc(sizeof(node_t));

    node->room = room;
    node->dist_to_end = dist_to_end;
    node->link_list = NULL;
    node->pres = false;
    return (node);
}
