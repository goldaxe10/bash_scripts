#!/bin/bash
set -euo pipefail

start=`date +%s`
echo "Count of requests:"
read cnt_req
# cnt_req=10
sleep_time=0.5


arr_url=("https://68.img.avito.st/image/1/rS2IB7axAcS-sIPJ3gH0BXGkAcA0pgvG" "https://00.img.avito.st/image/1/1cs1qbaxeSIDHvsvE_qxrtcKeSaJCHMg")

# Курл запрос
func_metrics(){
	curl -o /dev/null -w "%{time_namelookup} %{time_connect} %{time_appconnect} %{time_pretransfer} %{time_starttransfer}" $1
	sleep $sleep_time
}

# Функция сортировки массивов методом пузырька
func_bubble_sort(){
    local -n argArray=$1
    arrayLen="${#argArray[@]}"
    flag=1
    for (( i=0; i < arrayLen-1 && flag==1 ; i++ ))
    do
        flag=0
        for (( j=0; j<arrayLen-i-1; j++ ))
        do
            if [[ ${argArray[$j]} > ${argArray[$j+1]} ]]; then
                temp=${argArray[$j]}
                argArray[$j]=${argArray[$j+1]}
                argArray[$j+1]=$temp
                flag=1
            fi
        done
    done
}

