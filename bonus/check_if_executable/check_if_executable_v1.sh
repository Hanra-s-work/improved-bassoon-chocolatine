#!/bin/bash
# (c) Written by Henry Letellier
##
## EPITECH PROJECT, 2022
## chocolatine (Workspace)
## File description:
## check_if_executable_v1.sh
##

if [ $# -ge 1 ]; then
    EXECUTABLES=$@
else
    echo "::error file='<not found>',line=1,endLine=0,title='<file not found>'::There was no executable(s) specified for the check"
    exit 1
fi

for EXE in $EXECUTABLES; do
    if [ ! -x "$EXE" ]; then
        echo "::error file=$EXE,line=1,endLine=0,title='NOT EXECUTABLE' ::The file '$EXE' cannot be run."
        exit 1
    fi
done
