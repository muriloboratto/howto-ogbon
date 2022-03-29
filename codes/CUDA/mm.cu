/*%****************************************************************************80
%  Code: 
%   mm.cu
%
%  Purpose:
%   Parallel code matrix multiply in C 
%   with CUDA
%
%  Modified:
%   Jan 16 2022 13:15 
%
%  Author:
%    Murilo Do Carmo Boratto [murilo.boratto 'at' fieb.org.br]
%
%  How to Compile:
%    nvcc mm.c -o object
%
%  How to Execute: 
%    ./mm <size> <blocksize>
%    ./mm   16       2
%    
%****************************************************************************80*/

#include <stdio.h>
#include <cuda.h>

__global__ void kernel(int *A, int *B, int *C, int n) {
  
int i = blockIdx.x * blockDim.x + threadIdx.x;
int j = blockIdx.y * blockDim.y + threadIdx.y;

if(i < n && j < n)
    for( int k = 0; k < n; k++) 
       C[i*n+j]+=A[i*n+k]*B[k*n+j];

}
 

void mult_matrix_cpu(int *A, int *B, int *C, int n) {

 for(int i = 0; i < n; i++) 
     for(int j = 0; j < n; j++)
        for(int k = 0; k < n; k++) 
           C[i*n+j]+=A[i*n+k]*B[k*n+j];
        
}

void initialize_matrix(int *A, int n){
 
  for(int i=0; i < n; i++)
    for(int j=0; j < n; j++)
       A[i*n+j] = rand()%(10-1)*1;
   
}


void print_matrix(int *A, int n){

  for(int i = 0; i < n; i++){
    for(int j = 0; j < n; j++)
      printf("%d\t", A[i*n+j]);
    printf("\n");
  }

 printf("\n");

}


int main(int argc, char **argv){

    int n = atoi(argv[1]);
    int blocksize = atoi(argv[2]);

    int *A_host=(int *) malloc (n*n*sizeof(int));
    int *B_host=(int *) malloc (n*n*sizeof(int));
    int *C_host=(int *) malloc (n*n*sizeof(int));
        
    initialize_matrix(A_host,n);
    initialize_matrix(B_host,n);
      
    print_matrix(A_host,n);
    print_matrix(B_host,n);

    int *A_device;
    int *B_device;
    int *C_device;
	
    cudaMalloc( (void**)&A_device, n*n*sizeof(int) ); 
    cudaMalloc( (void**)&B_device, n*n*sizeof(int) ); 
    cudaMalloc( (void**)&C_device, n*n*sizeof(int) ); 
	
    cudaMemcpy( A_device, A_host, n*n*sizeof(int), cudaMemcpyHostToDevice ); 
    cudaMemcpy( B_device, B_host, n*n*sizeof(int), cudaMemcpyHostToDevice ); 
	
    /*(GRID: 2D BLOCK: 2D) */
    dim3 dimGrid ( (int) ceil( (float) n / blocksize), (int) ceil( (float)n / blocksize) );
    dim3 dimBlock( blocksize, blocksize);  

    kernel<<< dimGrid,dimBlock >>>(A_device, B_device, C_device, n);        

    cudaMemcpy( C_host, C_device, n*n*sizeof(int), cudaMemcpyDeviceToHost ); 

    print_matrix( C_host, n );

    cudaFree( A_device );
    cudaFree( B_device );
    cudaFree( C_device );

    free( A_host );
    free( B_host );
    free( C_host );
    
    return 0;

}

