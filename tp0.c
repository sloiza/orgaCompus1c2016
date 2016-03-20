#include "tp0.h"

void printHelp() {
	char *help = "Usage:"
			"\t ./tp0 -h \n"
			"\t ./tp0 -V \n"
			"\t ./tp0 < in_file > out_file \n"
			"Options: \n"
			" -V, --version \n\t Print version and quit. \n"
			" -h, --help \n\t Print this information and quit.\n"
			" Examples: \n"
			"  ./tp0 < in.txt > out.txt \n"
			"  cat in.txt | ./tp0 > out.txt \n";

	printf("%s", help);
}


// Devuelve mensaje de ayuda si el segundo argumento es -h o --help y
// la version si es -V, -v o --version. En cualquier otro caso devuelve 1.
int checkArguments(int cantidadArgumentos, char* argumentos[]) {
	int retorno = 1;
	if ((cantidadArgumentos == 2)
			&& ((strcmp(argumentos[1], "-h") == 0)
					|| (strcmp(argumentos[1], "--help") == 0))) {
		printHelp();
		retorno = 0;
	} else if ((cantidadArgumentos == 2)
			&& (((strcmp(argumentos[1], "-V") == 0))
					|| (strcmp(argumentos[1], "--version") == 0) || (strcmp(argumentos[1], "-v") == 0))) {
		printf("Version 1.0\n");
		retorno = 0;
	}

	return retorno;
}


// Lee el primer elemento del stdin que corresponde a la dimension de la matriz cuadrada
int leerDimensionMatriz(){

    int dimension = 0;
    if(( fscanf(stdin, "%d", &dimension)==1) && !feof(stdin)){
            printf("dimension de la matriz cuadrada: %d\n", dimension);
            // TODO, manejo de errores
    }
    return dimension;
}


// Constructor de matrix_t
matrix_t* create_matrix(size_t filas, size_t columnas){

    matrix_t* matriz;
    matriz = malloc(sizeof(matrix_t));
    (*matriz).array = malloc(sizeof(double)*filas*columnas);
    (*matriz).rows = filas;
    (*matriz).cols = columnas;

    return matriz;
}


void leerMatrices(int dimension, matrix_t* matriz1, matrix_t* matriz2){

	double* arrayNumeros = NULL; // array que contendra todos los elementos de ambas matrices
	double value = 0.0; // elemento corriente de la iteracion
	int cantNums = 0;

	// Si no se alcanzo el fin del archivo
	if(!feof(stdin)){
		if (ferror (stdin)){
			printf ("Error reading stdin\n");
			if(arrayNumeros!=NULL){
				free(arrayNumeros);
				arrayNumeros = NULL;
			}
			exit(EXIT_FAILURE);
		}

		//cantidad de numeros == 2x(NxN) (lee dos matrices)
        cantNums = (dimension*dimension)*2;
		arrayNumeros = (double*) malloc(sizeof(double)*cantNums);
		if(arrayNumeros == NULL){
			fprintf(stderr, "Error malloc \n");
		}

		for(int j = 0;j<cantNums; j++){
			if(fscanf(stdin, "%lf", &value) ==1){
                printf("iteracion: %d\n",j);
				if (ferror (stdin)){
					printf ("Error reading stdin\n");
					if(arrayNumeros!=NULL){
						free(arrayNumeros);
						arrayNumeros = NULL;
					}
					exit(EXIT_FAILURE);
				}
				printf("elemento: %lf \n", value);
				arrayNumeros[j] = value;
			}else{
				fprintf(stderr, "Matriz inválida \n" );
				if(arrayNumeros!=NULL){
					free(arrayNumeros);
					arrayNumeros = NULL;
				}
				exit(EXIT_FAILURE);
			}
		}
	}else{
		if(arrayNumeros!=NULL){
			free(arrayNumeros);
			arrayNumeros = NULL;
		}
		exit(EXIT_FAILURE);
	}

    for(int j = 0; j<cantNums; j++){
        if(j>=cantNums/2){
            (*matriz2).array[j-(cantNums/2)] = arrayNumeros[j];
        }
        (*matriz1).array[j] = arrayNumeros[j];
    }

    for(int i = 0; i < cantNums/2; i++){
        printf("matriz 1: elemento %d, valor: %lf \n",i, (*matriz1).array[i]);
    }

    for(int i = 0; i < cantNums/2; i++){
        printf("matriz 2: elemento %d, valor: %lf \n",i, (*matriz2).array[i]);
    }
}


// Multiplica las matrices en m1 y m2
matrix_t* matrix_multiply(matrix_t* m1, matrix_t* m2){

    int dimension = (*m1).rows;
    matrix_t* matrizResultado = create_matrix(dimension,dimension);
    int i, j, k;

    printf("#filas m1 : %d \n", (*m1).rows);
    printf("#cols m1 : %d \n", (*m1).cols);
    printf("#filas m2 : %d \n", (*m2).rows);
    printf("#cols m2 : %d \n", (*m2).cols);

    // Multiplicacion m1 * m2
    for (i = 0; i < dimension; i++){
        for (j = 0; j < dimension; j++){
            // elemento Cij
            (*matrizResultado).array[j + i * dimension] = 0; // inicializa a 0 acumulador de Cij
            for(k = 0; k < dimension; k++){
                (*matrizResultado).array[j + i * dimension] += (*m1).array[k + i * dimension] * (*m2).array[j + k * dimension];
            }
        }
    }

    printf("matriz resultado: \n");
    for (i = 0; i < dimension * dimension; i++) printf("[%d] = %lf\n", i, (*matrizResultado).array[i]);

    return matrizResultado;
}

// Destructor de matrix_t
void destroy_matrix(matrix_t* matriz){
    if(matriz != NULL){
		free(matriz);
		matriz = NULL;
	}
}


// Imprime matrix_t sobre el file pointer fp en el formato solicitado
// por el enunciado
int print_matrix(FILE* fp, matrix_t* m){
    // TODO
    return 0;

}


// argc == argument count, argv== argument vector
 int main(int argc, char *argv[]) {

	if (!checkArguments(argc,argv)){
		return 1; // Error en los argumentos
	}else{
		do{
            int dimension = leerDimensionMatriz();
            matrix_t* matriz2 = create_matrix(dimension,dimension);
            matrix_t* matriz1 = create_matrix(dimension,dimension);

            // Lee el par de matrices de una linea del stdin
            leerMatrices(dimension, matriz1, matriz2);

            matrix_multiply(matriz1, matriz2);

            //Borra las matrices creadas
            destroy_matrix(matriz1);
            destroy_matrix(matriz2);

		}while(!feof(stdin));
	}
	return 0;
}

