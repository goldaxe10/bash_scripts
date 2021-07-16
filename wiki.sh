# Перебор массива
# x=(0.111 0.2222 0.3333)
# for i in ${x[@]}; do
#     echo $i
# done

# Вывод всего массива
# echo ${arr_results[@]}

# Вывод индекса массива
# echo ${arr_results[1]}

# Добавление нуля у вещественного числа
# time_connect=$(echo "${arr_results[1]} - ${arr_results[0]}" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')

# заменить одни символы в определенном элементе массива или во всем массиве на другие.
# echo ${array[@]//р/Р}

# Деление вещественных чисел 
# xyz=$(bc<<<"scale=10;$xyz/7" | sed -e 's/^\./0./' -e 's/^-\./-0./')

# Сложение вещественных чисел
# x=0.01
# y=0.001 
# z=$(echo "$x + $y" | bc)
# echo Sum is $z

# arr_results=(0.111 0.2322 0.111111 0.213443)
# echo ${arr_results[@]}
# time_namelookup=${arr_results[0]}
# echo $time_namelookup
# time_connect=$(echo "${arr_results[1]} - ${arr_results[0]}" | bc)
# echo $time_connect

# Создание "псевдомногомерного массива"
# arr=("1 2 3" "one")
# arr1=($(echo "${arr[0]}"))
# echo ${arr1[@]}

# Определить длину строки
# myvar="some string"
# size=${#myvar} 

# Сравнение вещественных чисел
# a=0.01
# b=0.001
# if [[ $a > $b ]]
# then
# echo "A>B"
# else
# echo "A<B"
# fi

# Функция сортировки пузырьком с передачей массива в неё
# tmp=(0.123 0.01 0.1 1.1 1.1 0.0000001)
# func(){
#     local -n argArray=$1
#     arrayLen="${#argArray[@]}"
#     flag=1
#     for (( i=0; i < arrayLen-1 && flag==1 ; i++ ))
#     do
#         flag=0
#         for (( j=0; j<arrayLen-i-1; j++ ))
#         do
#             if [[ ${argArray[$j]} > ${argArray[$j+1]} ]]; then
#                 temp=${argArray[$j]}
#                 argArray[$j]=${argArray[$j+1]}
#                 argArray[$j+1]=$temp
#                 flag=1
#             fi
#         done
#     done  
# }
# func tmp
# echo ${tmp[@]}

# Вычисление перцентиля
# func_percentile(){
#     x1=$(bc<<<"scale=2;$1/100*$2" | sed -e 's/^\./0./' -e 's/^-\./-0./')
#     x2=$(echo $x1 | awk '{print int($1+0.5)}')
#     x3=$(bc<<<"scale=2;$x1-$x2" | sed -e 's/^\./0./' -e 's/^-\./-0./')
#     x4=$(bc<<<"scale=2;1-$x3" | sed -e 's/^\./0./' -e 's/^-\./-0./')
#     if [[ "$x4" == "1" ]]
#         then
#             ind_res=$x2
#             echo $ind_res
#         else
#             x5=$(bc<<<"scale=2;$x1+$x4" | sed -e 's/^\./0./' -e 's/^-\./-0./')
#             ind_res=$(echo $x5 | awk '{print int($1+0.5)}')
#             echo $ind_res
#             # ind_result=$(bc<<<"scale=2;$x1+$x3" | sed -e 's/^\./0./' -e 's/^-\./-0./')
#             # echo $ind_result
#        fi
# }
# func_percentile 99 5

# Вычисление среднего значения из массива данных
# cnt_req=10
# tmp=(0.123 0.01 0.1 1.1 1.1)
# func_avg(){
#     tmp_avg=0.0
#     local -n tmp_arr=$1
#     for (( cnt=0; cnt<${#tmp_arr[@]}; cnt++ )); do
#         tmp_avg=$(echo "$tmp_avg + ${tmp_arr[$cnt]}" | bc | sed -e 's/^\./0./' -e 's/^-\./-0./')
#     done
#     tmp_avg=$(bc<<<"scale=6;$tmp_avg/$cnt_req" | sed -e 's/^\./0./' -e 's/^-\./-0./')
#     echo $tmp_avg
# }
# func_avg tmp
# echo ${#tmp[@]}

# Время работы скрипта + перевод секунд в часы минуты секунды
# start=`date +%s`
# sleep 10
# end=`date +%s`
# runtime=$((end-start))
# h=0
# m=0
# s=0
# if [[ "$runtime" -ge 60 && "$runtime" -lt 3600 ]]
#     then 
#         m=$(echo "$runtime / 60" | bc)
#         s=$(echo "$runtime - ($m * 60)" | bc )
# elif [[ "$runtime" -ge 3600 ]]
#     then
#         h=$(echo "$runtime / 60 / 60" | bc)
#         tmp_time=$(echo "$runtime - (($h * 60) * 60)" | bc)
#         if [[ "$tmp_time" -ge 60 && "$tmp_time" -lt 3600 ]]
#             then
#                 m=$(echo "$tmp_time / 60" | bc)
#                 s=$(echo "$tmp_time - ($m * 60)" | bc )
#             else
#                 s=$tmp_time
#         fi
# else
#     s=$runtime
# fi
# echo "Test est time: $h h $m m $s s" 