shinyServer(function(input, output) {
  
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
    
    if (input$color != 'None')
      p <- p + aes_string(color=input$color)
    
    facets <- paste(input$facet_row, '~', input$facet_col)
    if (facets != '. ~ .')
      p <- p + facet_grid(facets)
    
    print(p)
    
  }, height=700)
  
})