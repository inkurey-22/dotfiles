// File: test_my_getnbr_base.c

#include <criterion/criterion.h>

int my_getnbr_base(char const *str, char const *base);
int get_digit_value(char c, char const *base);

Test(my_getnbr_base, decimal_base)
{
    cr_assert_eq(my_getnbr_base("1234", "0123456789"), 1234);
}

Test(my_getnbr_base, binary_base)
{
    cr_assert_eq(my_getnbr_base("1011", "01"), 11);
}

Test(my_getnbr_base, octal_base)
{
    cr_assert_eq(my_getnbr_base("17", "01234567"), 15);
}

Test(my_getnbr_base, hex_base)
{
    cr_assert_eq(my_getnbr_base("1A", "0123456789ABCDEF"), 26);
}

Test(my_getnbr_base, invalid_char_in_str)
{
    cr_assert_eq(my_getnbr_base("12Z4", "0123456789"), 0);
}

Test(my_getnbr_base, empty_string)
{
    cr_assert_eq(my_getnbr_base("", "0123456789"), 0);
}

Test(my_getnbr_base, empty_base)
{
    cr_assert_eq(my_getnbr_base("123", ""), 0);
}

Test(my_getnbr_base, single_char_base)
{
    cr_assert_eq(my_getnbr_base("aaa", "a"), 0); // base length is 1, so always 0
}

Test(get_digit_value, char_in_base)
{
    cr_assert_eq(get_digit_value('A', "ABCDEF"), 0);
    cr_assert_eq(get_digit_value('F', "ABCDEF"), 5);
}

Test(get_digit_value, char_not_in_base)
{
    cr_assert_eq(get_digit_value('Z', "ABCDEF"), -1);
}

Test(get_digit_value, empty_base)
{
    cr_assert_eq(get_digit_value('A', ""), -1);
}