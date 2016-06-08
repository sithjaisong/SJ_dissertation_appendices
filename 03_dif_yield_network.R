plot_difnetwork <- function(net){
  
  V(net)$color <- adjustcolor("khaki2", alpha.f = .8)
  
  V(net)$frame.color <- adjustcolor("khaki2", alpha.f = .8)
  
  V(net)$shape <- "circle"
  
  V(net)$size <- 25
  
  V(net)$label.color <- "black"
  
  V(net)$label.font <- 2
  
  V(net)$label.family <- "Helvetica"
  
  V(net)$label.cex <- 1.0
  
  E(net)$width <- 5
  E(net)[weight == 0]$width <- 0
  # Dry season - Wet season 
  # Dry > Wet > 0
  # Dry < Wet < 0
  E(net)[weight > 0]$color <- adjustcolor("orangered4" , alpha.f = .8)
  E(net)[weight < 0]$color <- adjustcolor("royalblue4", alpha.f = .8)
  return(net)
}


cor.mat <- list()
yielddifnet <- list()

#area <- c("Central_Plain", "Odisha", "Red_River_Delta", "Tamil_ Nadu", "West_Java")
#i <- 1
for (i in 1:5) {
  cor.mat[[2*(i -1) +1]] <- yield.country.cor.mat[[2*(i -1) +1]] 
  cor.mat[[2*(i -1) +2]] <- yield.country.cor.mat[[2*(i -1) +2]]
  
  # = Dry season
  cor.mat[[ 2*(i-1) + 1]]$rho[cor.mat[[ 2*(i-1)+1]]$p.value > 0.05 ] <- 0
  cor.mat[[ 2*(i-1) + 1]]$rho[cor.mat[[ 2*(i-1)+1]]$rho < 0 ] <- 0
  g1 <- graph.edgelist(as.matrix(cor.mat[[2*(i-1) + 1]][1:2]), directed = FALSE)
  E(g1)$weight <- as.matrix(cor.mat[[2*(i-1) + 1]][,3])
  E(g1)$color <- adjustcolor("blue", alpha.f = .8)
  E(g1)$frame.color <- adjustcolor("blue", alpha.f = .8)
  
  # = Wet season
  cor.mat[[2*(i-1) + 2]]$rho[cor.mat[[2*(i-1) + 2]]$p.value > 0.05 ] <- 0
  cor.mat[[2*(i-1) + 2]]$rho[cor.mat[[ 2*(i-1)+2]]$rho < 0 ] <- 0
  g2 <- graph.edgelist(as.matrix(cor.mat[[2*(i-1) + 2]][1:2]), directed = FALSE)
  E(g2)$weight <- as.matrix(cor.mat[[2*(i-1) + 2]][,3])
  E(g2)$color <- adjustcolor("blue", alpha.f = .8)
  E(g2)$frame.color <- adjustcolor("blue", alpha.f = .8)
  
  # = Differential network
  adj.mat1 <- as.matrix(as_adjacency_matrix(g1, attr = "weight"))
  adj.mat2 <- as.matrix(as_adjacency_matrix(g2, attr = "weight"))
  res <- diff.corr(adj.mat1 , adj.mat2)
  diff_comb <- left_join(pair.IP.list, res[c("var1", "var2", "r1", "r2")])
  diff_comb$index <- ifelse(abs(diff_comb$r1) - abs(diff_comb$r2) > 0, 1, -1)
  gdif <- graph.edgelist(as.matrix(diff_comb[1:2]), directed = FALSE)
  diff_comb[is.na(diff_comb)] <- 0
  E(gdif)$weight <- as.matrix(diff_comb[,5])
  yielddifnet[[i]] <- plot_yield.difnetwork(gdif)
  
  # ============================================================================
  #l <-layout.fruchterman.reingold(g1) 
  #png(file = paste("./chapter4/results/yield_comp.difnet", area[i], ".png", sep =""), width = 1500, res = 100)
  #layout(t(1:3))
  #plot(plot_network(g1), layout = l , main = "Low season network") 
  #plot(difnet[[i]], layout = l, main = paste("Differential network of survey data in", area[i], sep = " "))
  #plot(plot_network(g2), layout = l, main = "High yield level network")
  #dev.off()
}


plot_yield.difnetwork <- function(net){
  
  V(net)$color <- adjustcolor("khaki2", alpha.f = .8)
  
  V(net)$frame.color <- adjustcolor("khaki2", alpha.f = .8)
  
  V(net)$shape <- "circle"
  
  V(net)$size <- 25
  
  V(net)$label.color <- "black"
  
  V(net)$label.font <- 2
  
  V(net)$label.family <- "Helvetica"
  
  V(net)$label.cex <- 1.0
  
  E(net)$width <- 5
  E(net)[weight < 0]$width <- 0
  
  # Dry season - Wet season 
  # Dry > Wet > 0
  # Dry < Wet < 0
  E(net)[weight > 0]$color <- adjustcolor("grey60" , alpha.f = .8)
  net <- delete.edges(net, which(E(net)$weight < 0))
  return(net)
}
