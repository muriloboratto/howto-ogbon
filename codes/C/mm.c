#include <stdio.h>
#include <stdlib.h>

void inicializa_matrix(int *A, int n){

  int i,j;
 
  for (i=0; i < n; i++)
    for (j=0; j < n; j++)
      A[i*n+j] = rand()%(10-1)*1;
  
}


void imprime_matrix(int *A, int n){

  int i,j;

  for(i=0; i < n; i++){
    for(j=0; j < n; j++)
      printf("%d\t", A[i*n+j]);
    printf("\n");
  }

  printf("\n");

}

int main(int argc, char **argv){

 int n = atoi(argv[1]);  
 int i,j,k;

 int  *A = (int *) malloc (sizeof(int)*n*n);
 int  *B = (int *) malloc (sizeof(int)*n*n);
 int  *C = (int *) malloc (sizeof(int)*n*n);

 inicializa_matrix(A,n);
 inicializa_matrix(B,n);

 for(i = 0; i < n; i++) 
  for(j = 0; j < n; j++)
    for( k = 0; k < n; k++) 
      C[i*n+j]+=A[i*n+k]*B[k*n+j];

 imprime_matrix(A,n);
 imprime_matrix(B,n);
 imprime_matrix(C,n);

 free(A);
 free(B);
 free(C);
  
 return 0;

}

