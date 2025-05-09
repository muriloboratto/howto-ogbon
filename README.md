# How to Ogbon Environment

The aim of this recipes is learn how to use the execution queue on Ogbon Environment.
A practical example to see how it can be used and to see a real example of submit jobs.
The results are impressive for the effort and performance on the supercomputacional environment.

----
## `How to connect with ssh?`

> ~$ ssh -p 5001 murilo@ogbon-login8.fieb.org.br

Please refer to create a alias for connect with OGBON, see [Simplifying SSH] for an way to reduce the complexity of this
command.

### Simplifying SSH

By following the steps below you will be able to do just
> ~$ ssh ogbon
and successfully connect to the server.

Create or edit a ~/.ssh/config file

> ~$ mkdir -p ~/.ssh

then create or edit the ~/.ssh/config file, appending the following content:
```
Host ogbon
    HostName ogbon-login8.fieb.org.br
    User murilo
    PreferredAuthentications publickey
    Compression yes
    ServerAliveInterval 40
    ForwardX11 yes
    Port 5001
    IdentityFile ~/.ssh/id_rsa
```
where you should change the name of the User option from murilo to your username. Furthermore, check if your ssh key is really id_rsa, otherwise change it to the correct one.

> ~$ ssh ogbon

----
## `How to  get information about the partitions?`

> ~$ sinfo

----

## `How to  get information about the SLURM queue?`

> ~$ squeue

----

## `How to visualize and start the modules/APIs?`

> ~$ module avail

> ~$ module load gcc/11.1.0

> ~$ module list



----

 ## `How to know my personal account (group of execution) on Ogbon?`

> ~$ groups

> ~$ murilo nec projetos cenpes-lde


----

 ## `How to alloc/disalloc a node on Ogbon?`

To allocate run:
> ~$ salloc -p cpulongb -N 1 -A cenpes-lde

The expected output is something like:
```
salloc: Pending job allocation 528705
salloc: job 528705 queued and waiting for resources
salloc: job 528705 has been allocated resources
salloc: Granted job allocation 528705
salloc: Waiting for resource configuration
salloc: Nodes c153 are ready for job
```

With the node c153 (only an example) properly allocated, ssh into it with the following command:
> ~$ ssh c153


To free up the allocated resources run:
> ~$ scancel -u murilo

----

## `How to  submit a job in SLURM?`

> ~$ sbatch script-slurm.sh

### bash SLURM

```Bash

!/bin/sh

#SBATCH --job-name=MPI                         # Job name
#SBATCH --nodes=2                              # Run all processes on 2 nodes
#SBATCH --partition=cpulongb                   # Partition OGBON
#SBATCH --output=out_%j.log                    # Standard output and error log
#SBATCH --ntasks-per-node=1                    # 1 job per node
#SBATCH --account=cenpes-lde                   # Account of the group

```

----

## `How to make scp on Ogbon?`

### localhost --> ogbon

> ~$ scp -P 5001 -r /Users/muriloboratto/Documents/github/howto-ogbon/ murilo@ogbon-login8.fieb.org.br:/home/murilo/

### ogbon  --> localhost

> ~$ scp -P 5001  -r murilo@ogbon-login8.fieb.org.br:/home/murilo/cap-hpc/ .


----

## `It is possible make a git clone on Ogbon?`

### 1) Only in front-end login8

### 2) You must associated you 'SSH keys' with your GitHub account. How?

Click your profile photo in GitHub > Settings  > SSH and GPG keys > Add SSH key

----

## `It is possible use the jupyter lab on Ogbon in the login node?`

### 1) Connect set the jupyter port

> ~$ ssh -p 5001 -CXY -o ServerAliveInterval=40 murilo@ogbon-login8.fieb.org.br -L 8559:\*:8559


### 2) Initialize the Anaconda API

> ~$ module load anaconda3/2020.07


### 3) After start the jupyter lab, cut and past the link in the browser

> ~$ jupyter lab --port=8559

----

## `It is possible use the jupyter lab on Ogbon in the processing node?`

### 1) Connect set the jupyter port

> ~$ ssh -p 5001 -CXY -o ServerAliveInterval=40 murilo@ogbon-login8.fieb.org.br -L 8559:\*:8559


### 2) How to alloc a node on Ogbon?

