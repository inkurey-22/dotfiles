/*
** EPITECH PROJECT, 2023
** B-PSU-100-LIL-1-1-navy-gaspard.grignet-le-perron
** File description:
** my.h
*/

#ifndef MY_H
    #define MY_H

    #include <fcntl.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <unistd.h>
    #include <sys/wait.h>
    #include <sys/stat.h>
    #include <stdarg.h>
    #include <stdbool.h>

void my_putchar(char c);
void free_array(char **buffer);
void my_word_array_free(char **word_array);
void *my_memset(void *data, int c, unsigned int len);

int my_nblen(int n);
void my_put_nbr(int nb);
int my_str_is_alpha(char *str);
int my_getnbr(char const *str);
int my_strlen(char const *str);
void my_putstr(char const *str);
int my_get_number(char *nb_in_str);
int my_str_is_alphanumeric(char *str);
int my_char_in_str(char c, char *str);
int my_compute_power_it(int nb, int p);
int mini_printf(const char *format, ...);
int my_word_array_len(char **word_array);
int my_strcmp(char const *s1, char const *s2);
int my_strncmp(char const *s1, char const *s2, int n);

char *my_revstr(char *str);
char *my_nb_to_str(int nb);
char *my_strdup(char *str);
char *my_str_malloc(int size);
char *my_str_to_min(char *str);
char *my_rev_str_word(char *str);
char *my_word_array_alpha(char *str);
char *my_get_word(char *str, int place);
char *my_str_realloc(char *str, int size);
char *get_env_elt(char **env, char *name);
char *my_strcat(char *dest, char const *src);

char **my_str_to_word_array(char *str, char *del);
#endif
