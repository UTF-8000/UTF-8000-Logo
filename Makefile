.PHONY: all
all: images/*.png

%.png: %.svg
	inkscape --export-type=png $<
