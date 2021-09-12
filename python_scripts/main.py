import time, subprocess, math, sys

def reqTime(target_url):
	req = subprocess.run(["curl", "-sS", "-o", "/dev/null", "-w", "%{time_namelookup} %{time_connect} %{time_appconnect} %{time_pretransfer} %{time_starttransfer}", target_url], stdout=subprocess.PIPE)
	req_out = str(req.stdout)
	arr_req_time = req_out[2:-1].split(" ")
	return arr_req_time

def percentile(perc, req_cnt):
	x = perc / 100 * req_cnt
	return math.ceil(x)

arr_url = ["https://gcorelabs.com", "https://cloudflare.com"]
cnt_req = 100 
slp = 0.5
path_to_save = "/home/centos/python_scripts/timings"

arr_data = []
arr_url1_namelookup = []
arr_url1_connect = []
arr_url1_appconnect = []
arr_url1_pretransfer = []
arr_url1_starttransfer = []

arr_url2_namelookup = []
arr_url2_connect = []
arr_url2_appconnect = []
arr_url2_pretransfer = []
arr_url2_starttransfer = []

for i in range(cnt_req):
	for j in arr_url:
		tmp_arr = reqTime(j)
		time.sleep(slp)
		if j == arr_url[0]:
			arr_url1_namelookup.append(round(float(tmp_arr[0]), 3))
			arr_url1_connect.append(round(float(tmp_arr[1]) - float(tmp_arr[0]), 3)) 
			arr_url1_appconnect.append(round(float(tmp_arr[2]) - float(tmp_arr[1]), 3))
			arr_url1_pretransfer.append(round(float(tmp_arr[3]) - float(tmp_arr[2]), 3))
			arr_url1_starttransfer.append(round(float(tmp_arr[4]) - float(tmp_arr[3]), 3))
		else:
			arr_url2_namelookup.append(round(float(tmp_arr[0]), 3))
			arr_url2_connect.append(round(float(tmp_arr[1]) - float(tmp_arr[0]), 3)) 
			arr_url2_appconnect.append(round(float(tmp_arr[2]) - float(tmp_arr[1]), 3))
			arr_url2_pretransfer.append(round(float(tmp_arr[3]) - float(tmp_arr[2]), 3))
			arr_url2_starttransfer.append(round(float(tmp_arr[4]) - float(tmp_arr[3]), 3))

arr_url1_namelookup.sort()
arr_url1_connect.sort()
arr_url1_appconnect.sort()
arr_url1_pretransfer.sort()
arr_url1_starttransfer.sort()

arr_url2_namelookup.sort()
arr_url2_connect.sort()
arr_url2_appconnect.sort()
arr_url2_pretransfer.sort()
arr_url2_starttransfer.sort()

#with open ("/home/centos/timings.txt", "w") as f:
sys.stdout = open(path_to_save, "w")
print(cnt_req, "Retries with interval", slp, "s.")
print("URL 1:", arr_url[0])
print("URL 2:", arr_url[1], "\n")

print("Metric: time_namelookup | URL 1 | URL 2")
print("99:", arr_url1_namelookup[percentile(99, cnt_req)-1], arr_url2_namelookup[percentile(99, cnt_req)-1])
print("95:", arr_url1_namelookup[percentile(95, cnt_req)-1], arr_url2_namelookup[percentile(95, cnt_req)-1])
print("70:", arr_url1_namelookup[percentile(70, cnt_req)-1], arr_url2_namelookup[percentile(70, cnt_req)-1])
print("50:", arr_url1_namelookup[percentile(50, cnt_req)-1], arr_url2_namelookup[percentile(50, cnt_req)-1])
print("25:", arr_url1_namelookup[percentile(25, cnt_req)-1], arr_url2_namelookup[percentile(25, cnt_req)-1])
print("AVG:", round(sum(arr_url1_namelookup)/len(arr_url1_namelookup), 3), round(sum(arr_url2_namelookup)/len(arr_url2_namelookup), 3))
print("MIN:", arr_url1_namelookup[0], arr_url2_namelookup[0])
print("MAX:", arr_url1_namelookup[-1], arr_url2_namelookup[-1])

