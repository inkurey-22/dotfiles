/*
** EPITECH PROJECT, 2025
** day06
** File description:
** test_my_strupcase
*/

#include <criterion/criterion.h>

char *my_strupcase(char *str);

Test(my_strupcase, converts_lowercase_to_uppercase)
{
    char str[] = "hello";
    cr_assert_str_eq(my_strupcase(str), "HELLO");
}

Test(my_strupcase, leaves_uppercase_unchanged)
{
    char str[] = "WORLD";
    cr_assert_str_eq(my_strupcase(str), "WORLD");
}

Test(my_strupcase, handles_mixed_case)
{
    char str[] = "HeLLoWoRLd";
    cr_assert_str_eq(my_strupcase(str), "HELLOWORLD");
}

Test(my_strupcase, handles_empty_string)
{
    char str[] = "";
    cr_assert_str_eq(my_strupcase(str), "");
}

Test(my_strupcase, handles_non_alpha_characters)
{
    char str[] = "1234!@# abc XYZ";
    cr_assert_str_eq(my_strupcase(str), "1234!@# ABC XYZ");
}

Test(my_strupcase, handles_only_lowercase)
{
    char str[] = "abcdefghijklmnopqrstuvwxyz";
    cr_assert_str_eq(my_strupcase(str), "ABCDEFGHIJKLMNOPQRSTUVWXYZ");
}