#!/bin/bash

#SBATCH -J dosage_converter 
#SBATCH -p bch-compute # Partition
#SBATCH -c 1 # one core
#SBATCH -t 0-6:00 # Running time of 6 hours
#SBATCH --mem 32G # Memory request of 32 GB
#SBATCH -o slurm_output/to_plink_dosage_%A_%a.out # Standard output
#SBATCH -e slurm_output/to_plink_dosage_%A_%a.err # Standard error
#SBATCH --array=1-23  # Size of the array

WORKDIR=$1

echo $WORKDIR

cd /lab-share/Pulmonary-Chun-e2/Public/tools/bin

source activate DosageConvertor

# Convert SLURM_ARRAY_TASK_ID to chromosome number
if [ $SLURM_ARRAY_TASK_ID -eq 23 ]; then
    CHR="X"
else
    CHR=$SLURM_ARRAY_TASK_ID
fi

echo "Processing chromosome: $CHR"

# Convert from Michigan imputation server's dosage format to Plink's dosage format
./DosageConvertor --vcfDose $WORKDIR/chr$CHR.dose.vcf.gz --info $WORK_DIR/chr$CHR.info.gz --prefix $WORKDIR/chr$CHR --type plink --format 1

