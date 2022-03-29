#!/bin/sh

#SBATCH --job-name=PYTHON                      # Job name
#SBATCH --nodes=1                              # Run all processes on 2 nodes  
#SBATCH --partition=cpulongb                   # Partition OGBON
#SBATCH --output=out_%j.log                    # Standard output and error log
#SBATCH --ntasks-per-node=1                    # 1 job per node
#SBATCH --account=cenpes-lde                   # Account of the group 

module load python/3.8.2

python3 --version
echo "Running..."
python3 test.py 
echo "Finished sbatch!"
