
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

