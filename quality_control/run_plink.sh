echo ${cohort}
echo $genotype_dir

/local/bin/plink2 --bfile $genotype_dir/${cohort}/${cohort}.preimpqc2 --exclude $genotype_dir/${cohort}/Exclude-${cohort}.preimpqc2-HRC.txt --make-bed --out $genotype_dir/${cohort}/TEMP1
/local/bin/plink2 --bfile $genotype_dir/${cohort}/TEMP1 --update-map $genotype_dir/${cohort}/Chromosome-${cohort}.preimpqc2-HRC.txt --update-chr --make-bed --out $genotype_dir/${cohort}/TEMP2
/local/bin/plink2 --bfile $genotype_dir/${cohort}/TEMP2 --update-map $genotype_dir/${cohort}/Position-${cohort}.preimpqc2-HRC.txt --make-bed --out $genotype_dir/${cohort}/TEMP3
/local/bin/plink2 --bfile $genotype_dir/${cohort}/TEMP3 --flip $genotype_dir/${cohort}/Strand-Flip-${cohort}.preimpqc2-HRC.txt --make-bed --out $genotype_dir/${cohort}/TEMP4
/local/bin/plink2 --bfile $genotype_dir/${cohort}/TEMP4 --a2-allele $genotype_dir/${cohort}/Force-Allele1-${cohort}.preimpqc2-HRC.txt --make-bed --out $genotype_dir/${cohort}/${cohort}.preimpqc2-updated

for chr in {1..22}; do
  # Output .bed file
  /local/bin/plink2 \
    --bfile $genotype_dir/${cohort}/${cohort}.preimpqc2-updated \
    --real-ref-alleles \
    --make-bed \
    --chr $chr \
    --out $genotype_dir/${cohort}/${cohort}.preimpqc2-updated-chr${chr}
  # Output .vcf File  
  /local/bin/plink2 \
    --bfile $genotype_dir/${cohort}/${cohort}.preimpqc2-updated \
    --real-ref-alleles \
    --recode vcf \
    --chr $chr \
    --out $genotype_dir/${cohort}/${cohort}.preimpqc2-updated-chr${chr}
done

rm TEMP*
