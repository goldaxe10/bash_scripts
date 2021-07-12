#!/bin/bash
set -euo pipefail

metrics_func(){
curl -o /dev/null -w "%{time_namelookup} %{time_connect} %{time_appconnect} %{time_pretransfer} %{time_starttransfer}" $1
sleep 1
}

# arr_url=()
echo "Count of requests:"
# cnt_req=5
read cnt_req

arr_url=("https://68.img.avito.st/image/1/rS2IB7axAcS-sIPJ3gH0BXGkAcA0pgvG" "https://00.img.avito.st/image/1/1cs1qbaxeSIDHvsvE_qxrtcKeSaJCHMg")

url1_namelookup=0.0
url1_connect=0.0
url1_appconnect=0.0
url1_pretransfer=0.0
url1_starttransfer=0.0

url1_MIN_namelookup=0.0
url1_MIN_connect=0.0
url1_MIN_appconnect=0.0
url1_MIN_pretransfer=0.0
url1_MIN_starttransfer=0.0

url1_MAX_namelookup=0.0
url1_MAX_connect=0.0
url1_MAX_appconnect=0.0
url1_MAX_pretransfer=0.0
url1_MAX_starttransfer=0.0

url1_AVG_namelookup=0.0
url1_AVG_connect=0.0
url1_AVG_appconnect=0.0
url1_AVG_pretransfer=0.0
url1_AVG_starttransfer=0.0

url2_namelookup=0.0
url2_connect=0.0
url2_appconnect=0.0
url2_pretransfer=0.0
url2_starttransfer=0.0

url2_MIN_namelookup=0.0
url2_MIN_connect=0.0
url2_MIN_appconnect=0.0
url2_MIN_pretransfer=0.0
url2_MIN_starttransfer=0.0

url2_MAX_namelookup=0.0
url2_MAX_connect=0.0
url2_MAX_appconnect=0.0
url2_MAX_pretransfer=0.0
url2_MAX_starttransfer=0.0

url2_AVG_namelookup=0.0
url2_AVG_connect=0.0
url2_AVG_appconnect=0.0
url2_AVG_pretransfer=0.0
url2_AVG_starttransfer=0.0

