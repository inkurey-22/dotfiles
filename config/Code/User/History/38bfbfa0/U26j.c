/*
** EPITECH PROJECT, 2023
** B-CPE-200-LIL-2-1-amazed-yanis.monte
** File description:
** create_graph.c
*/

#include "amazed.h"

static node_link_list_t *create_node_list(robot_t *robot)
{
    node_link_list_t *node_list = NULL;
    node_link_list_t *tmp;

    for (int i = 0; robot->room->alR[i] != 0; i++) {
        tmp = node_list;
        node_list = malloc(sizeof(node_link_list_t));
        node_list->link = create_node(-1, robot->room->alR[i][0]);
        if (strcmp(node_list->link->room, robot->room_end[0]) == 0)
            node_list->link->dist_to_end = 0;
        node_list->next = tmp;
    }
    return (node_list);
}

void check_link(robot_t *r, node_link_list_t *node, node_t *last, node_t *new)
{
    if (new->dist_to_end == -1) {
        connect_node(new, last);
        new->dist_to_end = last->dist_to_end + 1;
        add_link(r, node, new);
        return;
    } else if (last->dist_to_end < new->dist_to_end && !is_link(new, last)) {
        remove_link(last->link_list, new->room);
        connect_node(new, last);
        new->dist_to_end = last->dist_to_end + 1;
    }
    if (last->dist_to_end > new->dist_to_end && !is_link(last, new)) {
        remove_link(new->link_list, last->room);
        connect_node(last, new);
        last->dist_to_end = new->dist_to_end + 1;
    }
    return;
}

void add_link(robot_t *robot, node_link_list_t *node_list, node_t *last)
{
    node_t *node;

    for (int i = 0; robot->room->link_s[i] != 0; i++) {
        if (strcmp(last->room, robot->room->link_s[i]) == 0) {
            node = get_node(node_list, robot->room->link_e[i]);
            check_link(robot, node_list, last, node);
        }
        if (strcmp(last->room, robot->room->link_e[i]) == 0) {
            node = get_node(node_list, robot->room->link_s[i]);
            check_link(robot, node_list, last, node);
        }
    }
}

node_t *create_graph(robot_t *robot)
{
    node_link_list_t *node_list = create_node_list(robot);
    node_t *start;

    robot->node_list = node_list;
    for (node_link_list_t *tmp = node_list; tmp; tmp = tmp->next) {
        if (tmp->link->dist_to_end == 0)
            add_link(robot, node_list, tmp->link);
    }
    for (node_link_list_t *tmp = node_list; tmp; tmp = tmp->next) {
        if (strcmp(tmp->link->room, robot->room_start[0]) == 0)
            start = tmp->link;
    }
    if (start->link_list == NULL) {
        return (NULL);
    }
    return (start);
}
