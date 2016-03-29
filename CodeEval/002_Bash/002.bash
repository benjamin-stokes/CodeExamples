#!/bin/bash

num=`head -1 $1`
while read line || [[ -n "$line" ]]; do
    echo `echo $line | wc -c` $line 
done < $1 | sort -rn | head -$num | cut -d' ' -f2-