for ((cnt=1; cnt<=$cnt_req; cnt++)); do
	for url in ${arr_url[@]}; do
		arr_results=($(metrics_func $url))

		namelookup=${arr_results[0]//,/.}
		connect=$(echo "${arr_results[1]//,/.} - ${arr_results[0]//,/.}" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')
		appconnect=$(echo "${arr_results[2]//,/.} - ${arr_results[1]//,/.}" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')
		pretransfer=$(echo "${arr_results[3]//,/.} - ${arr_results[2]//,/.}" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')
		starttransfer=$(echo "${arr_results[4]//,/.} - ${arr_results[3]//,/.}" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')

		echo "= $namelookup $connect $appconnect $pretransfer $starttransfer"

		if [[ "$url" == "${arr_url[0]}" ]]
			then
				url1_namelookup=$namelookup
				url1_connect=$connect
				url1_appconnect=$appconnect
				url1_pretransfer=$pretransfer
				url1_starttransfer=$starttransfer

				# url1_namelookup
				if [[ "$url1_MIN_namelookup" == "0.0" ]]
					then url1_MIN_namelookup=$url1_namelookup
				fi
				if [[ "$url1_namelookup" < "$url1_MIN_namelookup" ]]
					then url1_MIN_namelookup=$url1_namelookup
				fi
				if [[ "$url1_namelookup" > "$url1_MAX_namelookup" ]]
					then url1_MAX_namelookup=$url1_namelookup
				fi

				# url1_connect
				if [[ "$url1_MIN_connect" == "0.0" ]]
					then url1_MIN_connect=$url1_connect
				fi
				if [[ "$url1_connect" < "$url1_MIN_connect" ]]
					then url1_MIN_connect=$url1_connect
				fi
				if [[ "$url1_connect" > "$url1_MAX_connect" ]]
					then url1_MAX_connect=$url1_connect
				fi

				# url1_appconnect
				if [[ "$url1_MIN_appconnect" == "0.0" ]]
					then url1_MIN_appconnect=$url1_appconnect
				fi
				if [[ "$url1_appconnect" < "$url1_MIN_appconnect" ]]
					then url1_MIN_appconnect=$url1_appconnect
				fi
				if [[ "$url1_appconnect" > "$url1_MAX_appconnect" ]]
					then url1_MAX_appconnect=$url1_appconnect
				fi

				# url1_pretransfer
				if [[ "$url1_MIN_pretransfer" == "0.0" ]]
					then url1_MIN_pretransfer=$url1_pretransfer
				fi
				if [[ "$url1_pretransfer" < "$url1_MIN_pretransfer" ]]
					then url1_MIN_pretransfer=$url1_pretransfer
				fi
				if [[ "$url1_pretransfer" > "$url1_MAX_pretransfer" ]]
					then url1_MAX_pretransfer=$url1_pretransfer
				fi

				# url1_starttransfer
				if [[ "$url1_MIN_starttransfer" == "0.0" ]]
					then url1_MIN_starttransfer=$url1_starttransfer
				fi
				if [[ "$url1_starttransfer" < "$url1_MIN_starttransfer" ]]
					then url1_MIN_nstarttransfer=$url1_starttransfer
				fi
				if [[ "$url1_starttransfer" > "$url1_MAX_starttransfer" ]]
					then url1_MAX_starttransfer=$url1_starttransfer
				fi

				url1_AVG_namelookup=$(echo "$url1_AVG_namelookup + $url1_namelookup" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')
				url1_AVG_connect=$(echo "$url1_AVG_connect + $url1_connect" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')
				url1_AVG_appconnect=$(echo "$url1_AVG_appconnect + $url1_appconnect" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')
				url1_AVG_pretransfer=$(echo "$url1_AVG_pretransfer + $url1_pretransfer" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')
				url1_AVG_starttransfer=$(echo "$url1_AVG_starttransfer + $url1_starttransfer" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')

			else
				url2_namelookup=$namelookup
				url2_connect=$connect
				url2_appconnect=$appconnect
				url2_pretransfer=$pretransfer
				url2_starttransfer=$starttransfer

				# url2_namelookup
				if [[ "$url2_MIN_namelookup" == "0.0" ]]
					then url2_MIN_namelookup=$url2_namelookup
				fi
				if [[ "$url2_namelookup" < "$url2_MIN_namelookup" ]]
					then url2_MIN_namelookup=$url2_namelookup
				fi
				if [[ "$url2_namelookup" > "$url2_MAX_namelookup" ]]
					then url2_MAX_namelookup=$url2_namelookup
				fi

				# url2_connect
				if [[ "$url2_MIN_connect" == "0.0" ]]
					then url2_MIN_connect=$url2_connect
				fi
				if [[ "$url2_connect" < "$url2_MIN_connect" ]]
					then url2_MIN_connect=$url2_connect
				fi
				if [[ "$url2_connect" > "$url2_MAX_connect" ]]
					then url2_MAX_connect=$url2_connect
				fi

				# url2_appconnect
				if [[ "$url2_MIN_appconnect" == "0.0" ]]
					then url2_MIN_appconnect=$url2_appconnect
				fi
				if [[ "$url2_appconnect" < "$url2_MIN_appconnect" ]]
					then url2_MIN_appconnect=$url2_appconnect
				fi
				if [[ "$url2_appconnect" > "$url2_MAX_appconnect" ]]
					then url2_MAX_appconnect=$url2_appconnect
				fi

				# url2_pretransfer
				if [[ "$url2_MIN_pretransfer" == "0.0" ]]
					then url2_MIN_pretransfer=$url2_pretransfer
				fi
				if [[ "$url2_pretransfer" < "$url2_MIN_pretransfer" ]]
					then url2_MIN_pretransfer=$url2_pretransfer
				fi
				if [[ "$url2_pretransfer" > "$url2_MAX_pretransfer" ]]
					then url2_MAX_pretransfer=$url2_pretransfer
				fi

				# url2_starttransfer
				if [[ "$url2_MIN_starttransfer" == "0.0" ]]
					then url2_MIN_starttransfer=$url2_starttransfer
				fi
				if [[ "$url2_starttransfer" < "$url2_MIN_starttransfer" ]]
					then url2_MIN_nstarttransfer=$url2_starttransfer
				fi
				if [[ "$url2_starttransfer" > "$url2_MAX_starttransfer" ]]
					then url2_MAX_starttransfer=$url2_starttransfer
				fi

				url2_AVG_namelookup=$(echo "$url2_AVG_namelookup + $url2_namelookup" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')
				url2_AVG_connect=$(echo "$url2_AVG_connect + $url2_connect" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')
				url2_AVG_appconnect=$(echo "$url2_AVG_appconnect + $url2_appconnect" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')
				url2_AVG_pretransfer=$(echo "$url2_AVG_pretransfer + $url2_pretransfer" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')
				url2_AVG_starttransfer=$(echo "$url2_AVG_starttransfer + $url2_starttransfer" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')
		fi
	done
echo "== Request done: $cnt =="		
done

url1_AVG_namelookup=$(bc<<<"scale=6;$url1_AVG_namelookup/$cnt_req" | sed -e 's/^\./0./' -e 's/^-\./-0./')
url1_AVG_connect=$(bc<<<"scale=6;$url1_AVG_connect/$cnt_req" | sed -e 's/^\./0./' -e 's/^-\./-0./')
url1_AVG_appconnect=$(bc<<<"scale=6;$url1_AVG_appconnect/$cnt_req" | sed -e 's/^\./0./' -e 's/^-\./-0./')
url1_AVG_pretransfer=$(bc<<<"scale=6;$url1_AVG_pretransfer/$cnt_req" | sed -e 's/^\./0./' -e 's/^-\./-0./')
url1_AVG_starttransfer=$(bc<<<"scale=6;$url1_AVG_starttransfer/$cnt_req" | sed -e 's/^\./0./' -e 's/^-\./-0./')

url2_AVG_namelookup=$(bc<<<"scale=6;$url2_AVG_namelookup/$cnt_req" | sed -e 's/^\./0./' -e 's/^-\./-0./')
url2_AVG_connect=$(bc<<<"scale=6;$url2_AVG_connect/$cnt_req" | sed -e 's/^\./0./' -e 's/^-\./-0./')
url2_AVG_appconnect=$(bc<<<"scale=6;$url2_AVG_appconnect/$cnt_req" | sed -e 's/^\./0./' -e 's/^-\./-0./')
url2_AVG_pretransfer=$(bc<<<"scale=6;$url2_AVG_pretransfer/$cnt_req" | sed -e 's/^\./0./' -e 's/^-\./-0./')
url2_AVG_starttransfer=$(bc<<<"scale=6;$url2_AVG_starttransfer/$cnt_req" | sed -e 's/^\./0./' -e 's/^-\./-0./')

# echo $url1_MIN_namelookup $url1_MIN_connect $url1_MIN_appconnect $url1_MIN_pretransfer $url1_MIN_starttransfer 
# echo $url1_MAX_namelookup $url1_MAX_connect $url1_MAX_appconnect $url1_MAX_pretransfer $url1_MAX_starttransfer

# echo $url2_MIN_namelookup $url2_MIN_connect $url2_MIN_appconnect $url2_MIN_pretransfer $url2_MIN_starttransfer 
# echo $url2_MAX_namelookup $url2_MAX_connect $url2_MAX_appconnect $url2_MAX_pretransfer $url2_MAX_starttransfer


