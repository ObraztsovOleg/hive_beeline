h_array=("h55" "h80" "h86")

for h_key in ${h_array[@]}; do
	for (( i = 1; i <= 20; i++ )); do
		make move HNAME=$h_key USER=u$i
	done	
done
