	#ifndef TP0_H_
	#define TP0_H_
	#define _GNU_SOURCE
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <unistd.h>
	#include <stdbool.h>
	#include <string.h>

	typedef struct matrix {
        size_t rows;
        size_t cols;
        double* array;
    } matrix_t;

    void printHelp();

   	int  checkArguments(int,char*[]);

	// Constructor de matrix_t
	matrix_t* create_matrix(size_t rows, size_t cols);

	// Destructor de matrix_t
    void destroy_matrix(matrix_t* m);

    /* Devuelve el primer elemento del archivo a leer, es decir la dimension*/
	int readMatrixDimension();

	/* Lee matriz de una linea del stdin*/
	matrix_t* readMatrix(matrix_t* matrix);

    // Imprime matrix_t sobre el file pointer fp en el formato solicitado
    // por el enunciado
    int print_matrix(FILE* f, matrix_t* m);

    // Multiplica las matrices en m1 y m2i
    //extern void matrix_multiply(matrix_t* m1, matrix_t* m2, matrix_t* out);
    extern void matrix_multiply(matrix_t* m1, matrix_t* m2, matrix_t* out);

    // Imprime en el archivo indicado por el file descriptor fd, el string C
    // apuntador por str, sin incluir su byte nulo de finalizacion.
    extern ssize_t print_string(int fd, char* str);

	#endif /* TP0_H_ */
