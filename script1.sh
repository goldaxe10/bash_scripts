#!/bin/bash
# set -euo pipefail

# arr_url=()
echo "Count of requests:"
# read cnt_req
cnt_req=2

url1_namelookup=0.0
url1_connect=0.0
url1_appconnect=0.0
url1_pretransfer=0.0
url1_starttransfer=0.0

url2_namelookup=0.0
url2_connect=0.0
url2_appconnect=0.0
url2_pretransfer=0.0
url2_starttransfer=0.0

url1_MIN=0.0
url1_MAX=0.0
url1_AVG=0.0

url2_MIN=0.0
url2_MAX=0.0
url2_AVG=0.0

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

metrics_func(){
curl -o /dev/null -w "%{time_namelookup} %{time_connect} %{time_appconnect} %{time_pretransfer} %{time_starttransfer}" $1
sleep 1
}

for ((cnt=1; cnt<=$cnt_req; cnt++)); do
	for url in ${arr_url[@]}; do
		arr_results=($(metrics_func $url))

		echo ${arr_results[@]}

		namelookup=${arr_results[0]//,/.}
		connect=$(echo "${arr_results[1]//,/.} - ${arr_results[0]//,/.}" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')
		appconnect=$(echo "${arr_results[2]//,/.} - ${arr_results[1]//,/.}" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')
		pretransfer=$(echo "${arr_results[3]//,/.} - ${arr_results[2]//,/.}" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')
		starttransfer=$(echo "${arr_results[4]//,/.} - ${arr_results[3]//,/.}" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')

		echo $namelookup $connect $appconnect $pretransfer $starttransfer
	done		
done

