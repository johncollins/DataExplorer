#' Explore a data frame visually
#' 
#' Explore my dataset visually using an interactive shiny app
#' @param dataset a data frame to explore
#' @param ignore.names column names to ignore in exploration
#' @param categorical.names column names to treat as categorical (discrete)
#' @param continuous.names column names to treat as continuous
#' @keywords shiny exploratory explore visualize 5D 5d five-dimensional
#' @import ggplot2 shiny
#' @export
#' @examples 
#' \dontrun{
#' library(MASS)
#' dexplr(Aids2)
#' q(save='no')
#' }

dexplr <- function(dataset, ignore.names=c(), categorical.names = c(), continuous.names = c()) {
  
  classes.names <- lapply(dataset, function(x)class(x))
  if (is.null(ignore.names)) {
    ignore.names = filter.by.type(dataset, classes.names, c('character'))
  }
  if (is.null(categorical.names)) {
    categorical.names = filter.by.type(dataset, classes.names, c('ordered', 'logical', 'factor'))
  }
  if (is.null(continuous.names)) {
    continuous.names = filter.by.type(dataset, classes.names, c('integer', 'numeric', 'Date', 'ordered'))
  }
  
  shinyApp(ui = pageWithSidebar(
    
    headerPanel(paste("explr-ing", deparse(substitute(df)))),
    
    sidebarPanel(
      
      sliderInput('sampleSize', 'Sample Size', min=1, max=nrow(dataset),
                  value=min(1000, nrow(dataset)), step=1, round=F),
      
      selectInput('x', 'X', continuous.names),
      selectInput('xtrans', 'X Transformation',c('None', 'log10', 'log2', 'log', 'sqrt')),
      selectInput('y', 'Y', c('None', continuous.names)),
      selectInput('ytrans', 'Y Transformation',c('None', 'log10', 'log2', 'log', 'sqrt')),
      
      checkboxInput('jitter', 'Jitter'),
      checkboxInput('smooth', 'Smooth'),
      checkboxInput('line', 'Line'),
      
      selectInput('color', 'Color', c('None', categorical.names)),  
      selectInput('facet_row', 'Facet Row', c(None='.', categorical.names)),
      selectInput('facet_col', 'Facet Column', c(None='.', categorical.names)),

      downloadButton('downloadPlot', 'Download Plot')
    ),
    
    mainPanel(
      plotOutput('plot')
    )
  ),
  server = function(input, output) {
    
    get_dataset <- reactive({
      dataset[sample(nrow(dataset), input$sampleSize),]
    })
    
    output$plot <- renderPlot({
      
      df <- get_dataset()
      
      if (input$y != 'None') {
        p <- ggplot(df, aes_string(x=input$x, y=input$y), na.rm=T) + geom_point()
        
        if (input$ytrans != 'None') {
          p <- p + scale_y_continuous(trans=input$ytrans)
        }
        
        if (input$jitter)
          p <- p + geom_jitter()
        
        if (input$smooth){
          p <- p + geom_smooth()
        }
        if (input$line) {
          p <- p + geom_smooth(method='lm')
        }
      }
      else {
        if (input$color != 'None') {
          p <- ggplot(df, aes_string(x=input$x), na.rm=T) + geom_freqpoly()
        }
        else {
          p <- ggplot(df, aes_string(x=input$x), na.rm=T) + geom_histogram(fill='magenta', alpha=0.3)
        }
      }
      
      if (input$xtrans != 'None') {
        p <- p + scale_x_continuous(trans=input$xtrans)
      }
      
      if (input$color != 'None') {
        p <- p + aes_string(color=input$color)
      }
      
      facets <- paste(input$facet_row, '~', input$facet_col)
      if (facets != '. ~ .') {
        p <- p + facet_grid(facets)
      }
      
      print(p)
      
      # Allow the plot to be downloaded to the user's machines
      output$downloadPlot <- downloadHandler(
        filename = function(){'tmp.png'},
        content = function(file) {
          png(file)
          print(p)
          dev.off()
        })
      
    }, height=400)
    
  })
}
