/*
** EPITECH PROJECT, 2022
** chocolatine (Workspace)
** File description:
** my_putstr.c
*/

#include <stddef.h>
#include <unistd.h>
#include "my.h"

void my_putstr(char const *str)
{
    if (str != NULL)
        write(1, str, my_strlen(str));
}
