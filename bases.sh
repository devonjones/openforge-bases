#!/bin/bash

set -e

: ${OPENSCAD:="openscad"}
: ${CONVERTSTL:="./convertSTL.rb"}
#declare -a style=("plain" "stone")
declare -a style=("plain")
declare -a boolean=("union" "difference")
declare -a square_basis=("25mm" "inch" "wyloch")
declare -a shape=("square" "curved" "diagonal")
declare -a largecurved=("a" "b" "c")
declare -a largecurvedsize=("6" "8")
declare -a odddiagonalsize=("2" "4")
declare -a dragonlocksize=("2" "4")

##
## 1x1 - 4x4, square, diagonal, curved
##

for style in "${style[@]}"
do
	for basis in "${square_basis[@]}"
	do
		for s in "${shape[@]}"
		do
			for x in {1..4}
			do
				for y in {1..4}
				do
#					##
#					## magnetic
#					##
#					echo "$style.$basis.$s.${x}x${y}"
#					mkdir -p $basis/$style/$s/magnetic/
#					$OPENSCAD -o $basis/$style/$s/magnetic/base.$style.$s.$basis.${x}x${y}.magnetic.stl \
#						-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\""\
#						-D "shape=\"$s\"" \
#						-D "style=\"${style}\"" \
#						-D "topless=\"false\"" \
#						-D "lock=\"none\"" -D "magnet_hole=6" bases.scad
#					$CONVERTSTL $basis/$style/$s/magnetic/base.$style.$s.$basis.${x}x${y}.magnetic.stl
#					mv $basis/$style/$s/magnetic/base.$style.$s.$basis.${x}x${y}.magnetic-binary.stl $basis/$style/$s/magnetic/base.$style.$s.$basis.${x}x${y}.magnetic.stl

#					##
#					## magnetic.openlock
#					##
#					mkdir -p $basis/$style/$s/magnetic.openlock/
#					$OPENSCAD -o $basis/$style/$s/magnetic.openlock/base.$style.$s.$basis.${x}x${y}.magnetic.openlock.stl \
#						-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\"" \
#						-D "shape=\"$s\"" \
#						-D "style=\"${style}\"" \
#						-D "topless=\"false\"" \
#						-D "lock=\"openlock\"" -D "magnet_hole=6" -D 'priority="magnetic"' bases.scad
#					$CONVERTSTL $basis/$style/$s/magnetic.openlock/base.$style.$s.$basis.${x}x${y}.magnetic.openlock.stl
#					mv $basis/$style/$s/magnetic.openlock/base.$style.$s.$basis.${x}x${y}.magnetic.openlock-binary.stl $basis/$style/$s/magnetic.openlock/base.$style.$s.$basis.${x}x${y}.magnetic.openlock.stl
#
#					##
#					## openlock.magnetic for 1x & x1 square tiles
#					##
#					if [[ ( $x == 1 || $y == 1 ) ]] ; then
#						mkdir -p $basis/$style/$s/magnetic.openlock/
#						$OPENSCAD -o $basis/$style/$s/magnetic.openlock/base.${style}.$s.$basis.${x}x1.openlock.magnetic.stl \
#							-D "x=${x}" -D "y=1" -D "square_basis=\"$basis\"" \
#							-D "shape=\"$s\"" \
#							-D "style=\"${style}\"" \
#							-D "topless=\"false\"" \
#							-D "lock=\"openlock\"" -D "magnet_hole=6" -D 'priority="lock"' bases.scad
#						$CONVERTSTL $basis/$style/$s/magnetic.openlock/base.${style}.$s.$basis.${x}x1.openlock.magnetic.stl
#						mv $basis/$style/$s/magnetic.openlock/base.${style}.$s.$basis.${x}x1.openlock.magnetic-binary.stl $basis/$style/$s/magnetic.openlock/base.${style}.$s.$basis.${x}x1.openlock.magnetic.stl
#					fi

					##
					## magnetic.openlock.topless
					##
					mkdir -p $basis/$style/$s/magnetic.openlock.topless/
					$OPENSCAD -o $basis/$style/$s/magnetic.openlock.topless/base.$style.$s.$basis.${x}x${y}.magnetic.openlock.topless.stl \
						-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\"" \
						-D "shape=\"$s\"" \
						-D "style=\"${style}\"" \
						-D "topless=\"true\"" \
						-D "lock=\"openlock\"" -D "magnet_hole=6" -D 'priority="magnetic"' bases.scad
					$CONVERTSTL $basis/$style/$s/magnetic.openlock.topless/base.$style.$s.$basis.${x}x${y}.magnetic.openlock.topless.stl
					mv $basis/$style/$s/magnetic.openlock.topless/base.$style.$s.$basis.${x}x${y}.magnetic.openlock.topless-binary.stl $basis/$style/$s/magnetic.openlock.topless/base.$style.$s.$basis.${x}x${y}.magnetic.openlock.topless.stl

					##
					## openlock.magnetic.topless for 1x & x1 square tiles
					##
					if [[ ( $x == 1 || $y == 1 ) ]] ; then
						mkdir -p $basis/$style/$s/magnetic.openlock.topless/
						$OPENSCAD -o $basis/$style/$s/magnetic.openlock.topless/base.${style}.$s.$basis.${x}x1.openlock.magnetic.topless.stl \
							-D "x=${x}" -D "y=1" -D "square_basis=\"$basis\"" \
							-D "shape=\"$s\"" \
							-D "style=\"${style}\"" \
							-D "topless=\"true\"" \
							-D "lock=\"openlock\"" -D "magnet_hole=6" -D 'priority="lock"' bases.scad
						$CONVERTSTL $basis/$style/$s/magnetic.openlock.topless/base.${style}.$s.$basis.${x}x1.openlock.magnetic.topless.stl
						mv $basis/$style/$s/magnetic.openlock.topless/base.${style}.$s.$basis.${x}x1.openlock.magnetic.topless-binary.stl $basis/$style/$s/magnetic.openlock.topless/base.${style}.$s.$basis.${x}x1.openlock.magnetic.topless.stl
					fi

