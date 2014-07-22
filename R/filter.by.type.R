# Filter a dataset's names to only those whose data are of 
# one of the classes in names.list.
filter.by.type <- function(dataset, classes.names, names.list) {
  names(dataset)[unlist(lapply(classes.names,  function(x)length(intersect(x, names.list)) > 0))]
}
