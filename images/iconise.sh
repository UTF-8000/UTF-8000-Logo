#!/bin/bash -eu

# iconise a 16x16 image into multiple sizes, and a 16x16 ico and a multi-size ico

[[ -z "$1" ]] && echo "Supply 16x16 image" && exit 1
[[ -z "$2" ]] && echo "Supply icons image extension" && exit 1

mkdir -p "./$1_many_sizes/$2"

declare -a scalefactors=(1 2 3 4 6 8 9 12 16 24 32 48 64 96 128)
for scalefactor in ${scalefactors[@]}; do
	convert -compress None "$1" -interpolate Integer -filter point -resize "${scalefactor}00%" "$1_many_sizes/$2/$2_$((16 * $scalefactor)).$2"
	convert "$1" -compress None "$1_many_sizes/ico_16.ico"
	convert "$1" -fill "#00000000" -opaque '#00000000' -interpolate Integer -filter point -compress None -define icon:auto-resize=16,32,48,64,96,128,144,192,256 "$1_many_sizes/ico.ico"
done
