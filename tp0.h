	#ifndef TP0_H_
	#define TP0_H_
	#define _GNU_SOURCE
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <unistd.h>
	#include <stdbool.h>


	#define SIZE_MAT 50

	typedef struct matrix {
        size_t rows;
        size_t cols;
        double* array;
    } matrix_t;

	// Constructor de matrix_t
	matrix_t* create_matrix(size_t rows, size_t cols);

	// Destructor de matrix_t
    void destroy_matrix(matrix_t* m);

    // Imprime matrix_t sobre el file pointer fp en el formato solicitado
    // por el enunciado
    int print_matrix(FILE* fp, matrix_t* m);

    // Multiplica las matrices en m1 y m2
    matrix_t* matrix_multiply(matrix_t* m1, matrix_t* m2);

	void printHelp();

	void printLinea(int fil, int col, double* matrix);

	void finally(double* m1,double* m2,double* out);

	double* leerMatriz(int* fil, int* col);

	int  checkArguments(int,char*[]);

	extern void multiplicarMatrices(int f1, int c1, int f2, int c2, double* m1, double* m2, double* out);

	//void multiplicarMatrices(int f1, int c1, int f2, int c2, double* m1, double* m2, double* out);

	/* Devuelve el primer elemento del archivo a leer, es decir la dimension*/
	int leerDimensionMatriz();

    void leerMatrices(int dimension, matrix_t matriz1, matrix_t matriz2);

	#endif /* TP0_H_ */
