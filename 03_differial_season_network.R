########################################################################
# title         : 03_differntial_season_network.R
# purpose       : find the change from
# producer      : prepared by S. Jaisong (s.jaisong@irri.org);
# last update   : in Los Baños, Laguna, PHL, Jun 2016;
# inputs        : output as igraph object from 02_co_network_creation.R 
# outputs       : can modified based on cluster algorith
######################################################################


# df_dry is the dataframe selected in dry season
# df_wet is the datafeam selected in wet season

# call function from 01_co_occurrence_injury_pairwise.R

  cor_dry <- cooc_table(df_dry) # dry season
  cor_wet <- cooc_table(df_wet) # wet season
  
  pair.list <- cor_dry
  # = Dry season
  cor_dry$rho[cor_dry$p.value > 0.05 ] <- 0
  g1 <- graph.edgelist(as.matrix(cor_dry[1:2]), directed = FALSE)
 
  # = Wet season
  cor_wet2$rho[cor_df$p.value > 0.05 ] <- 0
  g2 <- graph.edgelist(as.matrix(df_wet[1:2]), directed = FALSE)

  
  # = Differential network
  # g1 is network graph of dry season (condition1)
  # g2 is network graph of wet season (condition2)
  
  # create adjagency matrix from igraph object
  adj.mat1 <- as.matrix(as_adjacency_matrix(g1, attr = "weight")) # dry season
  
  adj.mat2 <- as.matrix(as_adjacency_matrix(g2, attr = "weight")) # wet season
  
  
  # compare correlation coefficient of each pair of injuries of conditionA and 
  # condition B
  
  # call dfiff.corr function from 02_co_network_creation.R #
  
  diff_comb <- diff.corr(adj.mat1 , adj.mat2)
  
  # set the index that 
  # if correlation coefficents of condiction A higher than B index value is positive
  # if correlation coefficents of condiction A less than B index value is negative
  diff_comb$index <- ifelse(abs(diff_comb$r1) - abs(diff_comb$r2) > 0, 1, -1)
  
  # create differtial network in seasons
  
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
  
  # label edges following the result from comparison
  # Dry season - Wet season 
  # Dry > Wet > 0 ; labeled with organred4 color
  # Dry < Wet < 0 ; labeled with royelblue4 color
  E(gdif)[weight > 0]$color <- adjustcolor("orangered4" , alpha.f = .8)
  E(gdif)[weight < 0]$color <- adjustcolor("royalblue4", alpha.f = .8)