print("Metric: time_connect | URL 1 | URL 2")
print("99:", arr_url1_connect[percentile(99, cnt_req)-1], arr_url2_connect[percentile(99, cnt_req)-1])
print("95:", arr_url1_connect[percentile(95, cnt_req)-1], arr_url2_connect[percentile(95, cnt_req)-1])
print("70:", arr_url1_connect[percentile(70, cnt_req)-1], arr_url2_connect[percentile(70, cnt_req)-1])
print("50:", arr_url1_connect[percentile(50, cnt_req)-1], arr_url2_connect[percentile(50, cnt_req)-1])
print("25:", arr_url1_connect[percentile(25, cnt_req)-1], arr_url2_connect[percentile(25, cnt_req)-1])
print("AVG:", round(sum(arr_url1_connect)/len(arr_url1_connect), 3), round(sum(arr_url2_connect)/len(arr_url2_connect), 3))
print("MIN:", arr_url1_connect[0], arr_url2_connect[0])
print("MAX:", arr_url1_connect[-1], arr_url2_connect[-1])

print("Metric: time_appconnect | URL 1 | URL 2")
print("99:", arr_url1_appconnect[percentile(99, cnt_req)-1], arr_url2_appconnect[percentile(99, cnt_req)-1])
print("95:", arr_url1_appconnect[percentile(95, cnt_req)-1], arr_url2_appconnect[percentile(95, cnt_req)-1])
print("70:", arr_url1_appconnect[percentile(70, cnt_req)-1], arr_url2_appconnect[percentile(70, cnt_req)-1])
print("50:", arr_url1_appconnect[percentile(50, cnt_req)-1], arr_url2_appconnect[percentile(50, cnt_req)-1])
print("25:", arr_url1_appconnect[percentile(25, cnt_req)-1], arr_url2_appconnect[percentile(25, cnt_req)-1])
print("AVG:", round(sum(arr_url1_appconnect)/len(arr_url1_appconnect), 3), round(sum(arr_url2_appconnect)/len(arr_url2_appconnect), 3))
print("MIN:", arr_url1_appconnect[0], arr_url2_appconnect[0])
print("MAX:", arr_url1_appconnect[-1], arr_url2_appconnect[-1])

print("Metric: time_pretransfer | URL 1 | URL 2")
print("99:", arr_url1_pretransfer[percentile(99, cnt_req)-1], arr_url2_pretransfer[percentile(99, cnt_req)-1])
print("95:", arr_url1_pretransfer[percentile(95, cnt_req)-1], arr_url2_pretransfer[percentile(95, cnt_req)-1])
print("70:", arr_url1_pretransfer[percentile(70, cnt_req)-1], arr_url2_pretransfer[percentile(70, cnt_req)-1])
print("50:", arr_url1_pretransfer[percentile(50, cnt_req)-1], arr_url2_pretransfer[percentile(50, cnt_req)-1])
print("25:", arr_url1_pretransfer[percentile(25, cnt_req)-1], arr_url2_pretransfer[percentile(25, cnt_req)-1])
print("AVG:", round(sum(arr_url1_pretransfer)/len(arr_url1_pretransfer), 3), round(sum(arr_url2_pretransfer)/len(arr_url2_pretransfer), 3))
print("MIN:", arr_url1_pretransfer[0], arr_url2_pretransfer[0])
print("MAX:", arr_url1_pretransfer[-1], arr_url2_pretransfer[-1])

print("Metric: time_starttransfer | URL 1 | URL 2")
print("99:", arr_url1_starttransfer[percentile(99, cnt_req)-1], arr_url2_starttransfer[percentile(99, cnt_req)-1])
print("95:", arr_url1_starttransfer[percentile(95, cnt_req)-1], arr_url2_starttransfer[percentile(95, cnt_req)-1])
print("70:", arr_url1_starttransfer[percentile(70, cnt_req)-1], arr_url2_starttransfer[percentile(70, cnt_req)-1])
print("50:", arr_url1_starttransfer[percentile(50, cnt_req)-1], arr_url2_starttransfer[percentile(50, cnt_req)-1])
print("25:", arr_url1_starttransfer[percentile(25, cnt_req)-1], arr_url2_starttransfer[percentile(25, cnt_req)-1])
print("AVG:", round(sum(arr_url1_starttransfer)/len(arr_url1_starttransfer), 3), round(sum(arr_url2_starttransfer)/len(arr_url2_starttransfer), 3))
print("MIN:", arr_url1_starttransfer[0], arr_url2_starttransfer[0])
print("MAX:", arr_url1_starttransfer[-1], arr_url2_starttransfer[-1])















