!/bin/bash
#SBATCH --job-name="cutadapt"
#SBATCH --chdir=.
#SBATCH --partition=middle_obx
#SBATCH --nodes=10
#SBATCH --ntasks=15
#SBATCH --mem=200G
#SBATCH --output=cutadapt_%j.out
#SBATCH --error=cutadapt_%j.err

  # This is where your trimmed reads will be stored
OUTPUT_DIR=/data/cnm/ivi/avb/micros_marathon/trim
  
  # This is where your fastqc of your trimmed and untrimmed reads will be stored
OUTPUT_DIR_FASTQC=/data/cnm/ivi/avb/micros_marathon/fastqc

  # This is where your raw reads will be stored
INPUT_DIR=/data/cnm/ivi/avb/secuencias

  # This is your adapter sequence
ADAPTERS="TGGAATTCTCGG"
  
if [ -d trim ]
then
        echo "directory trim exists"
else
        mkdir -p trim
fi

if [ -d factqc ]
then
        echo "Directory fastqc exists"
else
        mkdir -p fastqc
fi


module load cutadapt/4.0
module load FastQC/0.11.9-Java-11

for i in $(ls $INPUT_DIR | grep ".fastq");do fastqc $INPUT_DIR/$i -o $OUTPUT_DIR_FASTQC;done

for i in $(ls $INPUT_DIR| grep ".fastq");do cutadapt -a $ADAPTERS -o $OUTPUT_DIR/cutted_$i --minimum-length 15 $INPUT_DIR/$i; done

for i in $(ls $OUTPUT_DIR | grep ".fastq");do fastqc $OUTPUT_DIR/$i -o $OUTPUT_DIR_FASTQC;done
