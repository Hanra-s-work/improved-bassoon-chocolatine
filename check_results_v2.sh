#!/bin/bash
# (c) Written by Henry Letellier
CONTENT="$(cat coding-style-reports.log)"
ILLEGAL_FILES_FOUND=0
while IFS= read -r LINE; do
    echo "::error file=$LINE,line=1,endLine=0,title=Unwanted file detected::$LINE"
    ILLEGAL_FILES_FOUND=1
done <<<"$CONTENT"
if [ $ILLEGAL_FILES_FOUND -eq 1 ]; then
    exit 1
else
    echo "::success file='',line=1,endLine=0,title=No Unwanted file detected"
fi
