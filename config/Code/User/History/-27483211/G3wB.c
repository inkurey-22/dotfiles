/*
** EPITECH PROJECT, 2024
** room
** File description:
** room
*/

#include "amazed.h"

static void init_links(robot_t *r, int indi, char **buffer)
{
    r->room->link_s[indi] = buffer[0];
    r->room->link_e[indi] = buffer[1];
    r->room->link_s[indi + 1] = 0;
    r->room->link_e[indi + 1] = 0;
}

static void init_rooms(robot_t *robot, int size)
{
    robot->room->alR = malloc(sizeof(char **) * size);
    for (int i = 0; i < size; i++)
        robot->room->alR[i] = NULL;
    robot->room->link_e = malloc(sizeof(char *) * size);
    robot->room->link_s = malloc(sizeof(char *) * size);
    robot->room->link_s[robot->room->indiceLinks] = 0;
    robot->room->link_e[robot->room->indiceLinks] = 0;
}

static int verify_link(robot_t *r, int indi)
{
    bool room_s = false;
    bool room_e = false;

    for (int i = r->room->indiceAllrooms - 1; i >= 0; i--) {
        if (strcmp(r->room->alR[i][0], r->room->link_s[indi]) == 0)
            room_s = true;
        if (strcmp(r->room->alR[i][0], r->room->link_e[indi]) == 0)
            room_e = true;
    }
    if (room_s && room_e)
        return (0);
    else
        return (84);
}

static int errror_handling_links(robot_t *r, int indi, char **text, int i)
{
    if (verify_link(r, indi) == 84) {
        r->error = true;
        r->index = my_strdup(text[i]);
        r->room->link_e[indi] = NULL;
        r->room->link_e[indi] = NULL;
        return 84;
    }
    return 0;
}

static int do_link_buffer(robot_t *r, char **buffer, char **text, int i)
{
    int indi = r->room->indiceLinks;

    if (r->indice_start == 0) {
        room_end(text, r);
        if (r->indice_start != 1 || r->indice_end != 1) {
            r->error = true;
            r->index = NULL;
            return 84;
        }
    }
    if (buffer[1] == NULL)
        return 84;
    init_links(r, indi, buffer);
    if (errror_handling_links(r, indi, text, i) == 84)
        return 84;
    r->room->indiceLinks++;
    return 0;
}

int verify_names(robot_t *robot, char **telltale)
{
    for (int i = robot->room->indiceAllrooms - 1; i >= 0; i--) {
        if (strcmp(robot->room->alR[i][0], telltale[0]) == 0 ||
        (strcmp(robot->room->alR[i][1], telltale[1]) == 0
        && strcmp(robot->room->alR[i][2], telltale[2]) == 0)) {
            robot->index = "links";
            robot->room->alR[i + 1] = NULL;
            return 84;
        }
    }
    return 0;
}

int compare_buffer(char **text, int i, char **buffer, robot_t *r)
{
    if (buffer[1] == NULL) {
        free(buffer);
        buffer = my_str_to_word_array(text[i], " \n");
        supprimer_null_strings(buffer);
        if (buffer[1] == NULL || buffer[2] == NULL)
            return 84;
        r->room->alR[r->room->indiceAllrooms] = malloc(sizeof(char *) * 3);
        r->room->alR[r->room->indiceAllrooms][0] = buffer[0];
        r->room->alR[r->room->indiceAllrooms][1] = buffer[1];
        r->room->alR[r->room->indiceAllrooms][2] = buffer[2];
        if (verify_names(r, r->room->alR[r->room->indiceAllrooms]) == 84)
            return 84;
        r->room->indiceAllrooms++;
        return 0;
    } else {
        if (do_link_buffer(r, buffer, text, i) == 84)
            return 84;
        return 0;
    }
}

int compare_and_error_handling(char **t, int i, int telltale, robot_t *robot)
{
    char **buffer = NULL;

    if (t[i][0] != '#') {
        buffer = my_str_to_word_array(t[i], "-\n");
        telltale = compare_buffer(t, i, buffer, robot);
    }
    if (telltale == 84) {
        robot->index = my_strdup(t[i]);
        return 84;
    }
    return 0;
}

int find_rooms(char **t, robot_t *robot)
{
    int telltale = 0;
    int size = my_word_array_len(t) + 1;
    int indice = 0;

    init_rooms(robot, size);
    for (int i = 1; t[i] != NULL; i++) {
        indice = 1;
        if (compare_and_error_handling(t, i, telltale, robot) == 84)
            return 84;
    }
    if (indice == 0) {
        robot->error = true;
        return 84;
    }
    return 0;
}
