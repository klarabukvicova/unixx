sort countrycodes_en.csv -t ";" -k 2 -o ZemeSort.csv 
sort kodyzemi_cz.csv -t ";" -k 3 -o KodySort.csv
join -t ";" -1 2 -2 3 ZemeSort.csv KodySort.csv > Sorted
awk -F ";" '{
	if ( $2 == $NF ) {
		gsub("\"","",$2)
		print $2
		}	
	}' Sorted

rm ZemeSort.csv KodySort.csv Sorted 
