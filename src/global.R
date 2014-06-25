# global.R
# =============================================================================
# I am one of three shiny scripts.
# I load all variables global to ui.R and server.R.
# I also decide what should be categorical, what should 
# be continuous and what should be ignored.

library(shiny)
library(ggplot2)

# If variable classes have not been specified in 
# runDataExplorer.R, then  decide what they should 
# be from the denoted classes in the data frame

if (!exists('ignore.names')) {
  ignore.names <- c()
}

class.names <- lapply(dataset, function(x)class(x))
if (!is.null(ignore.names)) {
  class.names <- class.names[!names(dataset) %in% ignore.names]
}

cat.names <- names(dataset)[unlist(lapply(class.names, function(x)length(intersect(x, c('ordered', 'logical', 'factor')))>0))]
if (!exists('categorical.names')) {
  categorical.names <- cat.names
} else {
  categorical.names <- union(cat.names, categorical.names)
}
cont.names <- names(dataset)[unlist(lapply(class.names, function(x)length(intersect(x, c('integer', 'numeric', 'Date', 'ordered')))>0))]
if (!exists('continuous.names')) {
  continuous.names <- cont.names
} else {
  continuous.names <- union(cont.names, continuous.names)
}
