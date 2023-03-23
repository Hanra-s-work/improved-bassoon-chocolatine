/*
** EPITECH PROJECT, 2022
** chocolatine (Workspace)
** File description:
** my_strlen.c
*/

#include <stddef.h>

int my_strlen(char const *str)
{
    int i = 0;
    for (; str != NULL && str[i] != '\0'; i++);
    return i;
}
