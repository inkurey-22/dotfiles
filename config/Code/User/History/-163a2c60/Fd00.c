/*
** EPITECH PROJECT, 2025
** day08
** File description:
** convert base
*/

#include <stdlib.h>

int get_base_len(char const *base)
{
    int len = 0;
    while (base[len])
        len++;
    return len;
}

int str_to_int_base(char const *nbr, char const *base, int base_len)
{
    int num = 0;
    for (int i = 0; nbr[i]; i++)
        num = num * base_len + (nbr[i] - '0');
    return num;
}

int count_digits(int num, int base_len)
{
    int digits = 1;
    while (num >= base_len) {
        num /= base_len;
        digits++;
    }
    return digits;
}

void reverse_str(char *str, int len)
{
    char temp = 0;

    for (int i = 0; i < len / 2; i++) {
        temp = str[i];
        str[i] = str[len - i - 1];
        str[len - i - 1] = temp;
    }
}

char *int_to_base_str(int num, char const *base, int base_len)
{
    int digits = count_digits(num, base_len);
    char *result = malloc(digits + 1);
    int index = 0;

    if (!result)
        return NULL;
    do {
        result[index++] = base[num % base_len];
        num /= base_len;
    } while (num > 0);
    result[index] = '\0';
    reverse_str(result, index);
    return result;
}

char *convert_base(char const *nbr, char const *base_from, char const *base_to)
{
    int base_from_len = get_base_len(base_from);
    int base_to_len = get_base_len(base_to);
    int num = str_to_int_base(nbr, base_from, base_from_len);

    return int_to_base_str(num, base_to, base_to_len);
}
