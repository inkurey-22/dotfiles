/*
** EPITECH PROJECT, 2024
** B-CPE-100-LIL-1-1-cpoolday06-theophile.riffe
** File description:
** tet revstr
*/

char *my_revstr(char *str);
#include <criterion/criterion.h>

Test (my_revstr, classic)
{
    char my_str[] = "Hello World!"; 
    my_revstr(my_str);
    cr_assert_str_eq(my_str, "!dlroW olleH");
}
