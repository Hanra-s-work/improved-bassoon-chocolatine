#!/bin/bash
CONTENT="$(cat coding-style-reports.log)"
ILLEGAL_FILES_FOUND=0
for FILE in $CONTENT; do
    echo "::error file=$FILE,line=1,endLine=0,title=Unwanted file detected::$FILE"
    ILLEGAL_FILES_FOUND=1
done
if [ $ILLEGAL_FILES_FOUND -eq 1 ]; then
    exit 1
else
    echo "::success file='',line=1,endLine=0,title=No Unwanted file detected"
fi