#					##
#					## openlock
#					##
#
#					mkdir -p $basis/$style/$s/openlock/
#					$OPENSCAD -o $basis/$style/$s/openlock/base.$style.$s.$basis.${x}x${y}.openlock.stl \
#						-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\"" \
#						-D "shape=\"$s\"" \
#						-D "style=\"${style}\"" \
#						-D "topless=\"false\"" \
#						-D "lock=\"openlock\"" -D "magnet_hole=0" -D "priority=\"lock\"" bases.scad
#					$CONVERTSTL $basis/$style/$s/openlock/base.$style.$s.$basis.${x}x${y}.openlock.stl
#					mv $basis/$style/$s/openlock/base.$style.$s.$basis.${x}x${y}.openlock-binary.stl $basis/$style/$s/openlock/base.$style.$s.$basis.${x}x${y}.openlock.stl
#
#					mkdir -p $basis/$style/$s/openlock.triplex/
#					$OPENSCAD -o $basis/$style/$s/openlock.triplex/base.$style.$s.$basis.${x}x${y}.openlock.triplex.stl \
#						-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\"" \
#						-D "shape=\"$s\"" \
#						-D "style=\"${style}\"" \
#						-D "topless=\"false\"" \
#						-D "lock=\"triplex\"" -D "magnet_hole=0" -D "priority=\"lock\"" bases.scad
#					$CONVERTSTL $basis/$style/$s/openlock.triplex/base.$style.$s.$basis.${x}x${y}.openlock.triplex.stl
#					mv $basis/$style/$s/openlock.triplex/base.$style.$s.$basis.${x}x${y}.openlock.triplex-binary.stl $basis/$style/$s/openlock.triplex/base.$style.$s.$basis.${x}x${y}.openlock.triplex.stl

