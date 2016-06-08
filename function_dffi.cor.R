########################################################################
# title         : function_diff.cor.R
# purpose       : compare two correlation coefficients from two samples (network)
# producer      : prepared by S. Jaisong (s.jaisong@irri.org);
# last update   : in Los Baños, Laguna, PHL, Jun 2016;
# inputs        : correlation coefficent matrix from two dataset;
# outputs       : list of pairs which is significantly different;
######################################################################

# load fucntiion form DiffCorr library
library(DiffCorr)

diff.corr   <- function(data1, data2){
  
  ccc1 <- as.vector(data1[lower.tri(data1)])
  
  ccc2 <- as.vector(data2[lower.tri(data2)])
  
  n <- nrow(data1)
  
  N <- n * (n - 1)/2
  
  p1 <- rep(1, N)
  
  p2 <- rep(1, N)
  
  pdiff <- rep(1, N)
  
  diff <- rep(1, N)
  
  mol.names <- rownames(data1)
  
  p1 <- cor2.test(n1, ccc1)
  
  p2 <- cor2.test(n2, ccc2)
  
  pdiff <- compcorr(n1, ccc1, n2, ccc2)$pval
  diff <- ccc1 - ccc2
  
  pdiff[(is.na(pdiff)) == TRUE] <- 1
  
  myindex <- which((lower.tri(data1)) == TRUE, arr.ind = TRUE)
  
  mol.names1 <- mol.names[myindex[, 1]]
  
  mol.names2 <- mol.names[myindex[, 2]]
  
  fin.ind <- pdiff < 0.05
  
  # combine data
  res <- cbind(mol.names1[fin.ind], mol.names2[fin.ind], ccc1[fin.ind], p1[fin.ind], ccc2[fin.ind], p2[fin.ind], pdiff[fin.ind], diff[fin.ind])
  
  # correct format the data structure
  res <- as.data.frame(res)
  
  # name column
  names(res) <- c("var1", "var2", "r1", "p1", "r2", "p2", "p.difference", "difr")
  # set class of each variable
  res$var1 <- as.character(res$var1)
  res$var2 <- as.character(res$var2)
  res$r1 <- as.numeric(as.character(res$r1))
  res$p1 <- as.numeric(as.character(res$p1))
  res$r2 <- as.numeric(as.character(res$r2))
  res$p2  <- as.numeric(as.character(res$p2))
  res$p.difference <- as.numeric(as.character(res$p.difference))
  res$difr <- as.numeric(as.character(res$difr))
  
  return(res)
}