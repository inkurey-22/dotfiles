/*
** EPITECH PROJECT, 2025
** day06
** File description:
** getnbr base
*/

int get_digit_value(char c, char const *base)
{
    for (int i = 0; base[i] != '\0'; i++) {
        if (base[i] == c)
            return i;
    }
    return -1;
}

int my_getnbr_base(char const *str, char const *base)
{
    int result = 0;
    int base_length = 0;
    int digit_value = 0;
    int i = 0;

    while (base[base_length] != '\0')
        base_length++;
    while (str[i] != '\0') {
        digit_value = get_digit_value(str[i], base);
        if (digit_value == -1)
            return 0;
        result = result * base_length + digit_value;
        i++;
    }
    return result;
}
