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
Test(my_revstr, empty_string)
{
    char my_str[] = "";
    my_revstr(my_str);
    cr_assert_str_eq(my_str, "");
}

Test(my_revstr, single_character)
{
    char my_str[] = "A";
    my_revstr(my_str);
    cr_assert_str_eq(my_str, "A");
}

Test(my_revstr, even_length)
{
    char my_str[] = "abcd";
    my_revstr(my_str);
    cr_assert_str_eq(my_str, "dcba");
}

Test(my_revstr, odd_length)
{
    char my_str[] = "abcde";
    my_revstr(my_str);
    cr_assert_str_eq(my_str, "edcba");
}

Test(my_revstr, null_input)
{
    cr_assert_null(my_revstr(NULL));
}

Test(my_revstr, special_characters)
{
    char my_str[] = "a!@#b";
    my_revstr(my_str);
    cr_assert_str_eq(my_str, "b#@!a");
}