/*
** EPITECH PROJECT, 2024
** B-CPE-200-LIL-2-1-amazed-yanis.monte
** File description:
** init_robot
*/

#include "amazed.h"

#include <string.h>

robot_t *init_robot(void)
{
    robot_t *robot = malloc(sizeof(robot_t));
    rooms_t *rooms = malloc(sizeof(rooms_t));

    memset(robot, 0, sizeof(robot_t));
    memset(rooms, 0, sizeof(rooms_t));
    robot->error = false;
    robot->index = "initialisation";
    robot->num_robot = -1;
    robot->indice_end = 0;
    robot->indice_start = 0;
    robot->room_end = malloc(sizeof(char *) * 4);
    robot->room_start = malloc(sizeof(char *) * 4);
    robot->room_end[0] = NULL;
    robot->room_start[0] = NULL;
    robot->room = rooms;
    robot->room->indiceAllrooms = 0;
    robot->room->indiceLinks = 0;
    return robot;
}

static void free_robot_all_room(robot_t *robot)
{
    for (int i = 0; robot->room->alR[i] != 0; i++) {
        free(robot->room->alR[i][0]);
        free(robot->room->alR[i][1]);
        free(robot->room->alR[i][2]);
        free(robot->room->alR[i]);
    }
}

void free_robot(robot_t *robot)
{
    free_robot_all_room(robot);
    for (int i = 0; robot->room->link_e[i] != 0; i++) {
        free(robot->room->link_e[i]);
        free(robot->room->link_s[i]);
    }
    for (int i = 0; robot->room_end[i] != 0; i++) {
        free(robot->room_end[i]);
        free(robot->room_start[i]);
    }
    free(robot->room->alR);
    free(robot->room->link_e);
    free(robot->room->link_s);
    free(robot->room);
    free(robot->room_start);
    free(robot->room_end);
    free(robot);
}
