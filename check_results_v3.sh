#!/bin/bash
# (c) Written by Henry Letellier
CONTENT="$(cat coding-style-reports.log)"
ILLEGAL_FILES_FOUND=0
while IFS= read -r LINE; do
    FILE=$(echo $LINE | cut -d ':' -f 1)
    LINE_NUMBER=$(echo $LINE | cut -d ':' -f 2)
    LEVEL=$(echo $LINE | cut -d ':' -f 3 | cut -d ' ' -f 1)
    ERROR_CODE=$(echo $LINE | cut -d ':' -f 4)
    echo "::error file=$FILE,line=$LINE_NUMBER,endLine=0,title=$LEVEL coding style error::$ERROR_CODE"
    ILLEGAL_FILES_FOUND=1
done <<<"$CONTENT"
if [ $ILLEGAL_FILES_FOUND -eq 1 ]; then
    exit 1
else
    echo "::success file='',line=1,endLine=0,title=No Unwanted file detected"
fi
