/*
** EPITECH PROJECT, 2024
** B-CPE-100-LIL-1-1-cpoolday06-theophile.riffe
** File description:
** test strncmp
*/

#include <criterion/criterion.h>

int my_strncmp(char const *s1, char const *s2, int n);

Test(my_strncmp, equal_strings) {
    cr_assert_eq(my_strncmp("abcde", "abcde", 5), 0);
}

Test(my_strncmp, equal_prefix) {
    cr_assert_eq(my_strncmp("abcdef", "abcxyz", 3), 0);
}

Test(my_strncmp, s1_greater) {
    cr_assert_gt(my_strncmp("abd", "abc", 3), 0);
}

Test(my_strncmp, s2_greater) {
    cr_assert_lt(my_strncmp("abc", "abd", 3), 0);
}

Test(my_strncmp, n_zero) {
    cr_assert_eq(my_strncmp("abc", "xyz", 0), 0);
}

Test(my_strncmp, shorter_than_n) {
    cr_assert_eq(my_strncmp("ab", "ab", 5), 0);
}

Test(my_strncmp, s1_empty) {
    cr_assert_lt(my_strncmp("", "abc", 2), 0);
}

Test(my_strncmp, s2_empty) {
    cr_assert_gt(my_strncmp("abc", "", 2), 0);
}

Test(my_strncmp, both_empty) {
    cr_assert_eq(my_strncmp("", "", 2), 0);
}

Test(my_strncmp, difference_after_n) {
    cr_assert_eq(my_strncmp("abcdef", "abcxyz", 3), 0);
}

Test(my_strncmp, difference_at_n_minus_1) {
    cr_assert_lt(my_strncmp("abcde", "abzde", 3), 0);
}
