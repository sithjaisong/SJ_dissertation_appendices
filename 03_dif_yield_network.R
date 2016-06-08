########################################################################
# title         : 03_differntial_yield_network.R
# purpose       : find the differences in the network
# producer      : prepared by S. Jaisong (s.jaisong@irri.org);
# last update   : in Los Baños, Laguna, PHL, Jun 2016;
# inputs        : output as igraph object from 02_co_network_creation.R 
# outputs       : can modified based on cluster algorith
######################################################################


 cor_low <- cooc_table(df_low) # low yield level
 cor_high <- cooc_table(df_high) # high yield level

 # = low yield data
 cor_low$rho[cor_dry$p.value > 0.05 ] <- 0
 g1 <- graph.edgelist(as.matrix(cor_low[1:2]), directed = FALSE)
 E(g1)$weight <- cor_low$rho

 # = high yield data
 cor_high$rho[cor_df$p.value > 0.05 ] <- 0
 g2 <- graph.edgelist(as.matrix(df_high[1:2]), directed = FALSE)
 E(g2)$weight <- cor_high$rho

# = Differential network
# g1 is network graph of low yield  (condition1)
# g2 is network graph of high yield (condition2)

# create adjagency matrix from igraph object
 adj.mat1 <- as.matrix(as_adjacency_matrix(g1, attr = "weight")) # low yield

 adj.mat2 <- as.matrix(as_adjacency_matrix(g2, attr = "weight")) # high yield

 # compare correlation coefficient of each pair of injuries of conditionA and 
 # condition B

 # call dfiff.corr function from 02_co_network_creation.R #

 diff_comb <- diff.corr(adj.mat1 , adj.mat2)

 # set the index that 
 # if correlation coefficents of condition A higher than B index value is positive
 # if correlation coefficents of condition A less than B index value is negative
 diff_comb$index <- ifelse(abs(diff_comb$r1) - abs(diff_comb$r2) > 0, 1, -1)

 # create differtial network in yield levels

  gdif <- graph.edgelist(as.matrix(diff_comb[1:2]), directed = FALSE)

  E(gdif)$weight <- as.matrix(diff_comb$index)

  V(gdif)$color <- adjustcolor("khaki2", alpha.f = .8)
  V(gdif)$frame.color <- adjustcolor("khaki2", alpha.f = .8)
  V(gdif)$shape <- "circle"
  V(gdif)$size <- 25
  V(gdif)$label.color <- "black"
  V(gdif)$label.font <- 2
  V(gdif)$label.family <- "Helvetica"
  V(gdif)$label.cex <- 1.0
  gdif$layout <- layout_with_fr(gdif)
  E(gdif)[weight > 0]$color <- adjustcolor("grey60" , alpha.f = .8)
  
  # this network will be considered paris that higher significantly present at 
  # low yield level because we assume that injury that highly present in low may
  # cause yield loss
  
  gdif <- delete.edges(gdif, which(E(gdif)$weight < 0))

