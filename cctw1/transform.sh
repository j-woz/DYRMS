#!/bin/bash
set -eu

# Each non-zero cell copies its value to all 4 neighbor cells

if [[ ${#*} != 5 ]]
then
  echo "usage: <OUTPUT.NXS> <M> <N> <INPUT.NXS> <ROW>"
  exit 1
fi

OUTPUT=$1
M=$2
N=$3
INPUT=$4
LINE=$5  # Current cell number

(( L=LINE+1 ))

# The output array
OUT=()
# Total number of cells
SIZE=$(( M * N ))

# The color of this cell
C=$( awk "NR == ${L} { print \$2 }" ${INPUT} )

# Copy my color to output cells
for P in ${LINE} $(( LINE-1 )) $(( LINE+1 )) $(( LINE-M )) $(( LINE+M ))
do
  if (( P >= 0 )) && (( P < SIZE ))
  then
    OUT[${P}]=${C}
  fi
done

k=0
for (( i=0 ; i<M ; i++ ))
do
  for (( j=0 ; j<N ; j++ ))
  do
    echo ${k} ${OUT[${k}]:-0}
    (( k++ )) || true
  done
done > ${OUTPUT}
