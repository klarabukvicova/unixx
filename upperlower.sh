X="0"
Pracuj() {
	find $1 > pomocna
	while read line; do
		p=`echo "$line" | awk -F "\/" '{ print $NF }'`
	       	path=`echo "$line" | awk -F "\/" 'BEGIN { OFS="/"} { $NF=""; print $0 }'`	
		if ! [[ -d "$path"/"$p" ]]; then
			if [[ "$X" == "-r" ]]; then
				! [[ "$p" =~ [A-Z] ]] || continue
				new=`awk '{ print toupper($0); }' <<< "$p"`
			else 
				! [[ "$p" =~ [a-z] ]] || continue
				new=`awk '{ print tolower($0); }' <<< "$p"`
			fi			
			if [ -e "$path"/"$nove" ]; then
				echo "Chyba: kolize na $new" >&2
			else
				mv "$path"/"$p" "$path"/"$new"
			fi
		fi
	done < pomocna
}

if [ -n "$1" ]; then 
	X="$1"
	if [ -z "$1" ]; then
		path=$(pwd)
		Pracuj $path
	else
		while [ -n "$1" ]; do
			path="$1"
			shift 1
			Pracuj "$path"		
		done
	fi
	if [ "$1" == "-r" ]; then
		shift 1
	fi

else 
	path=$(pwd)
	#echo $path
	Pracuj "$path"
fi
rm pomocna

