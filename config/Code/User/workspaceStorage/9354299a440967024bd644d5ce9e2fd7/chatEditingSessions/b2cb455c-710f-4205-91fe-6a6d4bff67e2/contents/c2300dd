/*
** EPITECH PROJECT, 2024
** B-CPE-100-LIL-1-1-cpoolday06-theophile.riffe
** File description:
** test_my_strstr
*/

#include <stddef.h>
#include <criterion/criterion.h>

char *my_strstr(char *, char *);

Test(my_strstr, basic) {
    char str[] = "Hello World";
    char to_find[] = "Wor";
    cr_assert_str_eq(my_strstr(str, to_find), "World");
}

Test(my_strstr, null_to_find) {
    char str[] = "Hello World";
    char to_find[] = {0};
    cr_assert_str_eq(my_strstr(str, to_find), "Hello World");
}

Test(my_strstr, not_found) {
    char str[] = "Hello World";
    char to_find[] = "abc";
    cr_assert_null(my_strstr(str, to_find));
}

Test(my_strstr, find_at_start) {
    char str[] = "Hello World";
    char to_find[] = "Hello";
    cr_assert_str_eq(my_strstr(str, to_find), "Hello World");
}

Test(my_strstr, find_at_end) {
    char str[] = "Hello World";
    char to_find[] = "World";
    cr_assert_str_eq(my_strstr(str, to_find), "World");
}

Test(my_strstr, empty_str) {
    char str[] = "";
    char to_find[] = "abc";
    cr_assert_null(my_strstr(str, to_find));
}

Test(my_strstr, both_empty) {
    char str[] = "";
    char to_find[] = "";
    cr_assert_str_eq(my_strstr(str, to_find), "");
}

Test(my_strstr, to_find_longer_than_str) {
    char str[] = "abc";
    char to_find[] = "abcdef";
    cr_assert_null(my_strstr(str, to_find));
}

Test(my_strstr, str_null) {
    char *str = NULL;
    char to_find[] = "abc";
    cr_assert_null(my_strstr(str, to_find));
}

Test(my_strstr, to_find_null) {
    char str[] = "Hello World";
    char *to_find = NULL;
    cr_assert_str_eq(my_strstr(str, to_find), str);
}

Test(my_strstr, partial_match) {
    char str[] = "abcdefg";
    char to_find[] = "cde";
    cr_assert_str_eq(my_strstr(str, to_find), "cdefg");
}

Test(my_strstr, no_match_at_all) {
    char str[] = "abcdefg";
    char to_find[] = "xyz";
    cr_assert_null(my_strstr(str, to_find));
}

Test(my_strstr, match_full_string) {
    char str[] = "abcdefg";
    char to_find[] = "abcdefg";
    cr_assert_str_eq(my_strstr(str, to_find), "abcdefg");
}

Test(my_strstr, match_single_char) {
    char str[] = "abcdefg";
    char to_find[] = "d";
    cr_assert_str_eq(my_strstr(str, to_find), "defg");
}

Test(my_strstr, match_last_char) {
    char str[] = "abcdefg";
    char to_find[] = "g";
    cr_assert_str_eq(my_strstr(str, to_find), "g");
}
