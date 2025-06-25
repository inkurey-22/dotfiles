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
