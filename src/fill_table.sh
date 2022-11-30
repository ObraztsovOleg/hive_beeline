h_array=("h31")

for h_key in ${h_array[@]}; do
	for (( i = 2; i <= 20; i++ )); do
		make hive_beeline HNAME=$h_key USER=u$i
	done
done
