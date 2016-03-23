#!/bin/bash

while read line || [[ -n "$line" ]]; do
    x=( $line )
    let i=1
    if [[ $[i%x[0]] -eq 0 ]]; then
        if [[ $[i%x[1]] -eq 0 ]]; then
            echo -n "FB"
        else
            echo -n "F"
        fi
    elif [[ $[i%x[1]] -eq 0 ]]; then
        echo -n "B"
    else
        echo -n "$i"
    fi
    while [[ $i -lt ${x[2]} ]]; do
        let i=i+1
        if [[ $[i%x[0]] -eq 0 ]]; then
            if [[ $[i%x[1]] -eq 0 ]]; then
                echo -n " FB"
            else
                echo -n " F"
            fi
        elif [[ $[i%x[1]] -eq 0 ]]; then
            echo -n " B"
        else
            echo -n " $i"
        fi
    done
    echo ""
done < $1
