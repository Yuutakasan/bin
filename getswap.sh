#!/bin/bash
# Get current swap usage for all running processes
# Erik Ljungstrom 27/05/2011
# Updated: 2013-11-13 Yuichiro Saito https://gist.github.com/koemu/8015682
SUM=0
OVERALL=0
for DIR in `find /proc/ -maxdepth 1 -type d | egrep "^/proc/[0-9]"` ; do
PID=`echo $DIR | cut -d / -f 3`
PROGNAME=`ps -p $PID -o comm --no-headers`
for SWAP in `grep Swap $DIR/smaps 2>/dev/null| awk '{ print $2 }'`
do
let SUM=$SUM+$SWAP
done
echo "PID=$PID - Swap used: $SUM - (${PROGNAME})"
let OVERALL=$OVERALL+$SUM
SUM=0
 
done
echo "Overall swap used: $OVERALL"