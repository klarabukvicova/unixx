if [ "$1" == "--help" ]; then
	echo "POUZITI: uloha02.sh [OPTION] [args]"
	echo " --normal  vypise vsechny argumenty, kaydy na jeden radek"
	echo " --reverse vypise vsechny argumenty v opacnem poradi, kazdy na jeden radek"
	echo " --subst   druhy je nejaky retezec A a treti je nejaky retezec B, v kazdem dalsim argumentu se A nahradi B"
	echo " --len     do jedne radky vypise delku vsech argumentu"
	echo " --help    vypise navod na pouziti tohoto programu"

elif [ "$1" == "--len" ]; then
	for arg in "$@"; do
		echo -n $(expr $(echo $arg | wc -m) - 1) " "
	done
	echo 
elif [ "$1" == "--subst" ]; then
	A="$2"
	B="$3"
	shift 3
	for arg in "$@"; do
		echo "$arg" | sed -e "s/$A/$B/g"
	done

elif [ "$1" == "--reverse" ]; then
	for arg in "$@"; do
		echo "$arg"
	done | tac

elif [ "$1" == "--normal" ]; then
	for arg in "$@"; do
		echo "$arg"
	done
fi
exit 0

