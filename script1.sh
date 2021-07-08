#!/bin/bash
set -euo pipefail

arr_url=()
echo "Count of requests: "
read cnt_req
while true; do
	read url
	if [ "$url" != "" ]
	then
		arr_url+=( "$url" )
	else 
		break
	fi
done
echo ${arr_url[@]}






# arr=(Hello World !) 
# for item in ${arr[@]}; do
	# echo $item
# done


# set -euo pipefail
# cnt_of_requests=100 #$1


# url_1="https://00.img.avito.st/image/1/1cs1qbaxeSIDHvsvE_qxrtcKeSaJCHMg" #$2
# url_2="https://68.img.avito.st/image/1/rS2IB7axAcS-sIPJ3gH0BXGkAcA0pgvG" #$3
# i=0


# while [ "$i" -le 7000 ]; do
	
	# i=$(( i+1 ))
# done


