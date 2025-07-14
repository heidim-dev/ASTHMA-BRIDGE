#!/bin/bash

#SBATCH -J info_parser
#SBATCH -p bch-compute
#SBATCH -c 1 
#SBATCH -t 0-24:00
#SBATCH --mem 12G 
#SBATCH -o slurm_output/info_parsing_%A_%a.out
#SBATCH -e slurm_output/info_parsing_%A_%a.err
#SBATCH --array=1-22  # Size of the array


# Run for each cohort of imputed data
# Separates out the info string from the .info.gz file 
WORKDIR=$1

echo $WORKDIR
cd $WORKDIR

if [ $SLURM_ARRAY_TASK_ID -eq 23 ]; then
    CHR="X"
else
    CHR=$SLURM_ARRAY_TASK_ID
fi

echo "Processing chromosome: $CHR"

#For all cohorts besides 610
zcat chr$CHR.info.gz | tail -n +14 | awk '{if($0 ~ /ER2=/) gsub(/;MAF=|;AF=|;AVG_CS=|;R2=|;ER2=/,"\t"); else {gsub(/;MAF=|;AF=|;AVG_CS=|;R2=/,"\t"); $0 = $0 "\t"}; print}' | gzip > chr$CHR.info_parsed.txt.gz



# Only for cohort 610 which has a different order of items in the info column than the other cohorts

rearrange_string() {
    local input_string="$1"
    local arr=(${input_string//;/ })
    local result=""
    for item in "${arr[@]}"; do
        if [[ $item == "TYPED" || $item == "IMPUTED" ]]; then
            result="$item;$result"
        else
            result="$result$item;"
        fi
    done
    result=${result%;}
    echo "$result"
}

# Read from a gzip file
gzip -cd chr$CHR.info.gz | while IFS=$'\t' read -r -a columns; do
    # Apply rearrange_string only to the 8th column
    columns[7]=$(rearrange_string "${columns[7]}")
    # Join the columns back together
    echo "${columns[*]}"
done | tr ' ' '\t' > chr$CHR.info.temp.txt
cat chr$CHR.info.temp.txt | tail -n +14 | awk '{if($0 ~ /ER2=/) gsub(/;MAF=|;AF=|;AVG_CS=|;R2=|;ER2=/,"\t"); else {gsub(/;MAF=|;AF=|;AVG_CS=|;R2=/,"\t"); $0 = $0 "\t"}; print}' | gzip > chr$CHR.info_parsed.txt.gz
rm -f chr$CHR.info.temp.txt
