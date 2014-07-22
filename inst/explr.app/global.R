# global.R
# =======================================================
# I am one of three shiny scripts.
# I load all variables global to ui.R and server.R.
# I also decide what should be categorical, what should 
# be continuous and what should be ignored.

library(shiny)
library(ggplot2)
source('utils.R')

# If variable classes have not been specified in 
# runDataExplorer.R, then  decide what they should 
# be from the denoted classes in the data frame
classes.names <- lapply(dataset, function(x)class(x))

# ignore.names are the variables to ignore in exploration
if (!exists('ignore.names')) {
  ignore.names <- c()
}

if (!is.null(ignore.names)) {
  classes.names <- classes.names[!names(dataset) %in% ignore.names]
}

# categorical.names are those with which to facet by and color with
cat.names <- filter.by.type(dataset, classes.names, c('ordered', 'logical', 'factor'))
if (!exists('categorical.names')) {
  categorical.names <- cat.names
} else {
  categorical.names <- union(cat.names, categorical.names)
}

# continuous.names are those to treat numerically
cont.names <- filter.by.type(dataset, classes.names, c('integer', 'numeric', 'Date', 'ordered'))
if (!exists('continuous.names')) {
  continuous.names <- cont.names
} else {
  continuous.names <- union(cont.names, continuous.names)
}
