/*
** EPITECH PROJECT, 2024
** error
** File description:
** error
*/

#include "amazed.h"

#include <string.h>

int check_error(robot_t *robot)
{
    if (robot->room->indiceLinks == 0
        || (!robot->room->link_s && robot->room->link_s[0] == NULL)) {
        robot->index = "links";
        robot->error = true;
        return 84;
    }
    return 0;
}

void my_error_putstr(char *str)
{
    write(2, str, strlen(str));
}

int find_bad_comment(char **text)
{
    if (text == NULL) {
        return 84;
    }
    return 0;
}
