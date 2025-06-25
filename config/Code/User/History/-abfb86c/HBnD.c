/*
** EPITECH PROJECT, 2025
** day06
** File description:
** test_my_strcpy
*/

#include <criterion/criterion.h>

char *my_strcpy(char *dest, char const *src);

Test(my_strcpy, normal) {
    char dest[20];
    my_strcpy(dest, "Hello");
    cr_assert_str_eq(dest, "Hello");
}

Test(my_strcpy, empty) {
    char dest[20];
    my_strcpy(dest, "");
    cr_assert_str_eq(dest, "");
}