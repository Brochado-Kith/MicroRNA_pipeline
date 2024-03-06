#!/bin/bash
#SBATCH --job-name="mapping"
#SBATCH --chdir=.
#SBATCH --partition=long_obx
#SBATCH --nodes=8
#SBATCH --ntasks=15
#SBATCH --mem=200G
#SBATCH --output=mapeo_%j.out
#SBATCH --error=mapeo_%j.err

# This is your main folder
BASE_DIR=/data/obk/microRNAs

# This is where your trimmed reads are
INPUT_DIR=$BASE_DIR/trim

# This is where your reference genome is (e.g. human reference genome)
GENOME_DIR=$BASE_DIR/genome

# This is where your mapping results will be stored
OUTPUT_DIR=$BASE_DIR/mapped

for i in $(ls $INPUT_DIR);do gzip -d $INPUT_DIR/$i; done
echo "The files are now unzipped"
# Create samples_file.txt
  # We are using three characters for the sample name from each file
    # sample_study_1aOLM...fastq  the samplename wil be OLM
for i in $(ls $INPUT_DIR);do echo $INPUT_DIR/$i; done > $BASE_DIR/samples_file.txt

ls $INPUT_DIR | cut -d "_" -f 3 | cut -c3-5 > $BASE_DIR/temp_file.txt

paste -d' ' $BASE_DIR/samples_file.txt $BASE_DIR/temp_file.txt > $BASE_DIR/samples_file_ok.txt
rm $BASE_DIR/temp_file.txt $BASE_DIR/samples_file.txt

module load mirdeep2/0.1.3

echo "Samples file is now created"
mapper.pl $BASE_DIR/samples_file_ok.txt -d -h -e -i -j -l 17 -m -p $GENOME_DIR/hsa.GRCh38_mod -s $OUTPUT_DIR/reads.fa -t $OUTPUT_DIR/reads_vs_genome.arf

echo "Mapping finished"
for i in $(ls $INPUT_DIR);do gzip $INPUT_DIR/$i; done
echo "Files gzipped again"
