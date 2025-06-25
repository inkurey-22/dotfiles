/*
** EPITECH PROJECT, 2025
** day06
** File description:
** test_my_str_isupper
*/

#include <criterion/criterion.h>

int my_str_isupper(char const *str);

Test(my_str_isupper, only_uppercase_letters)
{
    cr_assert_eq(my_str_isupper("ABCDEFGHIJKLMNOPQRSTUVWXYZ"), 1);
}

Test(my_str_isupper, contains_lowercase_letters)
{
    cr_assert_eq(my_str_isupper("ABCdefGHI"), 0);
}

Test(my_str_isupper, empty_string)
{
    cr_assert_eq(my_str_isupper(""), 1);
}

Test(my_str_isupper, only_lowercase_letters)
{
    cr_assert_eq(my_str_isupper("abcdef"), 0);
}

Test(my_str_isupper, special_characters)
{
    cr_assert_eq(my_str_isupper("ABC!@#"), 0);
}

Test(my_str_isupper, single_uppercase_letter)
{
    cr_assert_eq(my_str_isupper("Z"), 1);
}

Test(my_str_isupper, single_lowercase_letter)
{
    cr_assert_eq(my_str_isupper("z"), 0);
}

Test(my_str_isupper, numbers_in_string)
{
    cr_assert_eq(my_str_isupper("ABC123"), 0);
}

Test(my_str_isupper, space_in_string)
{
    cr_assert_eq(my_str_isupper("ABC DEF"), 0);
}
