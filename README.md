# network
This repository contains R-scripts used in the dissertation of Mr Sith Jaisong,IRRI scholar and University of the Philippines, Los Baños (UPLB) student for the analysing crop health survey data using network analysis.

 All scripts used in this analysis can be found at the following website: https://github.com/sithjaisong/network. These scripts are designed to be used from the R GUI program.

A. R Scripts used to run co-occurrence analysis and network construction
===

In order to construt the networks in this study, I have three functions following:
1. compute correlation coefficient all pair of variables
2. contructing network from step1
3. detact communities from step2

I also have 1 function to visulize node properties of resulted network to determine the functions of nodes has in a networks.

The first script used in this analysis is named ‘01_co_occurrence_injury_pairwise.R’.  In this script, it is assigned to perform Spearman's correlation through each dataset. The computation starts at the first column containing injury value. The output is a data frame with a column for the dataset label pair of injury, the correlation coefficient, p-value in the pair.

The second script is named ‘02_co_network_creation.R.’  This script is used for constructing a network of co-occurrence relationships with data frame formated that can be used with igraph to create networks. The input file contains the results from the script '01_co_occurrence_injury_pairwise.R'.  The output from this script is igraph object with all edges in the network containing the Spearman's correlation coefficient significant at p-values < 0.05.

The third script is named ‘comm_network.R’. The input file is the results from the script named ‘02_co_network_creation.R’. The output is igraph object, which can be used with igraph package to visualize the network with community detection by  ‘optimal_cluster’ function of igraph package.

The fourth script is named as 'node_stat.R'.  It is the function, which is applied for extracting node properties  from each node in a network and plot those node properties with dot graph  under ggplot pakage. The input file is igraph object from ‘02_co_network_creation.R’ or ‘02_comm_network.R.’   The output is ggplot graph showing node degree, betweenness, clustering coefficient, clustering coefficient from the network. 

# B. R Scripts used to run differential network analysis in different seasons

These scripts are named “03_season_dif_network.R’. These scripts are asigned to process from correlation coefficients computation to differntial network visulization.  Before performing this function, You are required to select two different data sets that you are going to compare and construct a differerntial network from these two data sets from different conditions. Each data set is needed to compute correaltion coefficient by function named ‘01_co_occurrence_injury_pairwise.R’ first. Then, the output from each data set will be able to compare the differences by ‘function_diff_cor.R' function. 

The function script used in this analysis is named ‘function_diff_cor.R’.   This function script is assigned to perform Fisher’s z- test of dataset from two different condition. The output is data frame with a column for the dataset label, each injury pair, the correlation coefficient at condition A, p-value in the pair at condition A, the correlation coefficient at condition B, , p-value in the pair at condition B, p-value of difference in the pair, and difference of two correlation coefficients. The result will be used for constructing differtial network model with all edges in the network with differential co-occurrence significant at p-values < 0.05, and labelled edges by color to identify the condition that edges are represented; red edges represent differential relationship in dry season, and blue edges represented differential relationship in wet season.

# C. R Scripts used to run co-occurrence analysis in different yield levels

These scripts are named “03_diferential_yield_network.R’. These scripts are asigned to process from correlation coefficients computation to differential network visulization.  Two different data sets (low yield data set and hight yield data) are computed correaltion coefficient by function named ‘01_co_occurrence_injury_pairwise.R’ first. Then, the output from each data set will be able to compare the differences by ‘function_diff_cor.R' function. The result will be used for constructing differential network model with all edges in the network with differential co-occurrence significant at p-values < 0.05, and select edge that higher significantly co-occurrenes at lower yield level.