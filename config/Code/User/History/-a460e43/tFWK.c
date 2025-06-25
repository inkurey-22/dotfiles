/*
** EPITECH PROJECT, 2025
** day06
** File description:
** test_my_strlen
*/

#include <criterion/criterion.h>

int my_strlen(char const *str);

Test(my_strlen, normal) {
    cr_assert_eq(my_strlen("Hello"), 5);
}

Test(my_strlen, empty) {
    cr_assert_eq(my_strlen(""), 0);
}

Test(my_strlen, null) {
    cr_assert_eq(my_strlen(NULL), 0);
}
