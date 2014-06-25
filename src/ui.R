shinyUI(pageWithSidebar(
 
  headerPanel("Data Explorer"),
  
  sidebarPanel(
 
    sliderInput('sampleSize', 'Sample Size', min=1, max=nrow(dataset),
                value=min(1000, nrow(dataset)), step=500, round=0),
    
    selectInput('x', 'X', continuous.names),
	selectInput('xtrans', 'X Transformation',c('None', 'log10', 'log2', 'log', 'sqrt')),
    selectInput('y', 'Y', c('None', continuous.names)),
	selectInput('ytrans', 'Y Transformation',c('None', 'log10', 'log2', 'log', 'sqrt')),
    
    checkboxInput('jitter', 'Jitter'),
    checkboxInput('smooth', 'Smooth'),
	  checkboxInput('line', 'Line'),
  
	  selectInput('color', 'Color', c('None', categorical.names)),  
    selectInput('facet_row', 'Facet Row', c(None='.', categorical.names)),
    selectInput('facet_col', 'Facet Column', c(None='.', categorical.names))
  ),
 
  mainPanel(
    plotOutput('plot')
  )
))