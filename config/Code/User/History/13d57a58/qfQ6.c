/*
** EPITECH PROJECT, 2024
** B-CPE-200-LIL-2-1-amazed-yanis.monte
** File description:
** display.c
*/

#include "amazed.h"

static int add_word(char *buffer, char *word, int indice)
{
    int i = 0;

    while (word[i] != 0) {
        buffer[indice + i] = word[i];
        i++;
    }
    buffer[indice + i] = '\n';
    return (i + 1);
}

static int get_size(robot_t *robot)
{
    char ***room = robot->room->alR;
    char **link_e = robot->room->link_e;
    char *start = robot->room_start[0];
    char *end = robot->room_end[0];
    int size = 35 + my_nblen(robot->num_robot);

    if (robot->index && strcmp(robot->index, "links") == 0)
        size -= 9;
    for (int i = 0; room[i] != 0; i++) {
        if (start && strcmp(room[i][0], start) == 0)
            size += 8;
        if (end && strcmp(room[i][0], end) == 0)
            size += 6;
        size += my_strlen(room[i][0]) + 1;
        size += my_strlen(room[i][1]) + 1;
        size += my_strlen(room[i][2]) + 1;
    }
    for (int i = 0; link_e[i] != 0; i++)
        size += my_strlen(link_e[i]) + my_strlen(robot->room->link_s[i]) + 2;
    return (size);
}

static int add_room(robot_t *robot, char *buffer, char ***room, int i)
{
    char *start = robot->room_start[0];
    char *end = robot->room_end[0];

    for (int j = 0; room[j] != 0; j++) {
        if (start && strcmp(room[j][0], robot->room_start[0]) == 0)
            i += add_word(buffer, "##start", i);
        if (end && strcmp(room[j][0], robot->room_end[0]) == 0)
            i += add_word(buffer, "##end", i);
        i += add_word(buffer, room[j][0], i) - 1;
        i += add_word(buffer, " ", i) - 1;
        i += add_word(buffer, room[j][1], i) - 1;
        i += add_word(buffer, " ", i) - 1;
        i += add_word(buffer, room[j][2], i);
    }
    return i;
}

void display(robot_t *robot)
{
    int i = 0;
    int size = get_size(robot);
    char *buffer = my_str_malloc(size);

    add_word(buffer, "#number_of_robots", 0);
    add_word(buffer, my_nb_to_str(robot->num_robot), 18);
    add_word(buffer, "#rooms", my_nblen(robot->num_robot) + 19);
    i = my_nblen(robot->num_robot) + 26;
    i = add_room(robot, buffer, robot->room->alR, i);
    if (robot->index && strcmp(robot->index, "links") != 0)
        i += add_word(buffer, "#tunnels", i);
    for (int j = 0; robot->room->link_e[j] != 0; j++) {
        i += add_word(buffer, robot->room->link_s[j], i) - 1;
        i += add_word(buffer, "-", i) - 1;
        i += add_word(buffer, robot->room->link_e[j], i);
    }
    my_putstr(buffer);
}
