#!/bin/bash
# set -euo pipefail

# arr_url=()
# echo "Count of requests:"
read cnt_req
arr_metrics=("%{time_namelookup}" 
			"%{time_connect}" 
			"%{time_appconnect}" 
			"%{time_pretransfer}" 
			"%{time_starttransfer}")

# # Заполняем массив URL'ами, на которые будем делать запросы
# echo "Insert the URLs:"
# while true; do
# 	read url
# 	if [ "$url" != "" ]
# 	then
# 		arr_url+=( "$url" )
# 	else 
# 		break
# 	fi
# done
# echo ${arr_url[@]}

arr_url=("https://68.img.avito.st/image/1/rS2IB7axAcS-sIPJ3gH0BXGkAcA0pgvG" "https://00.img.avito.st/image/1/1cs1qbaxeSIDHvsvE_qxrtcKeSaJCHMg")
#url1="https://68.img.avito.st/image/1/rS2IB7axAcS-sIPJ3gH0BXGkAcA0pgvG"
#url2="https://00.img.avito.st/image/1/1cs1qbaxeSIDHvsvE_qxrtcKeSaJCHMg"

# y=$(curl -o /dev/null -w "%{time_namelookup}" $url1)
# echo "=============="
# echo "Metric: time_namelookup"
# echo $y

metrics(){
curl -o /dev/null -w $1 $2
}

# time_namelookup=$(metrics "%{time_namelookup}" $url1) 
# echo $time_namelookup

for cnt in cnt_req; do
	for url in ${arr_url[@]}; do
	echo $url
	done
done