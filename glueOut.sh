#!/bin/bash


nargs=2

if [ $# -ne $nargs ]
then
  echo "Usage: `basename $0` temperature baseFileName"
  echo "Eg: ./`basename $0` 325.0 Formic"
  exit 1
fi


Temp=$1
base=$2

T=`echo $Temp | awk '{printf "%.2f", $1}'`

find . -name ${base}*_${T}.out > tmp
cat tmp | awk -F / '{print $2, $3}' | sort -k 2 | awk '{print "./",$1,"/",$2}' | sed "s; ;;g" > tmp2
rm -f ${base}-${T}.out
for i in `cat tmp2`
 do
  echo "dump $i"
  cat $i >> ${base}-${T}.out
 done

echo "files glued in ${base}-${T}.out"
rm -f tmp tmp2
