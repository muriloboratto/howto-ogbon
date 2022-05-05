# Howto Ogbon Environment

The aim of this recipes is learn how to use the execution queue on Ogbon Environment.
A practical example to see how it can be used and to see a real example of submit jobs.
The results are impressive for the effort and performance on the supercomputacional environment.

----
## How to connect with ssh?

> ~$ ssh -p 5001 -CXY -o ServerAliveInterval=40 murilo@ogbon-login8.fieb.org.br

Please refer to create a alias for connect with OGBON, see  [Simplifying SSH] for an way to reduce the complexity of this
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
## How to  get information about the partitions?

> ~$ sinfo

----

## How to  get information about the SLURM queue?

> ~$ squeue

----

## How to visualize and start the modules/APIs?

> ~$ module avail

> ~$ module load gcc/11.1.0

> ~$ module list



----

 ## How to know my personal account (group of execution) on Ogbon?

> ~$ groups
> ~$ murilo nec projetos cenpes-lde


----

 ## How to alloc/disalloc a node on Ogbon?

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

## How to  submit a job in SLURM??

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

## How to make scp?

### localhost --> ogbon

> ~$ scp -P 5001 -r /Users/muriloboratto/Documents/github/howto-ogun/ murilo@ogbon-login8.fieb.org.br:/home/murilo/

### ogbon  --> localhost

> ~$ scp -P 5001  -r murilo@ogbon-login8.fieb.org.br:/home/murilo/cap-hpc/ .


----

## It is possible make a git clone on Ogbon?

### 1) Only in front-end login8

### 2) You must associated you 'SSH keys' with your GitHub account. How?

Click your profile photo in GitHub > Settings  > SSH and GPG keys > Add SSH key

----

## It is possible use the jupyter lab on Ogbon?

### 1) Connect set the jupyter port

> ~$ ssh -p 5001 -CXY -o ServerAliveInterval=40 murilo@ogbon-login8.fieb.org.br -L 8559:\*:8559


### 2) Initialize the Anaconda API

> ~$ module load anaconda3/2020.07


### 3) After start the jupyter lab, cut and past the link in the browser

> ~$ jupyter lab --port=8559

----

## How to use the Docker Containner on Ogbon?

### Search the package in docker page:

> ~$ https://hub.docker.com/search?q=speglich

### Download the package with singularity pull:

> ~$ singularity pull docker://speglich/cimatec-base

### Execute the package with singularity exec:

> ~$ singularity exec --nv docker://speglich/cimatec-base bash
