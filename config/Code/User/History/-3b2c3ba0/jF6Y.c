/*
** EPITECH PROJECT, 2024
** B-CPE-100-LIL-1-1-cpoolday06-theophile.riffe
** File description:
** test strncpy
*/

#include <criterion/criterion.h>

char *my_strncpy(char *dest, char const *src, int n);

Test(my_strncpy, normal) {
    char dest[20];
    my_strncpy(dest, "Hello", 3);
    dest[3] = '\0';
    cr_assert_str_eq(dest, "Hel");
}

Test(my_strncpy, n_longer_than_src) {
    char dest[20];
    my_strncpy(dest, "Hi", 5);
    cr_assert_str_eq(dest, "Hi");
}

Test(my_strncpy, null_src) {
    char dest[20];
    cr_assert_null(my_strncpy(dest, NULL, 5));
}
