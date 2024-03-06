#!/bin/bash
#SBATCH --job-name="quantify"
#SBATCH --chdir=.
#SBATCH --partition=short_obx
#SBATCH --nodes=4
#SBATCH --ntasks=8
#SBATCH --output=quantifier_%j.out
#SBATCH --error=quantifier_%j.err

module load  mirdeep2/0.1.3

# This is your main folder
BASE_DIR=/data/obk/microRNAs

# This is where your mapping data is
MAPPED_DIR=$BASE_DIR/mapped

# This is where your microRNA reference database is (e.g. Mirbase)
MICRORNA_DB_DIR=$BASE_DIR/genome

quantifier.pl -d -p $MICRORNA_DB_DIR/hairpin.fa -m $MICRORNA_DB_DIR/mature.fa -r $MAPPED_DIR/reads.fa -t hsa
