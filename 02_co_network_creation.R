########################################################################
# title         : 02_co_network_creation.R;
# purpose       : constructing a network model;
# producer      : prepared by S. Jaisong (s.jaisong@irri.org);
# last update   : in Los Baños, Laguna, PHL, Jan 2016;
# inputs        : output as the dataframe from 02_co_occurrence_injury_pairwise.R; 
# outputs       : igraph objects; 
# remarks 1     : 
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
  
  # set node size at 25 is suitable for showing grap on A4 paper
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