To allocate run:
> ~$ salloc -p gpulongb -N 1 -A cenpes-lde

The expected output is something like:
```
salloc: Pending job allocation 528705
salloc: job 528705 queued and waiting for resources
salloc: job 528705 has been allocated resources
salloc: Granted job allocation 528705
salloc: Waiting for resource configuration
salloc: Nodes c003 are ready for job
```
With the node c003 (only an example) properly allocated, ssh into it with the following command:
> ~$ ssh c003 -L 8559:\*:8559


### 3) On the processing node initialize the Anaconda API

> ~$ module load anaconda3/2020.07


### 4) After start the jupyter lab, cut and past the link in the browser

> ~$ jupyter lab --port=8559


----

## `How to use the Docker Containner on Ogbon?`

### Search the package in docker page:

> ~$ https://hub.docker.com/search?q=speglich

### Download the package with singularity pull:

> ~$ singularity pull docker://speglich/cimatec-base

### Execute the package with singularity exec:

> ~$ singularity exec --nv docker://speglich/cimatec-base bash

----

## `How to use NICE DCV?`

### Open the Remote Desktop

Then, read the instructions that follow in the notebook, and connect with NICE DCV on OGBON:

#### 1) Connect in login8 on OGBON

> ~$ ssh -p 5001 user@ogbon-login8.fieb.org.br 

#### 2) Create the Alias

> ~$ alias dcvCreate="dcv create-session profiling"

> ~$ alias dcvList="dcv list-sessions"

> ~$ alias dcvClose="dcv close-session profiling"

#### 3) Create Session in NICE DCV

> ~$ dcvCreate

#### 4) Open the browser and connect in the adress associating the alias session

    https://ogbon-cgpu4.fieb.org.br:8443#profiling

#### 5) Insert the user and password
After clicking the _Connect_ button you will be asked for a password, which is registered in the NOC/CS2I.

----

## `How to use pytorch on Ogbon using environments?`

### First you have to verify all installed envs in the platform

> ~$ module load anaconda3/2023.07

> ~$ conda info --envs

```Bash
[murilo@login8 ~]$ conda info --envs
# conda environments:
#
pytorch-2.x              /home/murilo/.conda/envs/pytorch-2.x
tensorflow-2.x           /home/murilo/.conda/envs/tensorflow-2.x
base                  *  /opt/share/anaconda3/2020.07
llvm12                   /opt/share/anaconda3/2020.07/envs/llvm12
```

### If exist the env just call Pytorch with the command activate

> ~$ source activate pytorch-2.x

### else

1) Create a reference file called `conda-pytorch-env.yaml`:


```Bash
name: pytorch-2.x
channels:
  - pytorch
  - conda-forge
  - nvidia
dependencies:
  - python=3.11
  # Libraries
  - pytorch-cuda=11.8
  - pytorch>=2.0.1
  - numpy
  - pandas
  # Tools
  - ipykernel
  - jupyterlab
  - pip
```

2) Create the env:

> ~$ conda env create --name pytorch-2.x --file conda-pytorch-env.yaml

3) And activate:

> ~$ source activate pytorch-2.x


### and the end, deactivate the env

> ~$ source deactivate

----

## `How to use TensorFlow with Jupyter Notebook on Ogbon using singularity image?`

### Singularity/Apptainer Image (From Docker Image)

```Bash
[murilo@login8 ~]$ ls /public/singularity/tensorflow-2.14-gpu-jupyter.sif
```
### Submit script using SLURM

```Bash
[murilo@login8 ~]$ sbatch /public/singularity/slurm-jupyter-notebook.sh
```

#### Atention 1: Update the PATHS in the file `slurm-jupyter-notebook.sh`;

#### Atention 2: The SLURM generate a file `slurm-notebook-*.log`, with all informations; 

#### Atention 3: Open a new terminal, and copy the direction select by the SLURM: 

```Bash
    ssh -L 9807:c000:8888 murilo@ogbon-cgpu4.senaicimatec.com.br -p 5001
```

#### Atention 4: In the below of the file `slurm-notebook-*.log`, copy the jupyter's weblink, and change the port 8888, for the port select by SLURM, in this case 9807:

```Bash
 http://127.0.0.1:9807/tree?token=f79af719ee03701f0a0cf2f02cc72e8a895800487d595559
```

----



