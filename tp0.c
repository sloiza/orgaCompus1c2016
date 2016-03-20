#include "tp0.h"


// Destructor de matrix_t
void destroy_matrix(matrix_t* m){

}

// Imprime matrix_t sobre el file pointer fp en el formato solicitado
// por el enunciado
int print_matrix(FILE* fp, matrix_t* m){
    return 0;

}

// Multiplica las matrices en m1 y m2
matrix_t* matrix_multiply(matrix_t* m1, matrix_t* m2){
    return 0;

}


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

void printLinea(int fil, int col, double* matrix){
	printf("%dx%d ", fil, col);
	if (ferror(stdout)){
		fprintf(stderr, "Error printing stdout\n");
		free(matrix);
		matrix = NULL;
		exit(EXIT_FAILURE);
	}
	for(int i=0;i<fil*col;i++){
		printf(" %lf",matrix[i]);
		if (ferror(stdout)){
			fprintf(stderr, "Error printing stdout\n");
			free(matrix);
			matrix = NULL;
			exit(EXIT_FAILURE);
		}
	}
	printf("\n");
	if (ferror(stdout)){
		fprintf(stderr, "Error printing stdout\n");
		free(matrix);
		matrix = NULL;
		exit(EXIT_FAILURE);
	}
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

 void multiplicarMatrices(int f1, int c1, int f2, int c2, double* m1, double* m2, double* out) {

  int pos = 0;
 	int i,j,k, m;
 	for( i =0 ; i < f1*c1; i=i+c1){
 		for(k=0; k < c2 ; k++){
 			double sum = 0.0;
 			m = i;
 			// printf("Entro for de K con k = %d\n",k );
 			for(j=k; j < f2*c2; j=j+c2){
 				sum+= m1[m]*m2[j];
 				m++;
 			}
 			out[pos] = sum;
 			pos++;
 		}
 	}
 }

// no se usaria mas
double* leerMatriz(int* fil, int* col ){
	char x;
	double* m = NULL;
	double value = 0.0;
	int cantNums;
	if(( fscanf(stdin, "%d %c %d", fil, &x, col )==3) && !feof(stdin)){
//            printf("primer numero: %d", *fil);
		if (ferror (stdin)){
			printf ("Error reading stdin\n");
			if(m!=NULL){
				free(m);
				m = NULL;
			}
			exit(EXIT_FAILURE);
		}
		cantNums = (*fil) * (*col);
		m = (double*) malloc(sizeof(double)*cantNums);
		if(m == NULL){
			fprintf(stderr, "Error malloc \n");
		}

		for(int j =0;j<cantNums; j++){
			if(fscanf(stdin, "%lf", &value) ==1){
				if (ferror (stdin)){
					printf ("Error reading stdin\n");
					if(m!=NULL){
						free(m);
						m = NULL;
					}
					exit(EXIT_FAILURE);
				}
				m[j] = value;
			}else{
				fprintf(stderr, "Matriz inválida \n" );
				if(m!=NULL){
					free(m);
					m = NULL;
				}
				exit(EXIT_FAILURE);
			}

		}


	}else{
		if(m!=NULL){
			free(m);
			m = NULL;
		}
		exit(EXIT_FAILURE);
	}

	return m;
}

void finally(double* m1,double* m2,double* out){
	if(m1 != NULL){
		free(m1);
		m1 = NULL;
	}
	if(m2 != NULL){
		free(m2);
		m2 = NULL;
	}
	if(out !=NULL){
		free(out);
		out = NULL;
	}
}

// Lee el primer elemento del stdin que corresponde a la dimension de la matriz cuadrada
int leerDimensionMatriz(){
    int dimension = 0;
    if(( fscanf(stdin, "%d", &dimension)==1) && !feof(stdin)){
            printf("dimension de la matriz cuadrada: %d\n", dimension);
    }
    return dimension;
}





// Constructor de matrix_t
matrix_t* create_matrix(size_t filas, size_t columnas){
    matrix_t* matriz;
    matriz = malloc(sizeof(matrix_t));

    (*matriz).rows = filas;
    (*matriz).cols = columnas;

    return matriz;
}


void leerMatrices(int dimension, matrix_t matriz1, matrix_t matriz2){
    double* x;
    x = malloc(sizeof(double)*100);
	double* arrayNumeros = NULL; // array que contendra todos los elementos de ambas matrices
	double value = 0.0; // elemento corriente de la iteracion
	int cantNums;

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
        cantNums = ((int)dimension*(int)dimension)*2;
		arrayNumeros = (double*) malloc(sizeof(double)*cantNums);
		if(arrayNumeros == NULL){
			fprintf(stderr, "Error malloc \n");
		}

		for(int j =0;j<cantNums; j++){
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
//				printf("valor: %lf \n", value);
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

	// TODO, falta partir el arrayNumeros en 2 y asignarle una mitad a matriz1 y la otra a matriz2

}


// argc == argument count, argv== argument vector
 int main(int argc, char *argv[])
{

	if (!checkArguments(argc,argv)){
		return 1; // Error en los argumentos
	}else{
		do{
            int dimension = leerDimensionMatriz();
            matrix_t matriz1 = *create_matrix(dimension,dimension);
            matrix_t matriz2 = *create_matrix(dimension,dimension);
            leerMatrices(dimension, matriz1, matriz2);

            /*
			int fil1 = 0, col1 = 0, fil2 = 0, col2 = 0;
			double* m1 = NULL;
			double* m2 = NULL;
			double* out = NULL;

			m1 = leerMatriz(&fil1, &col1 );
			m2 = leerMatriz(&fil2, &col2 );

			if (col1== fil2){
				out = (double*) malloc(sizeof(double)*fil1*col2);
				if(out == NULL){
					fprintf(stderr, "Error malloc \n");
				}
				multiplicarMatrices(fil1, col1, fil2, col2, m1, m2, out);
				printLinea(fil1, col2, out);


				finally(m1,m2,out);
			}else{
				fprintf(stderr,"Matrices incorrectas para la multiplicacion. \n");
				finally(m1,m2,out);
				exit(EXIT_FAILURE);
			}
			*/
		}while(!feof(stdin));
	}
	return 0;

}

