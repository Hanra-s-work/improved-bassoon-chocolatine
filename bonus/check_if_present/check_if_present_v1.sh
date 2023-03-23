#!/bin/bash
# (c) Written by Henry Letellier
##
## EPITECH PROJECT, 2022
## chocolatine (Workspace)
## File description:
## check_if_present_v1.sh
##

if [ $# -ge 1 ]; then
    EXECUTABLES=$@
else
    echo "::error file='<not found>',line=1,endLine=0,title='<file not found>'::There was no executable(s) specified for the check"
    exit 1
fi

echo "$EXECUTABLES"
