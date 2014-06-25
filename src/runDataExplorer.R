# runDataExplorer.R
# ==============================================================================
# I am the abstract R script that runs the shiny app. I am run by the shell.
# I set up paths, read the settings file and load the data

# customizable portion
ignore.names <- c()
categorical.names <- c()
continuous.names <- c()
# End customizable portion

require(shiny)

folder.address <- getwd()
print(folder.address)
settings <- read.csv(file.path(folder.address, '../settings.txt'), 
                     sep=',', quote='"', header=T, stringsAsFactors=F)

if (is.null(settings$location) || is.null(settings$name)) {
	print('Cannot find data. Specify a location and data frame in settings.txt')
	quit()
}

# the dataset named below must exist in the RData file loaded from data location
load(settings$location)
dataset <- eval(parse(text=settings$name))

runApp(folder.address, launch.browser=TRUE)