#					if [ "$basis" = "inch" ]; then
#						##
#						## infinitylock
#						##
#						mkdir -p $basis/$style/$s/infinitylock/
#						$OPENSCAD -o $basis/$style/$s/infinitylock/base.$style.$s.$basis.${x}x${y}.infinitylock.stl \
#							-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\"" \
#							-D "shape=\"$s\"" \
#							-D "style=\"${style}\"" \
#							-D "topless=\"false\"" \
#							-D "lock=\"infinitylock\"" -D "magnet_hole=0" -D "priority=\"lock\"" bases.scad
#						$CONVERTSTL $basis/$style/$s/infinitylock/base.$style.$s.$basis.${x}x${y}.infinitylock.stl
#						mv $basis/$style/$s/infinitylock/base.$style.$s.$basis.${x}x${y}.infinitylock-binary.stl $basis/$style/$s/infinitylock/base.$style.$s.$basis.${x}x${y}.infinitylock.stl
#
#						##
#						## magnetic.infinitylock
#						##
#						mkdir -p $basis/$style/$s/magnetic.infinitylock/
#						$OPENSCAD -o $basis/$style/$s/magnetic.infinitylock/base.$style.$s.$basis.${x}x${y}.magnetic.infinitylock.stl \
#							-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\"" \
#							-D "shape=\"$s\"" \
#							-D "style=\"${style}\"" \
#							-D "topless=\"false\"" \
#							-D "lock=\"infinitylock\"" -D "magnet_hole=6" -D "priority=\"magnets\"" bases.scad
#						$CONVERTSTL $basis/$style/$s/magnetic.infinitylock/base.$style.$s.$basis.${x}x${y}.magnetic.infinitylock.stl
#						mv $basis/$style/$s/magnetic.infinitylock/base.$style.$s.$basis.${x}x${y}.magnetic.infinitylock-binary.stl $basis/$style/$s/magnetic.infinitylock/base.$style.$s.$basis.${x}x${y}.magnetic.infinitylock.stl
#					fi
				done
			done
		done
	done
done

##
## Dragonlock
##

#for style in "${style[@]}"
#do
#	for basis in "${square_basis[@]}"
#	do
#		for s in "${shape[@]}"
#		do
#			for x in "${dragonlocksize[@]}"
#			do
#				for y in "${dragonlocksize[@]}"
#				do
#					if [ "$basis" = "inch" ]; then
#						mkdir -p $basis/$style/$s/dragonlock/
#						$OPENSCAD -o $basis/$style/$s/dragonlock/base.$style.$s.$basis.${x}x${y}.dragonlock.stl \
#							-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\"" \
#							-D "shape=\"$s\"" \
#							-D "style=\"${style}\"" \
#							-D "topless=\"false\"" \
#							-D "lock=\"dragonlock\"" -D "magnet_hole=0" -D "priority=\"lock\"" bases.scad
#						$CONVERTSTL $basis/$style/$s/dragonlock/base.$style.$s.$basis.${x}x${y}.dragonlock.stl
#						mv $basis/$style/$s/dragonlock/base.$style.$s.$basis.${x}x${y}.dragonlock-binary.stl $basis/$style/$s/dragonlock/base.$style.$s.$basis.${x}x${y}.dragonlock.stl
#
#						mkdir -p $basis/$style/$s/magnetic.dragonlock/
#						$OPENSCAD -o $basis/$style/$s/magnetic.dragonlock/base.$style.$s.$basis.${x}x${y}.magnetic.dragonlock.stl \
#							-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\"" \
#							-D "shape=\"$s\"" \
#							-D "style=\"${style}\"" \
#							-D "topless=\"false\"" \
#							-D "lock=\"dragonlock\"" -D "magnet_hole=6" -D "priority=\"magnetic\"" bases.scad
#						$CONVERTSTL $basis/$style/$s/magnetic.dragonlock/base.$style.$s.$basis.${x}x${y}.magnetic.dragonlock.stl
#						mv $basis/$style/$s/magnetic.dragonlock/base.$style.$s.$basis.${x}x${y}.magnetic.dragonlock-binary.stl $basis/$style/$s/magnetic.dragonlock/base.$style.$s.$basis.${x}x${y}.magnetic.dragonlock.stl
#					fi
#				done
#			done
#		done
#	done
#done


