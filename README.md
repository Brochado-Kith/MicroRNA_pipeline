# MicroRNA_pipeline
This is a pipeline for microRNA extraction from raw sequences

There are 3 scripts in this repository.

[cutadapt.sh](https://github.com/Brochado-Kith/MicroRNA_pipeline/blob/main/scripts/cutadapt.sh) is for trimming your sequences.

[mapping.sh](https://github.com/Brochado-Kith/MicroRNA_pipeline/blob/main/scripts/mapping.sh) is for mapping your sequences against your reference genome.

[quantify](https://github.com/Brochado-Kith/MicroRNA_pipeline/blob/main/scripts/quantify.sh) is for extracting the count matrix of thos mirnas in your sequences. The resulting file will be named as miRNAs_expressed_all_samples_.....CSV

These scripts are for HPC cluster work (SLURM). So, if you are usin HPC cluster you will have to change the partition you use and probably the conditions (nodes,ntask,...).

If you are not using HPC cluster, I recommend you to delete all the lines that start with "#SBATCH" and those with module load.
