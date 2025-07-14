# Asthma BRIDGE: The Asthma BioRepository for Integrative Genomic Exploration

The Asthma BioRepository for Integrative Genomic Exploration (Asthma BRIDGE) is a publicly accessible resource of lymphoblastoid cell lines (LCLs) and multi-omic datasets linked to detailed and well-characterized phenotypes from patients with asthma and non-asthma controls. 1,479 consenting subjects of diverse genetic ancestry (1,231 with asthma, 248 without asthma) were recruited from the EVE asthma genetics consortium. These resources can catalyze integrative genomic studies of asthma and provide an extensive collection of genetically characterized cell lines for experimental studies.
# Overview figure
<img width="731" height="481" alt="image" src="https://github.com/user-attachments/assets/b77ba709-68fb-4920-9886-8f481d404e76" />



# Table of contents:

1. Processing codes for gene expression data QC
   - [Merging data across two batches](https://github.com/heidim-dev/ASTHMA-BRIDGE/blob/main/expression/data_merge_code.R)
   - [Expression data QC](https://github.com/heidim-dev/ASTHMA-BRIDGE/blob/main/expression/Data%20QC%20code.R)
2. Processing codes for CpG DNA methylation data QC
   - [CD4+ T cells](https://github.com/heidim-dev/ASTHMA-BRIDGE/blob/main/methylation/ABRIDGE_450k_CD4_preprocessing_methylation.Rmd)
   - [Whole Blood](https://github.com/heidim-dev/ASTHMA-BRIDGE/blob/main/methylation/ABRIDGE_450k_WBC_preprocessing.Rmd)
3. Processing codes for genotype data QC
   - [Pre-imputation genotype QC](https://github.com/heidim-dev/ASTHMA-BRIDGE/blob/main/genotype/preimputation)
   - [Post-imputation processing](https://github.com/heidim-dev/ASTHMA-BRIDGE/tree/main/genotype/postimputation) 

# Link to data repositories 

1. Gene expression data
[Transcriptomic Analysis of Asthma from The Asthma BioRepository for Integrative Genomic Exploration (Asthma BRIDGE) Project (GSE285752)](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE285752)  
    RNA were extracted from whole blood (n = 954), peripheral blood CD4+ T lymphocytes (n = 411), induced sputum alveolar macrophages (n = 84), bronchoalveolar cells (n = 42), and bronchial epithelial cells (n = 44).

2. DNA methylation data
[Epigenome-wide Analysis of Asthma from The Asthma BioRepository for Integrative Genomic Exploration (Asthma BRIDGE) Project (GSE294810)](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE294810)  
    The dataset will be held private until 31-August 2025.

3. Clinical, demographic, and post-QC imputed genome-wide genotype data.  
    This data will be posted on dbGaP. The dbGaP upload is currently in progress. 

# Citation
Makrynioti et al. Asthma BRIDGE: The Asthma BioRepository for Integrative Genomic Exploration (Manuscript in preparation).

