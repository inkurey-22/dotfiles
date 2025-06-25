/*
** EPITECH PROJECT, 2025
** day06
** File description:
** test_my_strcapitalize
*/

#include <criterion/criterion.h>
char *my_strcapitalize(char *str);

Test(my_strcapitalize, basic)
{
    char sentence[] = "hey, how are you? 42WORds forty-two; fifty+one";
    my_strcapitalize(sentence);
    cr_assert_str_eq(sentence,
                     "Hey, How Are You? 42words Forty-Two; Fifty+One");
}

Test(my_strcapitalize, null_string)
{
    char sentence[] = {0};
    my_strcapitalize(sentence);
    cr_assert_str_eq(sentence, "");
}

Test(my_strcapitalize, null)
{
    char *sentence = NULL;
    cr_assert_null(my_strcapitalize(sentence));
}

Test(my_strcapitalize, already_capitalized)
{
    char sentence[] = "Hello World";
    my_strcapitalize(sentence);
    cr_assert_str_eq(sentence, "Hello World");
}

Test(my_strcapitalize, all_uppercase)
{
    char sentence[] = "ALL UPPERCASE SENTENCE";
    my_strcapitalize(sentence);
    cr_assert_str_eq(sentence, "All Uppercase Sentence");
}

Test(my_strcapitalize, all_lowercase)
{
    char sentence[] = "all lowercase sentence";
    my_strcapitalize(sentence);
    cr_assert_str_eq(sentence, "All Lowercase Sentence");
}

Test(my_strcapitalize, numbers_and_letters)
{
    char sentence[] = "123abc 456DEF";
    my_strcapitalize(sentence);
    cr_assert_str_eq(sentence, "123abc 456def");
}

Test(my_strcapitalize, only_symbols)
{
    char sentence[] = "!@#$%^&*()";
    my_strcapitalize(sentence);
    cr_assert_str_eq(sentence, "!@#$%^&*()");
}

Test(my_strcapitalize, empty_string)
{
    char sentence[] = "";
    my_strcapitalize(sentence);
    cr_assert_str_eq(sentence, "");
}

Test(my_strcapitalize, single_letter)
{
    char sentence[] = "a";
    my_strcapitalize(sentence);
    cr_assert_str_eq(sentence, "A");
}

Test(my_strcapitalize, single_non_alnum)
{
    char sentence[] = "-";
    my_strcapitalize(sentence);
    cr_assert_str_eq(sentence, "-");
}

Test(my_strcapitalize, mixed_separators)
{
    char sentence[] = "hello-world+foo_bar";
    my_strcapitalize(sentence);
    cr_assert_str_eq(sentence, "Hello-World+Foo_Bar");
}
