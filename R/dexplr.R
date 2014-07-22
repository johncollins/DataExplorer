#' Explore a data frame visually
#' 
#' Explore my dataset visually using an interactive shiny app
#' @param dataset a data frame to explore
#' @keywords shiny exploratory explore visualize 5D 5d five-dimensional
#' @export
#' @examples 
#' library(MASS)
#' dexplr(Aids2)

dexplr <- function(dataset) {
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
  
  require(shiny)
  require(ggplot2)
  
  shinyApp(ui = pageWithSidebar(
    
    headerPanel("Data Explorer"),
    
    sidebarPanel(
      
      sliderInput('sampleSize', 'Sample Size', min=1, max=nrow(dataset),
                  value=min(1000, nrow(dataset)), step=50, round=0),
      
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
        p <- ggplot(df, aes_string(x=input$x, y=input$y)) + geom_point()
        
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
          p <- ggplot(df, aes_string(x=input$x)) + geom_freqpoly()
        }
        else {
          p <- ggplot(df, aes_string(x=input$x)) + geom_histogram(fill='magenta', alpha=0.3)
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
      
      output$downloadPlot <- downloadHandler(
        filename = function(){file.path(getwd(), 'tmp.png')},
        content = function(file) {
          png(file)
          print(p)
          dev.off()
        })
      
    }, height=400)
    
  })
}