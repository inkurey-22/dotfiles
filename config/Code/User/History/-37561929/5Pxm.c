/*
** EPITECH PROJECT, 2024
** B-CPE-100-LIL-1-1-cpoolday06-theophile.riffe
** File description:
** test str_isalpha 
*/

int my_str_isalpha(char const *str);
#include <criterion/criterion.h>

Test(my_str_isalpha, all_alpha)
{
    cr_assert_eq(my_str_isalpha("Hello"), 1);
}

Test(my_str_isalpha, mixed_content)
{
    cr_assert_eq(my_str_isalpha("Hello1"), 0);
}

Test(my_str_isalpha, empty_string)
{
    cr_assert_eq(my_str_isalpha(""), 1);
}

Test(my_str_isalpha, all_uppercase)
{
    cr_assert_eq(my_str_isalpha("ABCDEF"), 1);
}

Test(my_str_isalpha, all_lowercase)
{
    cr_assert_eq(my_str_isalpha("abcdef"), 1);
}

Test(my_str_isalpha, special_characters)
{
    cr_assert_eq(my_str_isalpha("abc!def"), 0);
}

Test(my_str_isalpha, space_in_string)
{
    cr_assert_eq(my_str_isalpha("abc def"), 0);
}

Test(my_isalpha, lower_boundaries)
{
    extern int my_isalpha(char);
    cr_assert_eq(my_isalpha('a'), 1);
    cr_assert_eq(my_isalpha('z'), 1);
    cr_assert_eq(my_isalpha('a' - 1), 0);
    cr_assert_eq(my_isalpha('z' + 1), 0);
}

Test(my_isalpha, upper_boundaries)
{
    extern int my_isalpha(char);
    cr_assert_eq(my_isalpha('A'), 1);
    cr_assert_eq(my_isalpha('Z'), 1);
    cr_assert_eq(my_isalpha('A' - 1), 0);
    cr_assert_eq(my_isalpha('Z' + 1), 0);
}

Test(my_isalpha, non_alpha)
{
    extern int my_isalpha(char);
    cr_assert_eq(my_isalpha('1'), 0);
    cr_assert_eq(my_isalpha('!'), 0);
    cr_assert_eq(my_isalpha(' '), 0);
}

Test(my_str_isalpha, null_input)
{
    // Behavior is undefined for NULL, but let's check for crash
    // Uncomment if you want to test, but this will likely segfault:
    cr_assert_eq(my_str_isalpha(NULL), 1);
}
