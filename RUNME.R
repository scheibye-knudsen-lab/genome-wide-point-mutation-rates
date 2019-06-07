# library(qqman)
# library(RColorBrewer)
# require(IdeoViz)

Plus_Lmna_raw = read.table("Plus_Lmna.010.mpileup.clean.freqs.cut", stringsAsFactors = F, h=T)
Plus_Lmna = Plus_Lmna_raw[(Plus_Lmna_raw$fa==1.0)|(Plus_Lmna_raw$fc==1.0)|(Plus_Lmna_raw$fg==1.0)|(Plus_Lmna_raw$ft==1.0),]

Plus_Lmna_H2O2_raw = read.table("Plus_Lmna_H2O2.010.mpileup.clean.freqs.cut", stringsAsFactors = F, h=T)
Plus_Lmna_H2O2 = Plus_Lmna_H2O2_raw[(Plus_Lmna_raw$fa==1.0)|(Plus_Lmna_raw$fc==1.0)|(Plus_Lmna_raw$fg==1.0)|(Plus_Lmna_raw$ft==1.0),]

Minus_Lmna_raw = read.table("Minus_Lmna.010.mpileup.clean.freqs.cut", stringsAsFactors = F, h=T)
Minus_Lmna = Minus_Lmna_raw[(Minus_Lmna_raw$fa==1.0)|(Minus_Lmna_raw$fc==1.0)|(Minus_Lmna_raw$fg==1.0)|(Minus_Lmna_raw$ft==1.0),]

Minus_Lmna_H2O2_raw = read.table("Minus_Lmna_H2O2.010.mpileup.clean.freqs.cut", stringsAsFactors = F, h=T)
Minus_Lmna_H2O2 = Minus_Lmna_H2O2_raw[(Minus_Lmna_raw$fa==1.0)|(Minus_Lmna_raw$fc==1.0)|(Minus_Lmna_raw$fg==1.0)|(Minus_Lmna_raw$ft==1.0),]

# Plus_Lmna_raw$key = paste(Plus_Lmna_raw$chr, Plus_Lmna_raw$pos, sep = "_")
# Minus_Lmna_raw$key = paste(Minus_Lmna_raw$chr, Minus_Lmna_raw$pos, sep = "_")
# length(unique(Plus_Lmna_raw$key))
# length(unique(Minus_Lmna_raw$key))
# common = intersect(Plus_Lmna_raw$key, Minus_Lmna_raw$key)
# 
# Plus_Lmna = Plus_Lmna_raw[Plus_Lmna_raw$key%in%common,]
# Plus_Lmna_H2O2 = Plus_Lmna_H2O2_raw[Plus_Lmna_raw$key%in%common,]
# Minus_Lmna = Minus_Lmna_raw[Minus_Lmna_raw$key%in%common,]
# Minus_Lmna_H2O2 = Minus_Lmna_H2O2_raw[Minus_Lmna_raw$key%in%common,]

Plus_Lmna$ref = toupper(Plus_Lmna$ref)
Plus_Lmna_H2O2$ref = toupper(Plus_Lmna_H2O2$ref)
Minus_Lmna$ref = toupper(Minus_Lmna$ref)
Minus_Lmna_H2O2$ref = toupper(Minus_Lmna_H2O2$ref)

