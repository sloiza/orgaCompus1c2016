CFLAGS= -Wall -g  -std=c99
CC=gcc

all: tp0

tp0: tp0.c tp0.h
	$(CC) $(CFLAGS) tp0.h tp0.c -o tp0
clean: 
	rm tp0

