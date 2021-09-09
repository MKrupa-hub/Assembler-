all: lab1

lab1: lab1.o
	ld lab1.o -o lab1
lab1.o: lab1.s
	as lab1.s -o lab1.o
clean:
	rm lab1.o lab1