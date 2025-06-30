##Pre-QC Filtering
in.path <- "/proj/reilms/reilm0h/ABRIDGE_GeneExpr_Final/Output/"
in.file <- "LstCampChips1to60AbridgeChips1to163.pheno.rda"
load(file = paste(in.path, in.file, sep = ""))
es.raw0 <- LstCampChips1to60AbridgeChips1to163.pheno$es.raw
esQC.raw0 <- LstCampChips1to60AbridgeChips1to163.pheno$esQC.raw
colnames(pData(es.raw0))
colnames(fData(es.raw0))
###Remove Probes with Many Missing Values
naCounts <- apply(exprs(es.raw0), 1, function(x) {
  return(sum(is.na(x) == TRUE))
})
pos.del0 <- which(naCounts > 0)
if (any(pos.del0)) {
  es.raw1 <- es.raw0[-pos.del0, ]
} else {
  es.raw1 <- es.raw0
}
naCounts.QC <- apply(exprs(esQC.raw0), 1, function(x) {
  return(sum(is.na(x) == TRUE))
})
pos.del0.QC <- which(naCounts.QC > 0)
if (any(pos.del0.QC)) {
  esQC.raw1 <- esQC.raw0[-pos.del0.QC, ]
} else {
  esQC.raw1 <- esQC.raw0
}
rm(es.raw0, esQC.raw0, LstCampChips1to60AbridgeChips1to163.pheno)
##Remove CAMP Pilot Array
pos.del1 <- which(es.raw1$Recruitment_ID == "XX")
es.raw2 <- es.raw1[, -pos.del1]
esQC.raw2 <- esQC.raw1[, -pos.del1]
##Remove Bad WFU Arrays
pos.del2 <- which(es.raw2$Study_Center_Name == "WFU - Wake Forest University")
es.raw3 <- es.raw2[, -pos.del2]
esQC.raw3 <- esQC.raw2[, -pos.del2]
rm(es.raw1, esQC.raw1)
rm(es.raw2, esQC.raw2)
##Remove Failed Arrays
pos.del3 <- which(es.raw3$Pass_Fail == "fail")
es.raw4 <- es.raw3[, -pos.del3]
esQC.raw4 <- esQC.raw3[, -pos.del3]
rm(es.raw3, esQC.raw3)

##Remove Gene Probes with Outlying Expression Levels

dat <- exprs(es.raw4)
counts <- apply(dat, 1, function(x) {
  tt <- any((is.na(x) == FALSE) & (log2(x) < 5))
  return(tt)
})
pos.sel4 <- which(counts == FALSE)
es.raw5 <- es.raw4[pos.sel4, ]
esQC.raw5 <- esQC.raw4
rm(es.raw4, esQC.raw4)

##Remove Arrays with p95/p05 <= 6

p05 <- apply(exprs(es.raw5), 2, quantile, prob = 0.05, na.rm = TRUE)
p95 <- apply(exprs(es.raw5), 2, quantile, prob = 0.95, na.rm = TRUE)
ratio <- p95/p05
pos.del5 <- which(ratio <= 6)
es.raw6 <- es.raw5[, -pos.del5]
esQC.raw6 <- esQC.raw5[, -pos.del5]
rm(es.raw5, esQC.raw5)

##Remove Duplicated Arrays
ttes <- es.raw6
ttes$idCellType <- paste(ttes$Recruitment_ID, ttes$Tissue_Descr, sep = ".")
ttes2 <- filterFunc(es = ttes, GCid = c("128115", "Hela", "Brain"), excludeGC = TRUE,
                    excludeReplicates = TRUE, excludeFails = TRUE, sampleProbeFlag = TRUE, filter = FALSE,
                    subjID = "idCellType", gene.var = "Symbol", chr.var = "Chromosome", sortFlag = FALSE,
                    saveFlag = FALSE, outObjFileDir = NULL, outObjFilePrefix = "esPreProcess",
                    verbose = FALSE)
# keep genetic control arrays
pos.sel6 <- c(match(ttes2$Hybridization_Name, ttes$Hybridization_Name), which(ttes$Study_Name ==
                                                                                "CONTRL"))
es.raw7 <- es.raw6[, pos.sel6]
esQC.raw7 <- esQC.raw6[, pos.sel6]
rm(es.raw6, esQC.raw6, ttes, ttes2)

##Export of Cleaned Data

Lst.Clean <- list(es.raw = es.raw7, esQC.raw = esQC.raw7)
out.path <- "/proj/reilms/reilm0h/ABRIDGE_GeneExpr_Final/Output/"
out.file <- "Lst.Clean.raw.rda"
save(Lst.Clean, file = paste(out.path, out.file, sep = ""))