##
## Large Curved Sizes
##

for style in "${style[@]}"
do
	for basis in "${square_basis[@]}"
	do
		for tile in "${largecurved[@]}"
		do
			for x in "${largecurvedsize[@]}"
			do
#				echo "$basis.$style.$tile.${x}x${x}"
#				mkdir -p $basis/$style/curved/magnetic/
#				$OPENSCAD -o $basis/$style/curved/magnetic/base.${style}.curved.$basis.${x}x${x}.${tile}.magnetic.stl \
#					-D "x=${x}" -D "y=${x}" -D "square_basis=\"$basis\""\
#					-D "shape=\"curved\"" -D "curvedlarge=\"${tile}\"" \
#					-D "style=\"${style}\"" \
#					-D "topless=\"false\"" \
#					-D "lock=\"none\"" -D "magnet_hole=6"  bases.scad
#				$CONVERTSTL $basis/$style/curved/magnetic/base.${style}.curved.$basis.${x}x${x}.${tile}.magnetic.stl
#				mv $basis/$style/curved/magnetic/base.${style}.curved.$basis.${x}x${x}.${tile}.magnetic-binary.stl $basis/$style/curved/magnetic/base.${style}.curved.$basis.${x}x${x}.${tile}.magnetic.stl
#
#				mkdir -p $basis/$style/curved/magnetic.openlock/
#				$OPENSCAD -o $basis/$style/curved/magnetic.openlock/base.${style}.curved.$basis.${x}x${x}.${tile}.magnetic.openlock.stl \
#					-D "x=${x}" -D "y=${x}" -D "square_basis=\"$basis\"" \
#					-D "shape=\"curved\"" -D "curvedlarge=\"${tile}\"" \
#					-D "style=\"${style}\"" \
#					-D "topless=\"false\"" \
#					-D "lock=\"openlock\"" -D "magnet_hole=6" -D 'priority="magnets"' bases.scad
#				$CONVERTSTL $basis/$style/curved/magnetic.openlock/base.${style}.curved.$basis.${x}x${x}.${tile}.magnetic.openlock.stl
#				mv $basis/$style/curved/magnetic.openlock/base.${style}.curved.$basis.${x}x${x}.${tile}.magnetic.openlock-binary.stl $basis/$style/curved/magnetic.openlock/base.${style}.curved.$basis.${x}x${y}.${tile}.magnetic.openlock.stl
#
				mkdir -p $basis/$style/curved/magnetic.openlock.topless/
				$OPENSCAD -o $basis/$style/curved/magnetic.openlock.topless/base.${style}.curved.$basis.${x}x${x}.${tile}.magnetic.openlock.topless.stl \
					-D "x=${x}" -D "y=${x}" -D "square_basis=\"$basis\"" \
					-D "shape=\"curved\"" -D "curvedlarge=\"${tile}\"" \
					-D "style=\"${style}\"" \
					-D "topless=\"true\"" \
					-D "lock=\"openlock\"" -D "magnet_hole=6" -D 'priority="magnets"' bases.scad
				$CONVERTSTL $basis/$style/curved/magnetic.openlock.topless/base.${style}.curved.$basis.${x}x${x}.${tile}.magnetic.openlock.topless.stl
				mv $basis/$style/curved/magnetic.openlock.topless/base.${style}.curved.$basis.${x}x${x}.${tile}.magnetic.openlock.topless-binary.stl $basis/$style/curved/magnetic.openlock.topless/base.${style}.curved.$basis.${x}x${y}.${tile}.magnetic.openlock.topless.stl
