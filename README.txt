This aplication attempts to abstract some of the most general data exploration needs to a single interactive web app.
Using ggplot to organize and render graphics and shiny for its rich web app utilities, the exploration stage of
data analysis is organized into a one-stop shop. See 1 (1 continuous) to 5 (2 continuous and 3 categorical) 
dimensions at once by plotting either x data alone (histogram or frequency plot) or x versus y (scatterplot)
while each can be augmented with three other pieces of data stratified by color, and/or rows, and/or columns.
Continuous variables may be transformed and continuous or categorical variables may be specified by the user or,
if not specified manually will be interpreted from the classes of the columns in the data frame. In addition, the
sample size can be specifed by slider and jittering, and linear and nonlinear fittings are specifiable via checkboxes.

Sample workflow:
----------------
(1) Load your data into a data frame prepare and 
(2) Prepare by Giving all your data appropriate classes; especially distinguish between numeric and factors
(3) save as an archive (<something>.RData) and edit settings.txt to point at the archive and the data.frame inside
(3) Specify variables to ignore in runDataExplorer.R's variable ignore.names and if you want to explicity fix the 
	datatype of any variable, do so here also
(4) Run the startup script and start visualizing

Instructions:
-------------

(1) Downloading

	Checkout this repository
	
(2) Running / Installation

	(i)  Edit the appropriate files as mentioned above (at least settings.txt in order to point at your R data frame). 
	(ii) Run the appropriate shell script for your system or run the R script runDataExplorer from your command line.
