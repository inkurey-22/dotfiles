/*
** EPITECH PROJECT, 2023
** lem-in
** File description:
** init_moves.c
*/

#include "amazed.h"

#include <stdio.h>

node_t *find_path(node_t *node)
{
    for (node_link_list_t *list = node->link_list; list; list = list->next)
        if (list->link->pres == false || list->link->dist_to_end == 0)
            return list->link;
    return NULL;
}

void move_robots(walk_bot_t **array, node_t *test, int i)
{
    for (; array[i] != NULL; i++){
        test = find_path(array[i]->room);
        if (test != NULL) {
            array[i]->room->pres = false;
            array[i]->room = test;
            array[i]->room->pres = true;
            mini_printf("P%d-%s", i + 1, array[i]->room->room);
            break;
        }
    }
    i++;
    for (; array[i] != NULL; i++){
        test = find_path(array[i]->room);
        if (test != NULL) {
            array[i]->room->pres = false;
            array[i]->room = test;
            array[i]->room->pres = true;
            mini_printf(" P%d-%s", i + 1, array[i]->room->room);
        }
    }
}

int all_robot_is_arrived(walk_bot_t **array)
{
    for (int i = 0; array[i] != 0; i++)
        if (array[i]->room->dist_to_end != 0)
            return (0);
    return (1);
}

int get_robots(robot_t *robot, node_t *graph)
{
    walk_bot_t **array = malloc(sizeof(walk_bot_t *) * (robot->num_robot + 1));
    node_t *test = NULL;
    int i = 0;

    if (array == NULL || robot->num_robot <= 0)
        return 84;
    array[robot->num_robot] = 0;
    for (int i = 0; i < robot->num_robot; i++) {
        array[i] = malloc(sizeof(walk_bot_t));
        array[i]->room = graph;
    }
    printf("#moves\n");
    while (!all_robot_is_arrived(array)) {
        move_robots(array, test, i);
        putchar('\n');
    }
    return 0;
}
