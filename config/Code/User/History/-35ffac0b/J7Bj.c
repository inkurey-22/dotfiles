/*
** EPITECH PROJECT, 2024
** start_end
** File description:
** start_end
*/

#include "amazed.h"

void room_start(char **text, robot_t *robot)
{
    char **buffer = NULL;

    for (int i = 0; text[i] != NULL; i++) {
        if (strcmp(text[i], "##start\n") == 0) {
            buffer = my_str_to_word_array(text[i + 1], " \n");
            robot->room_start[0] = buffer[0];
            robot->room_start[1] = buffer[1];
            robot->room_start[2] = buffer[2];
            robot->room_start[3] = 0;
            free(buffer);
            robot->indice_start += 1;
            i++;
        }
    }
}

void room_end(char **text, robot_t *robot)
{
    char **buffer = NULL;

    room_start(text, robot);
    for (int i = 0; text[i] != NULL; i++) {
        if (strcmp(text[i], "##end\n") == 0) {
            buffer = my_str_to_word_array(text[i + 1], " \n");
            robot->room_end[0] = buffer[0];
            robot->room_end[1] = buffer[1];
            robot->room_end[2] = buffer[2];
            robot->room_end[3] = 0;
            free(buffer);
            robot->indice_end += 1;
            i++;
        }
    }
}
