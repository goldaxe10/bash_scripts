#!/bin/bash
while true; do
    iter=0
    # arr_data=()
    read data
    if [[ "$data" == "" ]]
        then
            echo "bye"
            break
        else
            for i in $data; do
                if [[ "$i" -gt "$iter" ]]
                    then
                        iter=$i
                fi
                arr_data+=$( $i )
            done
            for (( j=1; j<=$iter; j++ )); do
                echo $j
            done
    fi
done 
