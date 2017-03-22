#!/bin/bash
# Wrote on 3/22/17 by Cope

# Define filename for input
filein="local.txt"

# Define filename for output
fileout="local2.txt"

# Define host machine you want URL to show from
hostsite="local.com"

# Define HTTP codes to search for, pipe separated.
# Codes available at: https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
#codes="20|30"
#codes="200|301|302"
#codes="200"
codes="20|30"

# Define timeout for invalid URL's, 1 second will miss lots of URL's, 2 some, 5 few, 30 none
timeout="2"

# Determine file length
filelen=$(wc -l $filein | awk {'print $1'})

# Define homeless variables
i=0
loop=0

#Define magic things that I don't understand, copied from http://stackoverflow.com/questions/11393817/bash-read-lines-in-file-into-an-array
IFS=$'\r\n' GLOBIGNORE='*' command eval 'XYZ=($(cat $filein))'

#Wipe output file if ran again, change output marker if you just want it to append, or comment out
echo "Good response URL List:" > $fileout

# Only loop through array for the duration of the file length, instead of forever
while [ $loop -lt $filelen ]; do
loop=$[$loop+1]
i=$[$i+1]
curl -s -I -H 'Host: $host' -m $timeout "${XYZ[$i]}" | grep "HTTP\/" | egrep "$codes" >/dev/null && echo "${XYZ[$i]}" >> $fileout 
done

# END
