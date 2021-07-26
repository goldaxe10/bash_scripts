#!/bin/bash
while true; do
	iter=0
	read data
	arr_data=($(echo $data))
	if [[ "$data" == "" ]]
	then
		echo "bye"
		break
	elif [[ "${arr_data[0]}" -eq "${arr_data[1]}" ]]
	then
		echo "${arr_data[0]}"
	else
		if [[ "${arr_data[0]}" -gt "${arr_data[1]}" ]]
		then
			iter=${arr_data[0]}
			echo "$iter"	
		else
			iter=${arr_data[1]}
			echo "$iter"
		fi
	fi
done 
