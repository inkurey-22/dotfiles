/*
** EPITECH PROJECT, 2024
** number_robot
** File description:
** number_robot
*/

#include "amazed.h"

int find_number_of_robot(char **text, robot_t *robot)
{
    int result = atoi(text[0]);

    if (my_str_is_alpha(text[0]) == 1) {
        robot->num_robot = -1;
        robot->index = my_strdup(text[0]);
        return 84;
    }
    if (result <= 0) {
        robot->num_robot = -1;
        robot->index = my_strdup(text[0]);
        return 84;
    }
    robot->num_robot = result;
    return 0;
}
