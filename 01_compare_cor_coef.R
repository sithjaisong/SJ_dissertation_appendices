
library(WGCNA)
library(apcluster)
library(pheatmap)

#====================================================
# Comparing correlation coefficients for each method
#====================================================

# data is an data frame 

# pearson correlation
cor.pearson <- cor(data, method = "pearson", use = "pairwise") 

# spearman correlation
cor.spearman <- cor(data, method = "spearman", use = "pairwise")

# kendall correlation
cor.kendall <- cor(data, method = "kendall", use = "pairwise") 

# Biweight Midcorrelation from WGCNA package
cor.biweight <- bicor(data, use = "pairwise") 

# names the object
names(cor.pearson) <- "Pearson"
names(cor.spearman) <- "Spearman"
names(cor.kendall) <- "Kendall"
names(cor.biweight) <- "Biweight"

# Combine correlation value of each method #

# will add more correlation
all.cor <- cbind(cor.pearson, cor.spearman, cor.kendall, cor.biweight)

bind.cor <- as.data.frame(bind.cor)
row.names(bind.cor) <- NULL

##### Cluster Analysis and correlation matrix #####

cor.cor <- corSimMat(bind.cor, method = "pearson") # similarity by pearson method 

pheatmap(cor.cor,  # result from simularity test
         clustering_distance_rows = "euclidean", # cluster by euclidean method
         clustering_distance_cols = "euclidean", 
         cellwidth = 50, cellheight = 50, 
         fontsize = 16)


# ############################
# flattenCorrMatrix
# ###########################
# reference: http://www.sthda.com/english/wiki/print.php?id=78
# cormat : matrix of the correlation coefficients
# pmat : matrix of the correlation p-values

flattenCorrMatrix <- function(cormat, pmat) {
  ut <- upper.tri(cormat)
  data.frame(
    row = rownames(cormat)[row(cormat)[ut]],
    column = rownames(cormat)[col(cormat)[ut]],
    cor  =(cormat)[ut],
    p = pmat[ut]
  )
}



# counting the number of pairs that are significantly related
# =====================

# 
cor.pearson <- rcorr(as.matrix(data), type = "pearson")
cor.pearson <- flattenCorrMatrix(pearson.cor$r, pearson.cor$P)
cor.pearson %>% filter(p > 0.05) %>% nrow()
cor.pearson %>% filter(p < 0.05) %>% nrow()
cor.pearson %>% filter(p < 0.01) %>% nrow()

cor.spearman <- rcorr(as.matrix(data), type = "spearman")
cor.spearman <- flattenCorrMatrix(cor.spearman$r, cor.spearman$P)
cor.spearman %>% filter(p > 0.05) %>% nrow()
cor.spearman %>% filter(p < 0.05) %>% nrow()
cor.spearman %>% filter(p < 0.01) %>% nrow()

cor.kendall <- rcorr(as.matrix(data), type = "kendall")
cor.kendall <- flattenCorrMatrix(cor.kendall$r, cor.kendall$P)
cor.kendall %>% filter(p > 0.05) %>% nrow()
cor.kendall %>% filter(p < 0.05) %>% nrow()
cor.kendall %>% filter(p < 0.01) %>% nrow()

cor.biweight <- bicorAndPvalue(data, use = "pairwise")
cor.biweight <- flattenCorrMatrix(cor.biweight$bicor, cor.biweight$p)
cor.biweight %>% filter(p > 0.05) %>% nrow()
cor.biweight %>% filter(p < 0.05) %>% nrow()
cor.biweight %>% filter(p < 0.01) %>% nrow()