# Функция вычисления среднего значения
func_avg(){
    tmp_avg=0.0
    local -n tmp_arr=$1
    for (( cnt=0; cnt<${#tmp_arr[@]}; cnt++ )); do
        tmp_avg=$(echo "$tmp_avg + ${tmp_arr[$cnt]}" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')
    done
    tmp_avg=$(bc<<<"scale=6;$tmp_avg/$cnt_req" | sed -e 's/^\./0./' -e 's/^-\./-0./')
    echo $tmp_avg
}

# Функция вычисления перцентиля из отсортированного массива. Функция принимает два аргумента: 
# в $1 передаётся пецентиль, который нам необходимо вычислить. В $2 передаётся количество запросов.
# В итоге функция возвращает индекс массива с округлением в большую сторону, если мы получили вещественное значение.
func_percentile(){
	x1=$(bc<<<"scale=2;$1/100*$2" | sed -e 's/^\./0./' -e 's/^-\./-0./')
    x2=$(echo $x1 | awk '{print int($1+0.5)}')
    x3=$(bc<<<"scale=2;$x1-$x2" | sed -e 's/^\./0./' -e 's/^-\./-0./')
    x4=$(bc<<<"scale=2;1-$x3" | sed -e 's/^\./0./' -e 's/^-\./-0./')
    if [[ "$x4" == "1" ]]
        then
            ind_res=$x2
            echo $ind_res
        else
		x5=$(bc<<<"scale=2;$x1+$x4" | sed -e 's/^\./0./' -e 's/^-\./-0./')
            ind_res=$(echo $x5 | awk '{print int($1+0.5)}')
            echo $ind_res
        fi
}


# Перебираем массив с URLами
# Заполняем массивы данными с "чистыми" таймингами
for (( cnt=1; cnt<=$cnt_req; cnt++ )); do
	for url in ${arr_url[@]}; do
		arr_results=($(func_metrics $url))
		if [[ "$url" == "${arr_url[0]}" ]]	
			# url 1
			then
				# Вносим во временную переменную "чистые" тайминги + форматируем их
				tmp_var_namelookup=${arr_results[0]//,/.}		
				tmp_var_connect=$(echo "${arr_results[1]//,/.} - ${arr_results[0]//,/.}" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')
				tmp_var_appconnect=$(echo "${arr_results[2]//,/.} - ${arr_results[1]//,/.}" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')
				tmp_var_pretransfer=$(echo "${arr_results[3]//,/.} - ${arr_results[2]//,/.}" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')
				tmp_var_starttransfer=$(echo "${arr_results[4]//,/.} - ${arr_results[3]//,/.}" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')

				# Заполняем массивы с отформатированными значениями
                arr_url1_namelookup+=( "$tmp_var_namelookup" )
				arr_url1_connect+=( "$tmp_var_connect" )
				arr_url1_appconnect+=( "$tmp_var_appconnect" )
				arr_url1_pretransfer+=( "$tmp_var_pretransfer" )
				arr_url1_starttransfer+=( "$tmp_var_starttransfer" )
			
			# url 2
            else
				# Вносим во временную переменную "чистые" тайминги + форматируем их
				tmp_var_namelookup=${arr_results[0]//,/.}		
				tmp_var_connect=$(echo "${arr_results[1]//,/.} - ${arr_results[0]//,/.}" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')
				tmp_var_appconnect=$(echo "${arr_results[2]//,/.} - ${arr_results[1]//,/.}" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')
				tmp_var_pretransfer=$(echo "${arr_results[3]//,/.} - ${arr_results[2]//,/.}" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')
				tmp_var_starttransfer=$(echo "${arr_results[4]//,/.} - ${arr_results[3]//,/.}" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')

				# Заполняем массивы с отформатированными значениями
                arr_url2_namelookup+=( "$tmp_var_namelookup" )
				arr_url2_connect+=( "$tmp_var_connect" )
				arr_url2_appconnect+=( "$tmp_var_appconnect" )
				arr_url2_pretransfer+=( "$tmp_var_pretransfer" )
				arr_url2_starttransfer+=( "$tmp_var_starttransfer" )
            fi
	done
done


# Сортировка массивов с помощью функции func_bubble_sortfunc_bubble_sort
# url 1
func_bubble_sort arr_url1_namelookup
func_bubble_sort arr_url1_connect
func_bubble_sort arr_url1_appconnect
func_bubble_sort arr_url1_pretransfer
func_bubble_sort arr_url1_starttransfer
# url 2
func_bubble_sort arr_url2_namelookup
func_bubble_sort arr_url2_connect
func_bubble_sort arr_url2_appconnect
func_bubble_sort arr_url2_pretransfer
func_bubble_sort arr_url2_starttransfer


# Вычисление перцентиля
# 99
perc99=$(func_percentile 99 $cnt_req)
# url 1
p99_url1_namelookup=${arr_url1_namelookup[$perc99-1]}
p99_url1_connect=${arr_url1_connect[$perc99-1]}
p99_url1_appconnect=${arr_url1_appconnect[$perc99-1]}
p99_url1_pretransfer=${arr_url1_pretransfer[$perc99-1]}
p99_url1_starttransfer=${arr_url1_starttransfer[$perc99-1]}
# url 2
p99_url2_namelookup=${arr_url2_namelookup[$perc99-1]}
p99_url2_connect=${arr_url2_connect[$perc99-1]}
p99_url2_appconnect=${arr_url2_appconnect[$perc99-1]}
p99_url2_pretransfer=${arr_url2_pretransfer[$perc99-1]}
p99_url2_starttransfer=${arr_url2_starttransfer[$perc99-1]}

# 95
perc95=$(func_percentile 95 $cnt_req)
# url 1
p95_url1_namelookup=${arr_url1_namelookup[$perc95-1]}
p95_url1_connect=${arr_url1_connect[$perc95-1]}
p95_url1_appconnect=${arr_url1_appconnect[$perc95-1]}
p95_url1_pretransfer=${arr_url1_pretransfer[$perc95-1]}
p95_url1_starttransfer=${arr_url1_starttransfer[$perc95-1]}
# url 2
p95_url2_namelookup=${arr_url2_namelookup[$perc95-1]}
p95_url2_connect=${arr_url2_connect[$perc95-1]}
p95_url2_appconnect=${arr_url2_appconnect[$perc95-1]}
p95_url2_pretransfer=${arr_url2_pretransfer[$perc95-1]}
p95_url2_starttransfer=${arr_url2_starttransfer[$perc95-1]}

# 70
perc70=$(func_percentile 70 $cnt_req)
# url 1
p70_url1_namelookup=${arr_url1_namelookup[$perc70-1]}
p70_url1_connect=${arr_url1_connect[$perc70-1]}
p70_url1_appconnect=${arr_url1_appconnect[$perc70-1]}
p70_url1_pretransfer=${arr_url1_pretransfer[$perc70-1]}
p70_url1_starttransfer=${arr_url1_starttransfer[$perc70-1]}
# url 2
p70_url2_namelookup=${arr_url2_namelookup[$perc70-1]}
p70_url2_connect=${arr_url2_connect[$perc70-1]}
p70_url2_appconnect=${arr_url2_appconnect[$perc70-1]}
p70_url2_pretransfer=${arr_url2_pretransfer[$perc70-1]}
p70_url2_starttransfer=${arr_url2_starttransfer[$perc70-1]}

# 50
perc50=$(func_percentile 50 $cnt_req)
# url 1
p50_url1_namelookup=${arr_url1_namelookup[$perc50-1]}
p50_url1_connect=${arr_url1_connect[$perc50-1]}
p50_url1_appconnect=${arr_url1_appconnect[$perc50-1]}
p50_url1_pretransfer=${arr_url1_pretransfer[$perc50-1]}
p50_url1_starttransfer=${arr_url1_starttransfer[$perc50-1]}
# url 2
p50_url2_namelookup=${arr_url2_namelookup[$perc50-1]}
p50_url2_connect=${arr_url2_connect[$perc50-1]}
p50_url2_appconnect=${arr_url2_appconnect[$perc50-1]}
p50_url2_pretransfer=${arr_url2_pretransfer[$perc50-1]}
p50_url2_starttransfer=${arr_url2_starttransfer[$perc50-1]}

# 25
perc25=$(func_percentile 25 $cnt_req)
# url 1
p25_url1_namelookup=${arr_url1_namelookup[$perc25-1]}
p25_url1_connect=${arr_url1_connect[$perc25-1]}
p25_url1_appconnect=${arr_url1_appconnect[$perc25-1]}
p25_url1_pretransfer=${arr_url1_pretransfer[$perc25-1]}
p25_url1_starttransfer=${arr_url1_starttransfer[$perc25-1]}
# url 2
p25_url2_namelookup=${arr_url2_namelookup[$perc25-1]}
p25_url2_connect=${arr_url2_connect[$perc25-1]}
p25_url2_appconnect=${arr_url2_appconnect[$perc25-1]}
p25_url2_pretransfer=${arr_url2_pretransfer[$perc25-1]}
p25_url2_starttransfer=${arr_url2_starttransfer[$perc25-1]}


# Вычисление MIN & MAX
# url 1
url1_MIN_namelookup=${arr_url1_namelookup[0]}
url1_MAX_namelookup=${arr_url1_namelookup[-1]}
url1_MIN_connect=${arr_url1_connect[0]}
url1_MAX_connect=${arr_url1_connect[-1]}
url1_MIN_appconnect=${arr_url1_appconnect[0]}
url1_MAX_appconnect=${arr_url1_appconnect[-1]}
url1_MIN_pretransfer=${arr_url1_pretransfer[0]}
url1_MAX_pretransfer=${arr_url1_pretransfer[-1]}
url1_MIN_starttransfer=${arr_url1_starttransfer[0]}
url1_MAX_starttransfer=${arr_url1_starttransfer[-1]}
# url 2
url2_MIN_namelookup=${arr_url2_namelookup[0]}
url2_MAX_namelookup=${arr_url2_namelookup[-1]}
url2_MIN_connect=${arr_url2_connect[0]}
url2_MAX_connect=${arr_url2_connect[-1]}
url2_MIN_appconnect=${arr_url2_appconnect[0]}
url2_MAX_appconnect=${arr_url2_appconnect[-1]}
url2_MIN_pretransfer=${arr_url2_pretransfer[0]}
url2_MAX_pretransfer=${arr_url2_pretransfer[-1]}
url2_MIN_starttransfer=${arr_url2_starttransfer[0]}
url2_MAX_starttransfer=${arr_url2_starttransfer[-1]}


# Вычисление AVG
# url 1
url1_AVG_namelookup=$(func_avg arr_url1_namelookup)
url1_AVG_connect=$(func_avg arr_url1_connect)
url1_AVG_appconnect=$(func_avg arr_url1_appconnect)
url1_AVG_pretransfer=$(func_avg arr_url1_pretransfer)
url1_AVG_starttransfer=$(func_avg arr_url1_starttransfer)
# url 2
url2_AVG_namelookup=$(func_avg arr_url2_namelookup)
url2_AVG_connect=$(func_avg arr_url2_connect)
url2_AVG_appconnect=$(func_avg arr_url2_appconnect)
url2_AVG_pretransfer=$(func_avg arr_url2_pretransfer)
url2_AVG_starttransfer=$(func_avg arr_url2_starttransfer)


# Время работы скрипта (сек) + перевод секунд в часы, минуты, секунды
end=`date +%s`
runtime=$((end-start))
h=0
m=0
s=0
if [[ "$runtime" -ge 60 && "$runtime" -lt 3600 ]]
    then 
        m=$(echo "$runtime / 60" | bc)
        s=$(echo "$runtime - ($m * 60)" | bc )
elif [[ "$runtime" -ge 3600 ]]
    then
        h=$(echo "$runtime / 60 / 60" | bc)
        tmp_time=$(echo "$runtime - (($h * 60) * 60)" | bc)
        if [[ "$tmp_time" -ge 60 && "$tmp_time" -lt 3600 ]]
            then
                m=$(echo "$tmp_time / 60" | bc)
                s=$(echo "$tmp_time - ($m * 60)" | bc )
            else
                s=$tmp_time
        fi
else
    s=$runtime
fi

# echo "Test est time: $h h $m m $s s"

echo "$cnt_req Retries with interval $sleep_time seconds"
echo "Test estimated time: $h h $m m $s s"
echo "URL 1: ${arr_url[0]}"
echo "URL 2: ${arr_url[1]}"

echo "Metric: time_namelookup | URL 1 | URL 2"
echo "99: $p99_url1_namelookup $p99_url2_namelookup"
echo "95: $p95_url1_namelookup $p95_url2_namelookup"
echo "70: $p70_url1_namelookup $p70_url2_namelookup"
echo "50: $p50_url1_namelookup $p50_url2_namelookup"
echo "25: $p25_url1_namelookup $p25_url2_namelookup"
echo "AVG: $url1_AVG_namelookup $url2_AVG_namelookup"
echo "MIN: $url1_MIN_namelookup $url2_MIN_namelookup"
echo "MAX: $url1_MAX_namelookup $url2_MAX_namelookup"

echo "Metric: time_connect | URL 1 | URL 2"
echo "99: $p99_url1_connect $p99_url2_connect"
echo "95: $p95_url1_connect $p95_url2_connect"
echo "70: $p70_url1_connect $p70_url2_connect"
echo "50: $p50_url1_connect $p50_url2_connect"
echo "25: $p25_url1_connect $p25_url2_connect"
echo "AVG: $url1_AVG_connect $url2_AVG_connect"
echo "MIN: $url1_MIN_connect $url2_MIN_connect"
echo "MAX: $url1_MAX_connect $url2_MAX_connect"

echo "Metric: time_appconnect | URL 1 | URL 2"
echo "99: $p99_url1_appconnect $p99_url2_appconnect"
echo "95: $p95_url1_appconnect $p95_url2_appconnect"
echo "70: $p70_url1_appconnect $p70_url2_appconnect"
echo "50: $p50_url1_appconnect $p50_url2_appconnect"
echo "25: $p25_url1_appconnect $p25_url2_appconnect"
echo "AVG: $url1_AVG_appconnect $url2_AVG_appconnect"
echo "MIN: $url1_MIN_appconnect $url2_MIN_appconnect"
echo "MAX: $url1_MAX_appconnect $url2_MAX_appconnect"

echo "Metric: time_pretransfer | URL 1 | URL 2"
echo "99: $p99_url1_pretransfer $p99_url2_pretransfer"
echo "95: $p95_url1_pretransfer $p95_url2_pretransfer"
echo "70: $p70_url1_pretransfer $p70_url2_pretransfer"
echo "50: $p50_url1_pretransfer $p50_url2_pretransfer"
echo "25: $p25_url1_pretransfer $p25_url2_pretransfer"
echo "AVG: $url1_AVG_pretransfer $url2_AVG_pretransfer"
echo "MIN: $url1_MIN_pretransfer $url2_MIN_pretransfer"
echo "MAX: $url1_MAX_pretransfer $url2_MAX_pretransfer"

echo "Metric: time_starttransfer | URL 1 | URL 2"
echo "99: $p99_url1_starttransfer $p99_url2_starttransfer"
echo "95: $p95_url1_starttransfer $p95_url2_starttransfer"
echo "70: $p70_url1_starttransfer $p70_url2_starttransfer"
echo "50: $p50_url1_starttransfer $p50_url2_starttransfer"
echo "25: $p25_url1_starttransfer $p25_url2_starttransfer"
echo "AVG: $url1_AVG_starttransfer $url2_AVG_starttransfer"
echo "MIN: $url1_MIN_starttransfer $url2_MIN_starttransfer"
echo "MAX: $url1_MAX_starttransfer $url2_MAX_starttransfer"
