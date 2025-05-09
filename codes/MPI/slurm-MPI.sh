#!/bin/sh

#SBATCH --job-name=MPI                         # Job name
#SBATCH --nodes=2                              # Run all processes on 2 nodes  
#SBATCH --partition=cpulongb                   # Partition OGBON
#SBATCH --output=out_%j.log                    # Standard output and error log
#SBATCH --ntasks-per-node=1                    # 1 job per node
#SBATCH --account=cenpes-lde                   # Account of the group 

module load openmpi/4.1.1-cuda-11.6-ofed-5.4

mpirun -np 2 ./ping-pong-MPI
