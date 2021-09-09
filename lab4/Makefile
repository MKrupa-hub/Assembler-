all: bmphide

bmphide: bmphide.c hmsg.s rmsg.s
	gcc -m32 hmsg.s rmsg.s bmphide.c -o bmphide

clean:
	rm bmphide
