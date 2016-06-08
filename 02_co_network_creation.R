########################################################################
# title         : 01_co_occurrence-injury_pairwise.R
# purpose       : compute correlation coefficient
# producer      : prepared by S. Jaisong (s.jaisong@irri.org);
# last update   : in Los Baños, Laguna, PHL, Jan 2015;
# inputs        : output as the dataframe from 01_co_occurrence_injury_pairwise.R 
# outputs       : data frame with pair of variable with correlation coefficient 
# remarks 1     : this function can be modified based on your correaltion method
######################################################################

library(igraph)

plot_network <- function(data){
  
  #== adjust the vertices properties
  
  # creat a network from an edge list matrix
  
  net <- graph.edgelist(as.matrix(data[ ,c("var1","var2")]), directed = FALSE)
  
  # set color's node
  V(net)$color <- adjustcolor("khaki2", alpha.f = .8)
  # set color's frame node
  V(net)$frame.color <- adjustcolor("khaki2", alpha.f = .8)
  
  # set shape of node
  V(net)$shape <- "circle"
  
  # set size of node. 25 is suitable for showing grap on A4 paper
  V(net)$size <- 25
  
  V(net)$label.color <- "black"
  
  V(net)$label.font <- 2
  
  V(net)$label.family <- "Helvetica"
  
  V(net)$label.cex <- 1.0
  
  # == adjust the edge proterties
  
  # label weight of each node pair with correlation cofficient
  E(net)$weight <- as.matrix(table[, "rho"])
  
  E(net)$width <- abs(E(net)$weight)*10
  
  E(net)$color <- "steelblue2"
  
  # set graph layout to Fruchterman-Reingold layout
  net$layout <- layout_with_fr(net)
  
  # output is igraph object
  return(net)
}
#eos