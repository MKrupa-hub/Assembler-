all: lab3

lab3: lab3.o
	ld lab3.o -o lab3
lab3.o: lab3.s
	as lab3.s -o lab3.o
clean:
	rm lab3.o lab3
