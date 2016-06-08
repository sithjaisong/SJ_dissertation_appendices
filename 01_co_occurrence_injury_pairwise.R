########################################################################
# title         : 01_co_occurrence_injury_pairwise.R
# purpose       : compute correlation coefficient
# producer      : prepared by S. Jaisong (s.jaisong@irri.org);
# last update   : in Los Baños, Laguna, PHL, Jan 2015;
# inputs        : dataframe containing varible conlumns with numeric data
# outputs       : data frame with pair of variable with correlation coefficient 
# remarks 1     : this function can be modified based on your correaltion method
######################################################################


# The script is to compute and construct the list of all pairs tested 
# correaltion

cooc_table <- function(data){
  
  # create the object to store the result
  results <- matrix(nrow = 0, ncol = 6)
  
  for (a in 1:(length(names(data)) - 1)) {
    
    # every variable will be compared to every other variable, so there has
    # to be another loop that iterates down the rest of the columns
    
    for (b in (a + 1):length(names(data))) {
      
      # summing the abundances of species of the columns that will be
      # compared
      
      
      var1.sum <- sum(temp[, a], na.rm = TRUE)
      var2.sum <- sum(temp[, b], na.rm = TRUE)
      
      # if the column is all 0's no co-occurrence will be performed
      
      if (var1.sum > 1 & var2.sum > 1) {
        
        # compute correlation using Spearman's correlation measure
        # can change correlation methods based on one's objective
        test <- cor.test(data[, a], data[, b], method = "spearman",
                         na.action = "na.exclude", exact = FALSE)
        
        # There are warnings when setting exact = TRUE because of ties from the
        # output of Spearman's correlation
        # stackoverflow.com/questions/10711395/spear-man-correlation and ties
        # It would be still valid if the data is not normally distributed.
        
        # extract rho value
        rho <- test$estimate
        # extract p.value value
        p.value <- test$p.value
      }
      
      if (var1.sum <= 1 | var2.sum <= 1) {
        # if varible is too small, it will not be included in analysis
        rho <- 0
        p.value <- 1
      }
      
      # combine the value
      new.row <- c(names(data)[a], names(data)[b], rho, p.value, var1.sum,
                   var2.sum)
      
      # combine row of the result
      results <- rbind(results, new.row)
      
    }
    
  }
  # change the class to dataframe
  results <- as.data.frame(results)
  
  row.names(results) <- NULL
  
  # rename column
  names(results) <- c("var1", "var2", "rho", "p.value", "var1.sum", "var2.sum")
  
  # set class of rho data to be numeric
  results$rho <- as.numeric(as.character(results$rho))
  
  # set class of p.value to be numberic
  results$p.value <- as.numeric(as.character(results$p.value))

  return(results)
}