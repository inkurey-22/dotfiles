/*
** EPITECH PROJECT, 2025
** day06
** File description:
** test_my_strcmp
*/

#include <criterion/criterion.h>

int my_strcmp(char const *s1, char const *s2);

Test(my_strcmp, equal) {
    cr_assert_eq(my_strcmp("abc", "abc"), 0);
}

Test(my_strcmp, less) {
    cr_assert_lt(my_strcmp("abc", "abd"), 0);
}

Test(my_strcmp, greater) {
    cr_assert_gt(my_strcmp("abd", "abc"), 0);
}
