
CFLAGS= -Wall -g  -std=c99
CC=gcc

all: tp0

tp0: tp0.c tp0.S
	$(CC) $(CFLAGS) tp0.S tp0.c -o tp0
clean: 
	rm tp0

