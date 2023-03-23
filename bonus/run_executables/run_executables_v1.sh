#!/bin/bash
# (c) Written by Henry Letellier
##
## EPITECH PROJECT, 2022
## chocolatine (Workspace)
## File description:
## run_executables_v1.sh
##

if [ $# -ge 1 ]; then
    EXECUTABLES=$@
else
    echo "::error file='<not found>',line=1,endLine=0,title='<file not found>'::There was no executable(s) specified for the check"
    exit 1
fi

./${EXECUTABLE[@]} >/dev/null

if [ $? -eq 0 ]; then
    exit 0
fi

for EXE in $EXECUTABLES; do
    ./$EXE >/dev/null
    if [ $? -ne 0 ]; then
        echo "::error file=$EXE,line=1,endLine=0,title='EXECUTION FAILED'::The file $EXE could not be run."
        exit 1
    fi
done
