#///////////////////////////////////////////////////////////////////////////////////////////#

# stright up just clear with different name. simple as.
alias cls='
clear
'

#///////////////////////////////////////////////////////////////////////////////////////////#

# this shit'll show you your ip addresses. ipv4 only just so its larp correct. what is not
# larp correct is the fact i replaced connection specific DNS prefix with interface name and
# made the script print all interfaces instead of just one.
alias ipconfig='

# flavor text
echo ""
echo "Ethernet adapter Local Area Connections"

# get list of interfaces
cmd=$(ls /sys/class/net)

# main loop
for int in $cmd; do

	# interface specific variables - this is inefficient as shit. i hate it. im not gonna
	# change it. the script is not slow, its just larp correct.
	addr=$(ifconfig $int | grep -E -o "([0-9]{1,3}[/.]){3}[0-9]{1,3}" | head -1)
	msk=$(ifconfig $int | grep -E -o "([0-9]{1,3}[/.]){3}[0-9]{1,3}" | head -2 | tail -1)
	gtw=$(ifconfig $int | grep -E -o "([0-9]{1,3}[/.]){3}[0-9]{1,3}" | tail -1)

	# interface
	echo ""
	echo "	Interface-name: . . . . . . . . . : [$int]"
	echo "	IP Adress . . . . . . . . . . . . : $addr"
	echo "	Subnet Mask . . . . . . . . . . . : $msk"
	echo "	Default Gateway . . . . . . . . . : $gtw"

# end of loop
done
echo ""

'

#///////////////////////////////////////////////////////////////////////////////////////////#

# this alias simulates the dir command. just displays structure of working directory along
# side some nifty information like size of items in bytes
alias dir='

# flavor text
echo ""
echo "	Volume in drive C has no label"
echo "	Volume Serial Number is 68CB-14F4"
echo ""
echo "	Directory of C:$PWD/"
echo ""

# some initial variables
totalclear=0
totalsize=0
files=0
dirs=0
totalclear=$( df --output=avail -B 1 "$PWD" | tail -n 1 )

# main loop, incriments over each item in the working directory
for entery in *; do

	# gets the last edited date of the current file or folder
	date=$(date -r "$entery" +"%m/%d/%Y   %H:%M")

	# printout style for folders
        if [ -d "$entery" ]; then
		dirs=$((dirs+1))
		echo "$date	<DIR>           $entery"

	# printout style for files
	elif [ -f "$entery" ]; then
		files=$((files+1))
		size=$(stat -c "%s" "$entery")
		totalsize=$((totalsize+size))
		echo "$date	$size		$entery"
	
	# fallback incase neither file not dir (monkey esque shit)
	else echo "ERROR"
	fi

# loop over
done   

# more flavor text
echo "		$files File<s>	$totalsize bytes"
echo "		$dirs Dir<s>	$totalclear bytes clear"
echo ""
'

#///////////////////////////////////////////////////////////////////////////////////////////#
