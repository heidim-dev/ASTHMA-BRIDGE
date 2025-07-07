echo $cohort

plink2 --bfile ../../raw.camp/${cohort}/${cohort} --geno 0.05 --hwe 0.00001 --maf 0.01 --out ${cohort}.preimpqc1 --make-bed --alleleACGT --allow-no-sex 

# No palindromic SNP
cat ${cohort}.preimpqc1.bim | grep -P "\tC\tG|\tG\tC|\tA\tT|\tT\tA" | cut -f2

plink2 --bfile ${cohort}.preimpqc1 --mind 0.1 --make-bed --allow-no-sex --out ${cohort}.preimpqc1b

../Rayner_Strand/update_build.no_flip.sh ${cohort}.preimpqc1b HumanHap550v3_A-b37.strand ${cohort}.preimpqc2

plink2 --bfile ${cohort}.preimpqc2 --freq --out ${cohort}.preimpqc2

ln -s /proj/rerefs/reref00/HRC/GRCh37/HRC.r1-1.GRCh37.wgs.mac5.sites.tab HRC.r1.GRCh37.autosomes.mac5.sites.tab

../HRC-1000G-check-bim.pl -b ${cohort}.preimpqc2.bim -f ${cohort}.preimpqc2.frq -h -v -l /local/bin/plink2

cut -f1 Position-${cohort}.preimpqc2-HRC.txt > Position-${cohort}.preimpqc2-HRC.txt.IDs
cat Position-${cohort}.preimpqc2-HRC.txt.IDs >> Exclude-${cohort}.preimpqc2-HRC.txt

sh -f ./run_plink.sh


for file in `ls *.vcf`; do echo $file; bgzip $file; done
