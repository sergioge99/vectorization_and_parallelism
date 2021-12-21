#!/bin/bash

for i in 1 2 4 8 16 32;
do
  export OMP_NUM_THREADS=$i	#bash
  #setenv OMP_NUM_THREADS $i	#csh
  echo "ejecutando $1 con $i threads"
  echo " "
  ./$1
  echo "---"
  echo " "
done

