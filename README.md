# network
<<<<<<< HEAD
This repository contains R-scripts used in the dissertation of Mr Sith Jaisong,
IRRI scholar and Univerity of the Philippines, Los Baños (UPLB) student for the
analysing crop health survey data using network analysis.
=======
This repo contains R-scripts used for analyse crop health survey data by network analysis

A. R Scripts used to run co-occurrence analysis and network construction

## All scripts used in this analysis along can be found at the following website: https://github.com/sithjaisong/network. These scripts are designed to be used from the R GUI program.
The first script used in this analysis is named ‘co_occurrence_injury_pairwise.R’. In the script, these are assigned to perform Spearman correlation through each dataset. The computation starts at the first column containing injury value. The output is a data frame with a column for the dataset label, each injury pair, the correlation coefficient, p-value in the pair.

The second script is labeled ‘co_network_creation.R.’ The script is used for construct a network of co- occurrence relationships in a format that can be used with igraph to create networks. The input file contains the results from the script, co_occurrence_injury_pairwise.R. The output is igraph object with all edges in the network with the strength of co-occurrence significant at p-values < 0.05 (in this case, rho, or Spearman’s correlation coefficient).

The third script is labeled ‘comm_network.R’. The input file is the results from the script named ‘co_network_creation.R’. The output is igraph object, which can be used with igraph package to visualize the network with community detection by function ‘optimal_cluster’ function form igraph package.
The fourth script is labeled node_stat.R. The input file is igraph object from the script, ‘comm_network.R.’ or ‘co_network_creation.R’ The output is a data frame and ggplot graph showing node degree, betweenness, clustering coefficient, clustering coefficient from co-occurrence network. 

# B. R Scripts used to run differential network analysis in different seasons

All scripts used in this analysis along with data can be found at the following website: https://github.com/sithjaisong/network. These scripts are designed to be used from the R GUI program.
The script used in this analysis is named ‘co_oc_diff.R’. The input file is datafrme from the script named ‘co_occurrence_injury_pairwise.R’. These scripts are assigned to perform Fisher’s z- test of dataset from two different condition. The output is dataframe with a column for the dataset label, each injury pair, the correlation coefficient at condition A, p-value in the pair at condition A, the correlation coefficient at condition B, , p-value in the pair at condition B, p-value of difference in the pair, and difference of two correlation coefficients 
The second script is named “season_dif_network.R’. The input file is datafrme from the script named ‘co_oc_diff.R’. The output is igraph object with all edges in the network with differential co-occurrence significant at p-values < 0.05, and labled edges by color to identify the condition that edges are represented; red edges represent differential relationship in dry season, and blue edges represented differential relationship in wet season.

# C. R Scripts used to run co-occurrence analysis in different yield levels

All scripts used in this analysis along with data can be found at the following website: https://github.com/sithjaisong/network. These scripts are designed to be used from the R GUI program.
The first script is named 'co_co_diff.R' input file is datafrme from the script named ‘co_oc_diff.R’. The output is igraph object with all edges in the network with differential co-occurrence significant at p-values < 0.05 in lower yield level.
>>>>>>> master
