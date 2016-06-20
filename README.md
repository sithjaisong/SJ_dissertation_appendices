# network
<<<<<<< HEAD
This repository contains R-scripts used in the dissertation of Mr. Sith Jaisong, IRRI scholar and University of the Philippines Los Baños (UPLB) student, for the analyzing crop health survey data using network analysis.

R Scripts used to run to compare correlation coefficients from each correlation method
===

The script named [01_compare_cor_coef.R](https://github.com/sithjaisong/network/blob/master/01_compare_cor_coef.R) is assigned to perform similarity test of the correlation coefficients from each method and cluster analysis using Euclidean distance. This script also is included the method to find injury pairs that are significantly related at different thresholds (*p*-value > 0.05, < 0.05, and < 0.01) resulting from four correlation methods.

R Scripts used to run co-occurrence analysis and network construction
===

In order to construct the networks in this study, I used the following methods:

1. compute correlation coefficients of all pairs of variables,

2. construct network from step 1, and

3. detect communities from step 2.


I also have written a function to visualize node properties of resulting networks to determine the functions of nodes in each network.

The first script used in this analysis is named [02_co_occurrence_injury_pairwise.R](https://github.com/sithjaisong/network/blob/master/02_co_occurrence_injury_pairwise.R). This script performs Spearman's correlation for each different production environment and seasons. The computation starts at the first column containing injury value. The output is a data frame with a column for the dataset label pair of injury, the correlation coefficient, and *p*-value in the pair.

The second script is named [02_co_network_creation.R](https://github.com/sithjaisong/network/blob/master/02_co_network_creation.R). This script is used for constructing a network of co-occurrence relationships in a data frame so that it that can be used with `igraph` to create networks. The input file contains the results from the script [02_co_occurrence_injury_pairwise.R](https://github.com/sithjaisong/network/blob/master/02_co_occurrence_injury_pairwise.R). The output from this script is an `igraph` object with all edges in the network containing the Spearman's correlation coefficient significant at *p*-values < 0.05.

The third script is named [02_comm_network.R](https://github.com/sithjaisong/network/blob/master/02_comm_network.R). The input file is the results from the script named [02_co_network_creation.R](https://github.com/sithjaisong/network/blob/master/02_co_network_creation.R). The output is an `igraph` object, which can be used with the `igraph` package to visualize the network with community detection by `optimal_cluster` function from the `igraph` package.

'[function_plot.node.centrality.R](https://github.com/sithjaisong/network/blob/master/function_plot.node.centrality.R)' is the function, which is applied for extracting node properties from each node in a network and plot those node properties with dot graph by `ggplot2` package. The input file is an `igraph` object from [02_co_network_creation.R](https://github.com/sithjaisong/network/blob/master/02_co_network_creation.R) or [02_co_network_creation.R](https://github.com/sithjaisong/network/blob/master/02_co_network_creation.R). The output is a `ggplot2` graph showing three node node properties (node degree, betweenness, clustering coefficient, and clustering coefficient) from the network. 

R Scripts used to run differential network analysis in different seasons
===

These scripts are named [03_season_differential_cooccur_network.R](https://github.com/sithjaisong/network/blob/master/03_season_differential_cooccur_network.R) and are assigned to process correlation coefficients computation into differential network visualizations. Before performing this function, you are required to select two different data sets that you are going to compare and construct a differential network from these two data sets from different conditions. Each data set is needed to compute a correlation coefficient using the [02_co_occurrence_injury_pairwise.R](https://github.com/sithjaisong/network/blob/master/02_co_occurrence_injury_pairwise.R) script, first. Then, the output from each season will be compares the differences using the Fisher’s *z*- test with '[function_diff_cor.R](https://github.com/sithjaisong/network/blob/master/03_differial_season_network.R)'. 

'[function_diff_cor.R](https://github.com/sithjaisong/network/blob/master/03_differial_season_network.R)' is assigned to perform a Fisher’s *z*- test of data sets from two different conditions. The output is data frame with a column for the dataset label, each injury pair, the correlation coefficient at condition A, *p*-value in the pair at condition A, the correlation coefficient at condition B, *p*-value in the pair at condition B, *p*-value of difference in the pair, and difference of two correlation coefficients. The result will be used for constructing differential network model with all edges in the network with differential co-occurrence significant at *p*-values < 0.05, and label edges by color to identify the condition that edges are represented; red edges represent differential relationship in dry season, and blue edges represented differential relationships in wet season.

These scripts are named [03_yield_differential_cooccur_network.R](https://github.com/sithjaisong/network/blob/master/03_yield_differential_cooccur_network.R). These scripts are assigned to process from correlation coefficients computation to differential network visualization. Two different data sets (survey data at low yield level and high yield level) are computed correlation coefficients by function named [02_co_occurrence_injury_pairwise.R](https://github.com/sithjaisong/network/blob/master/02_co_occurrence_injury_pairwise.R). Then, the output from each data set will be compared the differences using '[function_diff_cor.R](https://github.com/sithjaisong/network/blob/master/function_dffi.cor.R)'. The result will be used for constructing a differential network model with all edges in the network having differential co-occurrence significant at *p*-values < 0.05, and select the edges that significantly co-occurrences at lower yield level.
=======
This repository contains R-scripts used in the dissertation of Mr Sith Jaisong,
IRRI scholar and University of the Philippines, Los Baños (UPLB) student for
the analyses of crop health survey data using network analysis.

All scripts used in this analysis can be found at the following website:
https://github.com/sithjaisong/network. These scripts are written to be used
in R.
>>>>>>> pr/16
