/*%****************************************************************************80
%  Code: 
%   ping-pong-MPI.c
%
%  Purpose:
%   Implements the ping pong between 2 ranks using MPI.
%   The code allocate memory in CPU.
%
%  Modified:
%   Dec 12 2021 10:57 
%
%  Author:
%   olcf-tutorials/MPI_ping_pong
%
%  Modified:
%   Murilo Boratto <murilo.boratto 'at' fieb.org.br>
%
%  HowtoCompile:
%   bash howtocompile.sh
%
%  HowtoExecute: 
%   bash howtoexecute.sh
%
%****************************************************************************80*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <mpi.h>

int main(int argc, char *argv[]){

    int size, rank;

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    MPI_Status status;

    double start_time, stop_time, elapsed_time;
       
    for(int i = 0; i <= 27; i++) {

       long int N = 1 << i; /*Loop from 8 Bytes to 1 GB*/

       double *A = (double*)calloc( N, sizeof(double));  /*Allocate memory for A on CPU*/

       int tag1 = 1000;
       int tag2 = 2000;

       int loop_count = 50;

       /********************************/      
       /**/ start_time = MPI_Wtime();/**/
       /********************************/

       for(int i = 1; i <= loop_count; i++){
            
            if(rank == 0){
                MPI_Send(A, N, MPI_DOUBLE, 1, tag1, MPI_COMM_WORLD);
                MPI_Recv(A, N, MPI_DOUBLE, 1, tag2, MPI_COMM_WORLD, &status);
            }
            else if(rank == 1){
                MPI_Recv(A, N, MPI_DOUBLE, 0, tag1, MPI_COMM_WORLD, &status);
                MPI_Send(A, N, MPI_DOUBLE, 0, tag2, MPI_COMM_WORLD);
            }
        }

       /*********************************/      
       /**/  stop_time = MPI_Wtime(); /**/
       /********************************/      
      
        /*measured*/
        elapsed_time = stop_time - start_time;  
        long int num_B = 8 * N;
        long int B_in_GB = 1 << 30;
        double num_GB = (double)num_B / (double)B_in_GB;
        double avg_time_per_transfer = elapsed_time / (2.0*(double)loop_count);

        if(rank == 0) 
            printf("Transfer size (Bytes): %10li, Transfer Time (seconds): %15.9f, Bandwidth (GB/s): %15.9f\n", 
                   num_B, avg_time_per_transfer, num_GB/avg_time_per_transfer );  

        free(A);
    
    }/*for*/

    MPI_Finalize();

    return 0;

}/*main*/
   