#
#				mkdir -p $basis/$style/curved/openlock/
#				$OPENSCAD -o $basis/$style/curved/openlock/base.${style}.curved.$basis.${x}x${x}.${tile}.openlock.stl \
#					-D "x=${x}" -D "y=${x}" -D "square_basis=\"$basis\"" \
#					-D "shape=\"curved\"" -D "curvedlarge=\"${tile}\"" \
#					-D "style=\"${style}\"" \
#					-D "topless=\"false\"" \
#					-D "lock=\"openlock\"" -D "magnet_hole=0" bases.scad
#				$CONVERTSTL $basis/$style/curved/openlock/base.${style}.curved.$basis.${x}x${x}.${tile}.openlock.stl
#				mv $basis/$style/curved/openlock/base.${style}.curved.$basis.${x}x${x}.${tile}.openlock-binary.stl $basis/$style/curved/openlock/base.${style}.curved.$basis.${x}x${x}.${tile}.openlock.stl
#
#				mkdir -p $basis/$style/curved/openlock.triplex/
#				$OPENSCAD -o $basis/$style/curved/openlock.triplex/base.${style}.curved.$basis.${x}x${x}.${tile}.openlock.triplex.stl \
#					-D "x=${x}" -D "y=${x}" -D "square_basis=\"$basis\"" \
#					-D "shape=\"curved\"" -D "curvedlarge=\"${tile}\"" \
#					-D "style=\"${style}\"" \
#					-D "topless=\"false\"" \
#					-D "lock=\"triplex\"" -D "magnet_hole=0" bases.scad
#				$CONVERTSTL $basis/$style/curved/openlock.triplex/base.${style}.curved.$basis.${x}x${x}.${tile}.openlock.triplex.stl
#				mv $basis/$style/curved/openlock.triplex/base.${style}.curved.$basis.${x}x${x}.${tile}.openlock.triplex-binary.stl $basis/$style/curved/openlock.triplex/base.${style}.curved.$basis.${x}x${x}.${tile}.openlock.triplex.stl
#
#				if [ "$basis" = "inch" ]; then
#					mkdir -p $basis/$style/curved/magnetic.infinitylock/
#					$OPENSCAD -o $basis/$style/curved/magnetic.infinitylock/base.${style}.curved.$basis.${x}x${x}.${tile}.magnetic.infinitylock.stl \
#						-D "x=${x}" -D "y=${x}" -D "square_basis=\"$basis\"" \
#						-D "shape=\"curved\"" -D "curvedlarge=\"${tile}\"" \
#						-D "style=\"${style}\"" \
#						-D "topless=\"false\"" \
#						-D "lock=\"infinitylock\"" -D "magnet_hole=6" -D 'priority="magnets"' bases.scad
#					$CONVERTSTL $basis/$style/curved/magnetic.infinitylock/base.${style}.curved.$basis.${x}x${x}.${tile}.magnetic.infinitylock.stl
#					mv $basis/$style/curved/magnetic.infinitylock/base.${style}.curved.$basis.${x}x${x}.${tile}.magnetic.infinitylock-binary.stl $basis/$style/curved/magnetic.infinitylock/base.${style}.curved.$basis.${x}x${y}.${tile}.magnetic.infinitylock.stl
#
#					mkdir -p $basis/$style/curved/infinitylock/
#					$OPENSCAD -o $basis/$style/curved/infinitylock/base.${style}.curved.$basis.${x}x${x}.${tile}.infinitylock.stl \
#						-D "x=${x}" -D "y=${x}" -D "square_basis=\"$basis\"" \
#						-D "shape=\"curved\"" -D "curvedlarge=\"${tile}\"" \
#						-D "style=\"${style}\"" \
#						-D "topless=\"false\"" \
#						-D "lock=\"infinitylock\"" -D "magnet_hole=0" bases.scad
#					$CONVERTSTL $basis/$style/curved/infinitylock/base.${style}.curved.$basis.${x}x${x}.${tile}.infinitylock.stl
#					mv $basis/$style/curved/infinitylock/base.${style}.curved.$basis.${x}x${x}.${tile}.infinitylock-binary.stl $basis/$style/curved/infinitylock/base.${style}.curved.$basis.${x}x${x}.${tile}.infinitylock.stl
#				fi
			done
		done
	done
done
