#/bin/bash

while true; do head -c505 /dev/urandom | od -An -w46 -x | grep -E --color "([[:alpha:]][[:digit:]]){2}"; sleep $[RANDOM % 4].$[$RANDOM % 10]5; done
