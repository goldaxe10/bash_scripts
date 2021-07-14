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

a=10
b=1211111111
let "c = $a % $b"
echo $c