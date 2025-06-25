/*
** EPITECH PROJECT, 2025
** day06
** File description:
** test_my_str_isprintable
*/

#include <criterion/criterion.h>
int my_str_isprintable(char const *str);

Test(my_str_isprintable, all_printable)
{
    cr_assert_eq(my_str_isprintable("Hello, World!"), 1);
}

Test(my_str_isprintable, contains_non_printable)
{
    cr_assert_eq(my_str_isprintable("Hello\x01World"), 0);
    cr_assert_eq(my_str_isprintable("Hello\x7FWorld"), 0);
}

Test(my_str_isprintable, empty_string)
{
    cr_assert_eq(my_str_isprintable(""), 1);
}

Test(my_str_isprintable, only_printable_ascii)
{
    cr_assert_eq(my_str_isprintable("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_+-=[]{}|;':,.<>/?`~\"\\ "), 1);
}

Test(my_str_isprintable, only_non_printable_ascii)
{
    cr_assert_eq(my_str_isprintable("\x01\x02\x03\x04\x05"), 0);
}

Test(my_str_isprintable, printable_and_non_printable_mix)
{
    cr_assert_eq(my_str_isprintable("abc\x10def"), 0);
}

Test(my_str_isprintable, single_printable_char)
{
    cr_assert_eq(my_str_isprintable("A"), 1);
}

Test(my_str_isprintable, single_non_printable_char)
{
    cr_assert_eq(my_str_isprintable("\x1F"), 0);
}

Test(my_str_isprintable, string_with_space)
{
    cr_assert_eq(my_str_isprintable(" "), 1);
}

Test(my_str_isprintable, string_with_del)
{
    cr_assert_eq(my_str_isprintable("abc\x7F"), 0);
}
