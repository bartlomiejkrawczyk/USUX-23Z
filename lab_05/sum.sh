#!/bin/sh
if [ $# -eq 0 ]
then
   echo Poprawne wywolanie: $0 arg1 arg2 ...
   exit 1
fi

suma=0

while [ $1 ]
do
  suma=`expr $suma + $1 2> /dev/null`
  if [ $? -eq 2 ]
  then
     echo "Niewlasciwy argument !"
     exit 2
  fi
  shift
done

echo "Suma argumentow wynosi: $suma";
