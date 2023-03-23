/*
** EPITECH PROJECT, 2022
** chocolatine (Workspace)
** File description:
** test_will_fail.c
*/

#include <criterion/criterion.h>
#include "my.h"

Test(my_strlen, test_that_will_fail)
{
    int length = my_strlen("ee");
    cr_assert_eq(length, 2, "Expected %d but got %d.", 2);
    cr_assert_eq(1, 2, "Expected %d but got %d.", 2);
}
