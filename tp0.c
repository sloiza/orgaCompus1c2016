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
        if (ferror (stdin)){
			printf ("Error reading stdin\n");
			exit(EXIT_FAILURE);
		}
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
// Carga la matrix previamente creada con floats de la matrix
matrix_t* readMatrix(matrix_t* matrix){
	double value = 0.0;
	int cantNums;

	cantNums = (*matrix).rows * (*matrix).rows;
	//m = (double*) malloc(sizeof(double)*cantNums);
	if(matrix == NULL){
		fprintf(stderr, "Error malloc \n");
	}

	for(int j =0;j<cantNums; j++){
		if(fscanf(stdin, "%lf", &value) ==1){
			if (ferror (stdin)){
				printf ("Error reading stdin\n");
				if(matrix!=NULL){
					free((*matrix).array);
					free(matrix);
					matrix = NULL;
				}
				exit(EXIT_FAILURE);
			}
			printf("Float leido %lf \n", value);
			(*matrix).array[j] = value;
		}else{
			fprintf(stderr, "Matriz inválida \n" );
			if(matrix!=NULL){
				free((*matrix).array);
				free(matrix);
				matrix = NULL;
			}
			exit(EXIT_FAILURE);
		}

	}
	return matrix;
}

// Multiplica las matrices en m1 y m2
matrix_t* matrix_multiply(matrix_t* m1, matrix_t* m2){

    int dimension = (*m1).rows;
    matrix_t* matrizResultado = create_matrix(dimension,dimension);
  	int pos = 0;
 	int i,j,k, m;

 	for( i =0 ; i < dimension*dimension; i=i+dimension){
 		for(k=0; k < dimension ; k++){
 			double sum = 0.0;
 			m = i;
 			// printf("Entro for de K con k = %d\n",k );
 			for(j=k; j < dimension*dimension; j=j+dimension){
 				sum+= (*m1).array[m]*(*m2).array[j];
 				m++;
 			}
 			(*matrizResultado).array[pos] = sum;
 			pos++;
 		}
 	}
    return matrizResultado;
}

// Destructor de matrix_t
void destroy_matrix(matrix_t* matriz){
    if(matriz != NULL){
    	free((*matriz).array);
		free(matriz);
		matriz = NULL;
	}
}


// Imprime matrix_t
int print_matrix( matrix_t* matrix){
	int dim = (*matrix).rows;
	printf("%d ", dim);
	if (ferror(stdout)){
		fprintf(stderr, "Error printing stdout\n");
		destroy_matrix(matrix);
		exit(EXIT_FAILURE);
	}
	for(int i=0;i<dim*dim;i++){
		printf(" %lf",(*matrix).array[i]);
		if (ferror(stdout)){
			fprintf(stderr, "Error printing stdout\n");
			destroy_matrix(matrix);
			exit(EXIT_FAILURE);
		}
	}
	printf("\n");
	if (ferror(stdout)){
		fprintf(stderr, "Error printing stdout\n");
		destroy_matrix(matrix);
		exit(EXIT_FAILURE);
	}
	return 0;
}


// argc == argument count, argv== argument vector
 int main(int argc, char *argv[]) {

	if (!checkArguments(argc,argv)){
		return 1; // Error en los argumentos
	}else{
		do{
            int dimension = leerDimensionMatriz();
            if(feof(stdin)){
                return 0;
            }
            if(dimension > 0){
	            matrix_t* matrix1 = create_matrix(dimension,dimension);
	            matrix1 = readMatrix(matrix1);
	            matrix_t* matrix2 = create_matrix(dimension,dimension);
	            matrix2 = readMatrix(matrix2);
	            printf("Matrix 1 \n");
                for (int i = 0; i < dimension * dimension; i++) printf("[%d] = %lf\n", i, (*matrix1).array[i]);

				printf("Matrix 2 \n");
				for (int i = 0; i < dimension * dimension; i++) printf("[%d] = %lf\n", i, (*matrix2).array[i]);

	            matrix_t* matrizResultado = matrix_multiply(matrix1, matrix2);

	            print_matrix(matrizResultado);

	            //Borra las matrices creadas
	            destroy_matrix(matrix1);
	            destroy_matrix(matrix2);
	            destroy_matrix(matrizResultado);
            }else{
            	fprintf(stderr, "Error: Matriz inválida para multiplicación \n");
            	exit(EXIT_FAILURE);
            }

		}while(!feof(stdin));
	}
	return 0;
}

