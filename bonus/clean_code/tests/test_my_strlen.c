/*
** EPITECH PROJECT, 2022
** chocolatine (Workspace)
** File description:
** test_my_strlen.c
*/

#include <criterion/criterion.h>
#include "my.h"

Test(my_strlen, empty_string)
{
    const char *str = "";
    int len = my_strlen(str);
    cr_assert_eq(len, 0, "Expected length of empty string to be 0, but got %d", len);
}

Test(my_strlen, one_character)
{
    const char *str = "a";
    int len = my_strlen(str);
    cr_assert_eq(len, 1, "Expected length of 'a' to be 1, but got %d", len);
}

Test(my_strlen, multiple_characters)
{
    const char *str = "Hello, world!";
    int len = my_strlen(str);
    cr_assert_eq(len, 13, "Expected length of 'Hello, world!' to be 13, but got %d", len);
}

Test(my_strlen, null_string)
{
    const char *str = NULL;
    int len = my_strlen(str);
    cr_assert_eq(len, 0, "Expected length of null string to be 0, but got %d", len);
}
