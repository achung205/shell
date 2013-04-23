#! /bin/bash
#Andrew Yun Seok Chung

if [[ $# -eq 0 ]]; then
	echo "Executable name required."
	echo "usage: makemake.sh executable_name"

else
	# *.out part

        echo -n "$1 : " >> Makefile
	for f in $(ls); do
		if [[ $f == *.cpp ]]; then
			echo -n ${f%\.cpp}\.o " " >> Makefile
		fi
	done
	
	# g++ part

	echo -e -n "\n\tg++ -ansi -Wall -g -o $1 " >> Makefile
	#options
	for o in $@; do
		if [[ $o == -* ]]; then
		echo -n $o " " >> Makefile
		fi
	done
	for f in $(ls); do
		 if [[ $f == *.cpp ]]; then
                        echo -n ${f%\.cpp}\.o " " >> Makefile
                fi
	done

	# *.o part

        for f in $(ls); do
		if [[ $f == *.cpp ]]; then
			echo -e -n "\n\n${f%\.cpp}.o : $f " >> Makefile
			for x in $(awk '/#include/' $f); do
				if [[ $x == \"*.h\" ]]; then
					y=${x#\"*}
					z=${y%*\"}
					echo -n $z " " >> Makefile
				fi
			done
			
			# g++ part
			echo -e -n "\n\tg++ -ansi -Wall -g -c " >> Makefile
        		for o in $@; do
                		if [[ $o == -* ]]; then
                        		echo -n $o " " >> Makefile
                		fi
        		done
        		echo -n $f >> Makefile

		fi
        done

	echo -e "\n\nclean : " >> Makefile
	echo -e -n "\trm -f " >> Makefile
	
	for f in $(ls); do
                if [[ $f == *.cpp ]]; then
                        echo -n ${f%\.cpp}\.o " " >> Makefile
                fi
        done

fi
