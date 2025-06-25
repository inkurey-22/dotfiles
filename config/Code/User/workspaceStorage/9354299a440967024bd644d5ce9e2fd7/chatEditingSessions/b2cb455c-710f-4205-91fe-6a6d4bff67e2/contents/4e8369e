/*
** EPITECH PROJECT, 2025
** day06
** File description:
** test_my_str_islower
*/

#include <criterion/criterion.h>
int my_str_islower(char const *str);

Test(my_str_islower, all_lower)
{
    cr_assert_eq(my_str_islower("hello"), 1);
}

Test(my_str_islower, mixed_case)
{
    cr_assert_eq(my_str_islower("heLlo"), 0);
}

Test(my_str_islower, empty_string)
{
    cr_assert_eq(my_str_islower(""), 1);
}

Test(my_str_islower, all_uppercase)
{
    cr_assert_eq(my_str_islower("HELLO"), 0);
}

Test(my_str_islower, numbers_and_symbols)
{
    cr_assert_eq(my_str_islower("hello123"), 0);
    cr_assert_eq(my_str_islower("hello!"), 0);
}

Test(my_str_islower, single_lowercase_char)
{
    cr_assert_eq(my_str_islower("a"), 1);
}

Test(my_str_islower, single_uppercase_char)
{
    cr_assert_eq(my_str_islower("A"), 0);
}

Test(my_str_islower, only_symbols)
{
    cr_assert_eq(my_str_islower("!@#$"), 0);
}

Test(my_str_islower, long_lowercase_string)
{
    cr_assert_eq(my_str_islower("abcdefghijklmnopqrstuvwxyz"), 1);
}
