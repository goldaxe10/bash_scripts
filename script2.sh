#!/bin/bash
set -euo pipefail

metrics_func(){
curl -o /dev/null -w "%{time_namelookup} %{time_connect} %{time_appconnect} %{time_pretransfer} %{time_starttransfer}" $1
sleep 1
}

# arr_url=()
echo "Count of requests:"
cnt_req=5
# read cnt_req

arr_url=("https://68.img.avito.st/image/1/rS2IB7axAcS-sIPJ3gH0BXGkAcA0pgvG" "https://00.img.avito.st/image/1/1cs1qbaxeSIDHvsvE_qxrtcKeSaJCHMg")



for ((cnt=1; cnt<=$cnt_req; cnt++)); do
	for url in ${arr_url[@]}; do
		arr_results=($(metrics_func $url))

		if [[ "$url" == "${arr_url[0]}" ]]
			then
                                arr_url1_results+=( "$arr_results" )
                        else
                                echo "1"
                fi
	done
# echo "== Request done: $cnt =="		
done
echo ${arr_url1_results[@]}
