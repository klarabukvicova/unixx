#!/bin/awk -f
BEGIN {
	# nastavime separator zaznamov na znak <
	RS="<"
}

# nasledujuce prikazy sa vykonaju pre zaznamy, ktore matchuju dany regularny
# vyraz (zacinaju na "A " alebo "a ")
/^[Aa] / {
	for (i = 2; i <= NF; ++i) {
	        #print i 	
		if ($i ~ /[Hh][Rr][Ee][Ff]/) {
			print $i
				if ($i ~ /=/) {
					if($i ~ /'/) {
						split($i,A,"\'")
						print A[2]
						next
					}
					if($i ~ /=[^ ][^\n]/) {
						split($i,A,"=")
						split(A[2],B,">")
						print B[1]
						next
					}
					l = $(i + 2)
					gsub("&amp;", "&", 1)
					gsub("&quot;", "\"", l)
					gsub("&lt;", "<", l)
					gsub("&gt;", ">", l)
					print l
					next
				}		
		}	
	}
}
