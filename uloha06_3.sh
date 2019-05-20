awk -F ":" 'BEGIN
	{
	n = split($4,A,",")
	sub("$",":"n)
	print $0
	}'
	$1 -o pomocna

sort -t ":" -r -k 5 pomocna -o pomocnaSorted

awk -F ":" 'BEGIN 
	{ i = 1 } {
	if (i==1) {
		n = $5; i=i+1}
		if ($5 == n) {
			print $1
		}
	}' pomocnaSorted

rm  pomocna pomocnaSorted
