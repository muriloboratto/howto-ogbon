#!/bin/sh

#SBATCH --job-name=CUDA                        # Job name
#SBATCH --nodes=1                              # Run all processes on 2 nodes  
#SBATCH --partition=gpulongb                   # Partition OGUN
#SBATCH --output=out_%j.log                    # Standard output and error log
#SBATCH --ntasks-per-node=1                    # 1 job per node
#SBATCH --account=cenpes-lde                   # Account of the group 

module load cuda/10.1 

./mm 3200 64
