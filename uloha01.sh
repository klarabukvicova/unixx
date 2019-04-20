if [ "$1" == "--help" ]; then
	echo "pouziti: uloha01.sh [--typ|--help] [cesta_k_souboru]"
	echo " --typ ukaze typ souboru"
	echo " --help ukaze help k uloha01.sh"
	echo "Exit status:"
	echo " 0... kdyz soubor existuje"
	echo " 1... kdyz soubor neexistuje"
	exit 0
elif [ "$1" == "--typ" ]; then
	if [ -e "$2" ]; then
		if [ -d "$2" ]; then
			echo "adresar"
		elif [ -f "$2" ]; then
			echo "soubor"
		elif [ -L "$2" ]; then
			echo "symbolicky link"
		elif [ -p "$2" ]; then
			echo "rura"
		elif [ -s "$2" ]; then
			echo "socket"
		elif [ -b "$2" ]; then
			echo "blokove zarazeni"
		elif [ -c "$2" ]; then 
			echo "znakove zarazeni"
		fi
	else 
		echo "Chyba"
		exit 1
	fi 
	exit 0
fi
