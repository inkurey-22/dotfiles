/*
** EPITECH PROJECT, 2025
** do_op
** File description:
** do_op
*/

#ifndef DO_OP_H_
    #define DO_OP_H_

typedef struct op_s {
    char op;
    int (*func)(int, int);
} op_t;

#endif /* !DO_OP_H_ */