# Plus_Lmna_H2O2_CT = Plus_Lmna_H2O2[Plus_Lmna_H2O2$ref=="C",]
# Plus_Lmna_H2O2_CT = Plus_Lmna_H2O2_CT[,c("chr", "pos", "ft")]
# names(Plus_Lmna_H2O2_CT) = c("chrom", "chromStart", "P")
# Plus_Lmna_H2O2_CT$chromEnd = Plus_Lmna_H2O2_CT$chromStart
# Plus_Lmna_H2O2_CT$P = Plus_Lmna_H2O2_CT$P*10000
# 
# Minus_Lmna_H2O2_CT = Minus_Lmna_H2O2[Minus_Lmna_H2O2$ref=="C",]
# Minus_Lmna_H2O2_CT = Minus_Lmna_H2O2_CT[,c("chr", "pos", "ft")]
# names(Minus_Lmna_H2O2_CT) = c("chrom", "chromStart", "P")
# Minus_Lmna_H2O2_CT$chromEnd = Minus_Lmna_H2O2_CT$chromStart
# Minus_Lmna_H2O2_CT$P = Minus_Lmna_H2O2_CT$P*10000
# 
# ideo_mm10 <- getIdeo("mm10")
# chroms <- c("chr1", "chr2","chr3","chr4","chr5","chr6","chr7","chr8","chr9","chr10","chr11","chr12","chr13","chr14","chr15","chr16","chr17","chr18","chr19")
# chrom_bins <- getBins(chroms,
#                       ideo_mm10,
#                       stepSize=5*100*1000)
# avg_peak_Plus_Lmna_H2O2_CT <- avgByBin(data.frame(value=Plus_Lmna_H2O2_CT[,c(3)]),
#                       Plus_Lmna_H2O2_CT[,c(1,2,4)],
#                       chrom_bins)
# avg_peak_Minus_Lmna_H2O2_CT <- avgByBin(data.frame(value=Minus_Lmna_H2O2_CT[,c(3)]),
#                       Minus_Lmna_H2O2_CT[,c(1,2,4)],
#                       chrom_bins)
# 
# png("Plus_Lmna_H2O2_CT.png", width = 2000, height = 3000)
# plotOnIdeo(chrom=seqlevels(chrom_bins),
#            ideoTable=ideo_mm10,
#            values_GR=avg_peak_Plus_Lmna_H2O2_CT, value_cols='value',
#            val_range=c(0,10),
#            plotType='lines',
#            col='blue', vertical=F, addScale = F,
#            cex.axis=3.0, lwd = 5, chromName_cex=0, font=1)
# dev.off()
# png("Minus_Lmna_H2O2_CT.png", width = 2000, height = 3000)
# plotOnIdeo(chrom=seqlevels(chrom_bins),
#            ideoTable=ideo_mm10,
#            values_GR=avg_peak_Minus_Lmna_H2O2_CT, value_cols='value',
#            val_range=c(0,10),
#            plotType='lines',
#            col='red', vertical=F, addScale = F,
#            cex.axis=3.0, lwd = 5, chromName_cex=0, font=1)
# dev.off()

ACGT = c("A","C","G","T")

doIt = function(CASE, CONTROL){
  mat = lapply(ACGT, FUN = function(x){
    lapply(ACGT, FUN = function(y) {
      ttest = t.test(CASE[,paste("f",tolower(y),sep="")][CASE$ref==x],CONTROL[,paste("f",tolower(y),sep="")][CONTROL$ref==x])
      ttest.two.sided = t.test(CASE[,paste("f",tolower(y),sep="")][CASE$ref==x],CONTROL[,paste("f",tolower(y),sep="")][CONTROL$ref==x], paired = T)
      ttest.less = t.test(CASE[,paste("f",tolower(y),sep="")][CASE$ref==x],CONTROL[,paste("f",tolower(y),sep="")][CONTROL$ref==x], paired = T, alternative = "less")
      ttest.greater = t.test(CASE[,paste("f",tolower(y),sep="")][CASE$ref==x],CONTROL[,paste("f",tolower(y),sep="")][CONTROL$ref==x], paired = T, alternative = "greater")
      fc = ttest$estimate[1]/ttest$estimate[2]
      return(list("transition" = paste(x, y, collapse = "", sep = ">"), "estimate" = ttest.two.sided$estimate, "two.sided" = ttest.two.sided$p.value, "less" = ttest.less$p.value, "greater" = ttest.greater$p.value, "case" = ttest$estimate[1], "control" = ttest$estimate[2], "fc" = fc, "log2FC" = log2(fc)))
    })
  })
  mat2 = unlist(mat, recursive = F)
  df <- data.frame(matrix(unlist(mat2), nrow=length(mat2), byrow=T), stringsAsFactors = F)
  row.names(df) = as.character(df$X1)
  names(df) = c("Mutation", "estimate", "two.sided", "less", "greater", "case", "control", "FC", "log2FC")
  return(df)
}

