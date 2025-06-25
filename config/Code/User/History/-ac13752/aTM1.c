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
Test(my_strcmp, both_null)
{
    cr_assert_eq(my_strcmp(NULL, NULL), 0);
}

Test(my_strcmp, first_null)
{
    cr_assert_eq(my_strcmp(NULL, "abc"), -'a');
}

Test(my_strcmp, second_null)
{
    cr_assert_eq(my_strcmp("abc", NULL), 'a');
}

Test(my_strcmp, empty_strings)
{
    cr_assert_eq(my_strcmp("", ""), 0);
}

Test(my_strcmp, first_empty_second_nonempty)
{
    cr_assert_eq(my_strcmp("", "a"), -'a');
}

Test(my_strcmp, first_nonempty_second_empty)
{
    cr_assert_eq(my_strcmp("a", ""), 'a');
}

Test(my_strcmp, different_lengths)
{
    cr_assert_lt(my_strcmp("abc", "abcd"), 0);
    cr_assert_gt(my_strcmp("abcd", "abc"), 0);
}