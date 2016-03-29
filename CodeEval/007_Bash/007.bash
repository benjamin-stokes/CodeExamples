#!/bin/bash
GLOBIGNORE="*"
numtest="1234567890"
while read line || [[ -n "$line" ]]; do
    tot=`echo "$line" | wc -w`
    x=( $line )
    let i=tot-1
    let j=0
    stack[j]=${x[i]}
    while [[ $i -gt 0 ]]; do
        let i=i-1
        if echo $numtest | grep ${x[i]} > /dev/null; then
            let j=j+1
            stack[j]=${x[i]}
        else
            stack[j-1]=`bc -l <<< ${stack[j]}${x[i]}${stack[j-1]}`
            let j=j-1
        fi
    done
    echo `bc <<< "scale=0;${stack[j]}/0.99999"`
done < $1
