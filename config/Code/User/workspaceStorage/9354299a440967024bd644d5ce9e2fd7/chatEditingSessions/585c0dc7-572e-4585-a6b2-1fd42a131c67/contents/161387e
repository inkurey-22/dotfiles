/*
** EPITECH PROJECT, 2025
** day06
** File description:
** test_my_str_isnum
*/

#include <criterion/criterion.h>

int my_str_isnum(char const *str);

Test(my_str_isnum, only_digits)
{
    cr_assert_eq(my_str_isnum("1234567890"), 1);
}

Test(my_str_isnum, contains_letters)
{
    cr_assert_eq(my_str_isnum("123abc456"), 0);
}

Test(my_str_isnum, empty_string)
{
    cr_assert_eq(my_str_isnum(""), 1);
}

Test(my_str_isnum, only_letters)
{
    cr_assert_eq(my_str_isnum("abcdef"), 0);
}

Test(my_str_isnum, special_characters)
{
    cr_assert_eq(my_str_isnum("123!@#"), 0);
}

Test(my_str_isnum, negative_number)
{
    cr_assert_eq(my_str_isnum("-12345"), 0);
}

Test(my_str_isnum, spaces_in_string)
{
    cr_assert_eq(my_str_isnum("123 456"), 0);
}

Test(my_str_isnum, single_digit)
{
    cr_assert_eq(my_str_isnum("7"), 1);
}

Test(my_str_isnum, single_non_digit)
{
    cr_assert_eq(my_str_isnum("a"), 0);
}