doIt2 = function(CASE, CONTROL){
  mat = lapply(ACGT, FUN = function(x){
    lapply(ACGT, FUN = function(y) {
      ttest = t.test(CASE[,paste("f",tolower(y),sep="")][CASE$ref==x],CONTROL[,paste("f",tolower(y),sep="")][CONTROL$ref==x])
      ttest.two.sided = t.test(CASE[,paste("f",tolower(y),sep="")][CASE$ref==x],CONTROL[,paste("f",tolower(y),sep="")][CONTROL$ref==x])
      ttest.less = t.test(CASE[,paste("f",tolower(y),sep="")][CASE$ref==x],CONTROL[,paste("f",tolower(y),sep="")][CONTROL$ref==x], alternative = "less")
      ttest.greater = t.test(CASE[,paste("f",tolower(y),sep="")][CASE$ref==x],CONTROL[,paste("f",tolower(y),sep="")][CONTROL$ref==x], alternative = "greater")
      fc = ttest$estimate[1]/ttest$estimate[2]
      return(list("transition" = paste(x, y, collapse = "", sep = ">"), "estimate" = ttest.two.sided$estimate, "two.sided" = ttest.two.sided$p.value, "less" = ttest.less$p.value, "greater" = ttest.greater$p.value, "case" = ttest$estimate[1], "control" = ttest$estimate[2], "fc" = fc, "log2FC" = log2(fc)))
    })
  })
  mat2 = unlist(mat, recursive = F)
  df <- data.frame(matrix(unlist(mat2), nrow=length(mat2), byrow=T), stringsAsFactors = F)
  row.names(df) = as.character(df$X1)
  names(df) = c("Mutation", "estimate", "two.sided", "less", "greater", "case", "control", "FC", "log2FC")
  return(df)
}

Minus_Lmna_Minus_Lmna_H2O2 = doIt(Minus_Lmna_H2O2, Minus_Lmna)
Plus_Lmna_Plus_Lmna_H2O2 = doIt(Plus_Lmna_H2O2, Plus_Lmna)
Plus_Lmna_H2O2_Minus_Lmna_H2O2 = doIt2(Minus_Lmna_H2O2, Plus_Lmna_H2O2)

Minus_Lmna_Minus_Lmna_H2O2
Plus_Lmna_Plus_Lmna_H2O2
Plus_Lmna_H2O2_Minus_Lmna_H2O2

res = cbind.data.frame(Plus_Lmna_Plus_Lmna_H2O2$Mutation, as.numeric(Minus_Lmna_Minus_Lmna_H2O2$estimate)*10000, as.numeric(Plus_Lmna_Plus_Lmna_H2O2$estimate)*10000)
res$FC = df[,2]/df[,3]
names(res) <- c("Mutation", "Lamin Δ (h2o2)", "WT Δ (h2o2)", "FC (Lamin h2o2 vs WT h2o2)")
res = res[c(2,3,4,5,7,8,9,10,12,13,14,15),]
res[,2] = round(res[,2], digits = 2)
res[,3] = round(res[,3], digits = 2)
res[,4] = round(res[,4], digits = 2)
write.table(file = "results.txt", res, row.names = F, sep = "\t")

res2 = Plus_Lmna_H2O2_Minus_Lmna_H2O2[c(2,3,4,5,7,8,9,10,12,13,14,15),c(1,4,5,6)]
names(res2) = c("Mutation", "two.sided", "less", "greater")
write.table(file = "Minus_Lmna_H2O2_Plus_Lmna_H2O2.txt", res2, row.names = F, sep = "\t")

res2 = Minus_Lmna_Minus_Lmna_H2O2[c(2,3,4,5,7,8,9,10,12,13,14,15),c(1,3,4,5)]
names(res2) = c("Mutation", "two.sided", "less", "greater")
write.table(file = "Minus_Lmna_Minus_Lmna_H2O2.txt", res2, row.names = F, sep = "\t")

res2 = Plus_Lmna_Plus_Lmna_H2O2[c(2,3,4,5,7,8,9,10,12,13,14,15),c(1,3,4,5)]
names(res2) = c("Mutation", "two.sided", "less", "greater")
write.table(file = "Plus_Lmna_Plus_Lmna_H2O2.txt", res2, row.names = F, sep = "\t")
