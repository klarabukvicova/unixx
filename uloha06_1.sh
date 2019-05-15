sort $1 -k 2,2 -o S1 
sort $2 -k 2,2 -o S2
sort $3 -k 2,2 -o S3


join -1 2 -2 2 S1 S2 > S4
join -1 2 -2 1 S3 S4 > S5

awk '{
	if( $2 == $3 && $3 == $4)
		print $2, $1;

	}' S5

rm S1 S2 S3 S4 S5
