/*
** EPITECH PROJECT, 2025
** day06
** File description:
** my_showstr
*/

#include <unistd.h>

void my_putchar(char c);

static void print_hex(unsigned char c)
{
    char *hex = "0123456789abcdef";
    my_putchar('\\');
    my_putchar(hex[c / 16]);
    my_putchar(hex[c % 16]);
}

int my_showstr(char const *str)
{
    if (!str)
        return 0;
    for (int i = 0; str[i] != '\0'; i++) {
        if (str[i] >= 32 && str[i] <= 126) {
            my_putchar(str[i]);
        } else {
            print_hex((unsigned char)str[i]);
        }
    }
    return 0;
}
