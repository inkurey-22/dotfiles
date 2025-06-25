/*
** EPITECH PROJECT, 2025
** day06
** File description:
** my_showmem
*/

#include <unistd.h>

void my_putchar(char c)
{
    write(1, &c, 1);
}

static void print_hex_digit(unsigned char n)
{
    if (n < 10)
        my_putchar('0' + n);
    else
        my_putchar('a' + n - 10);
}

static void print_hex_byte(unsigned char b)
{
    print_hex_digit(b >> 4);
    print_hex_digit(b & 0xF);
}

static void print_address(int addr)
{
    for (int i = 7; i >= 0; i--)
        print_hex_digit((addr >> (i * 4)) & 0xF);
}

static void print_ascii(const char *str, int start, int size)
{
    for (int i = 0; i < 16 && (start + i) < size; i++) {
        char c = str[start + i];
        if (c >= 32 && c <= 126)
            my_putchar(c);
        else
            my_putchar('.');
    }
}

int my_showmem(char const *str, int size)
{
    for (int i = 0; i < size; i += 16) {
        print_address(i);
        my_putchar(':');
        my_putchar(' ');
        for (int j = 0; j < 16; j++) {
            if (i + j < size) {
                print_hex_byte((unsigned char)str[i + j]);
            } else {
                my_putchar(' ');
                my_putchar(' ');
            }
            if (j % 2 == 1)
                my_putchar(' ');
        }
        print_ascii(str, i, size);
        my_putchar('\n');
    }
    return 0;
}

int main(void)
{
    const char *test_str = "Hello, World!\nThis is a test string with some non-printable characters: \x01\x02\x03\x04";
    my_showmem(test_str, 100);
    return 0;
}
