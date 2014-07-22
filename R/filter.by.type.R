#' filter.by.type
#' 
#' Utility function to return a subset of names from a data.frame
#' which match the recignized classes in classes.list, given that
#' each name may have multiple classes in names.list ( a list)
#' @param dataset a data frame
#' @param classes.names vector of allowable column types
#' @param names.list list of vectors representing the classes of each column
#' @keywords filter names
#' @export
#' @examples 
#' X <- data.frame(X=factor(c(1,2,1,2)), Y=c(1.1, 1.2, pi, 23.*2))
#' filter.by.type(X, c('factor', 'ordinal'), list(X=c('factor'), Y=c('numeric'))) 

filter.by.type <- function(dataset, classes.names, names.list) {
  names(dataset)[unlist(lapply(classes.names,  function(x)length(intersect(x, names.list)) > 0))]
}
