/*
** EPITECH PROJECT, 2025
** day06
** File description:
** test_my_strlowcase
*/

#include <criterion/criterion.h>

char *my_strlowcase(char *str);

Test(my_strlowcase, converts_uppercase_to_lowercase)
{
    char str[] = "HELLO";
    cr_assert_str_eq(my_strlowcase(str), "hello");
}

Test(my_strlowcase, leaves_lowercase_unchanged)
{
    char str[] = "world";
    cr_assert_str_eq(my_strlowcase(str), "world");
}

Test(my_strlowcase, handles_mixed_case)
{
    char str[] = "HeLLoWoRLd";
    cr_assert_str_eq(my_strlowcase(str), "helloworld");
}

Test(my_strlowcase, handles_empty_string)
{
    char str[] = "";
    cr_assert_str_eq(my_strlowcase(str), "");
}

Test(my_strlowcase, handles_non_alpha_characters)
{
    char str[] = "1234!@# ABC xyz";
    cr_assert_str_eq(my_strlowcase(str), "1234!@# abc xyz");
}

Test(my_strlowcase, handles_only_uppercase)
{
    char str[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    cr_assert_str_eq(my_strlowcase(str), "abcdefghijklmnopqrstuvwxyz");
}

Test(my_strlowcase, handles_only_lowercase)
{
    char str[] = "abcdefghijklmnopqrstuvwxyz";
    cr_assert_str_eq(my_strlowcase(str), "abcdefghijklmnopqrstuvwxyz");
}