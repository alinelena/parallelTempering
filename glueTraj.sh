#!/bin/bash


nargs=3
echo $#
if [ $# -eq $nargs -o $# -eq $((nargs-1)) ]; then
 Temp=$1
 base=$2
 
 if [ "x$3" == "x" ]; then
   suf="HOMO_centers_s1-1_0"
 else
   suf=$3
 fi
else
  echo "Usage: `basename $0` temperature baseFileName <endName>"
  echo "Eg: ./`basename $0` 325.0 Formic HOMO_centers_s1-1_0"
  echo "Eg: ./`basename $0` 325.0 Formic"
  exit 1
fi

Temp=$1
base=$2

T=`echo $Temp | awk '{printf "%.2f", $1}'`

find . -name ${base}*_${T}-${suf}.xyz > tmp
cat tmp | awk -F / '{print $2, $3}' | sort -k 2 | awk '{print "./",$1,"/",$2}' | sed "s; ;;g" > tmp2
rm -f ${base}-${T}.xyz
for i in `cat tmp2`
 do
  echo "dump traj $i"
  cat $i >> ${base}-${T}.xyz
 done

echo "trajectories glued in ${base}-${T}.xyz"
rm -f tmp tmp2
