########################################################################
# title         : 02_comm_network.R
# purpose       : detact clusters or communities in co-occurrence network; 
# producer      : prepared by S. Jaisong (s.jaisong@irri.org);
# last update   : in Los Baños, Laguna, PHL, Jun 2016;
# inputs        : output as igraph object from 02_co_network_creation.R;
# outputs       : can modified based on cluster algorithm
######################################################################

library(RColorBrewer)
library(igraph)

cluster.network <- function(graph){
  
  # detect comminities with maximizing mudularity
  community <- cluster_optimal(graph, weights = abs(E(graph)$weight))
  
  # set colors from RcolorBrewer package for each community 
  prettyColors <- brewer.pal(n = 8, name = 'Set2')
  
  # define color to the community
  V(graph)$color <- prettyColors[membership(community)]
  
  # set the size of netwrok
  V(graph)$size <- 15
  
  # set width of edge
  E(graph)$width <- abs(E(graph)$weight)*10
  
  return(graph)
}