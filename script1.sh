#!/bin/bash
# set -euo pipefail

# arr_url=()
# echo "Count of requests:"

time_namelookup=0.0
time_connect=0.0
time_appconnect=0.0
time_pretransfer=0.0
time_starttransfer=0.0

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
url1="https://68.img.avito.st/image/1/rS2IB7axAcS-sIPJ3gH0BXGkAcA0pgvG"
#url2="https://00.img.avito.st/image/1/1cs1qbaxeSIDHvsvE_qxrtcKeSaJCHMg"

# y=$(curl -o /dev/null -w "%{time_namelookup}" $url1)
# echo "=============="
# echo "Metric: time_namelookup"
# echo $y

# metrics_func(){
# curl -o /dev/null -w $1 $2
# sleep 2
# }

metrics_func(){
curl -o /dev/null -w "${arr_metrics[0]} ${arr_metrics[1]} ${arr_metrics[2]} ${arr_metrics[3]} ${arr_metrics[4]}" $url1
sleep 2
}

q=$(metrics_func)
echo $q
for metric in $q; do
	echo $metric
done

# time_namelookup=$(metrics "%{time_namelookup}" $url1) 
# echo $time_namelookup

# for ((cnt=1; cnt<=$cnt_req; cnt++)); do
# 	for url in ${arr_url[@]}; do
# 		echo
# 	done		
# done