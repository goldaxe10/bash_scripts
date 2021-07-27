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
		echo "GSD is ${arr_data[0]}"
	else
		if [[ "${arr_data[0]}" -gt "${arr_data[1]}" ]]
		then
			iter=${arr_data[0]}
		else
			iter=${arr_data[1]}
		fi
	for (( i=$iter; i>=1; i-- )); do
		if (( ${arr_data[0]} % $i  == 0 &&  ${arr_data[1]} % $i  == 0 ))
		then
			echo "GCD is $i"
			break
		fi	
	done
	fi
done 
