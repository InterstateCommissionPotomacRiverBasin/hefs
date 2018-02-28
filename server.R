server <- function(input, output) {
  
  output$por_index <- renderDygraph({
    withProgress(message = "Loading...", {
      xts(por.index[, -1], order.by = por.index[, 1]) %>% 
        dygraph(group = "por") %>% 
        dyHighlight(highlightSeriesOpts = list(strokeWidth = 3)) %>% 
        dyRangeSelector(height = 20) %>% 
        dyLegend(labelsDiv = "por_legend_index")
    })
  })
  
  output$por_quant <- renderDygraph({
    withProgress(message = "Loading...", {
      xts(por.quant[, -1], order.by = por.quant[, 1]) %>% 
        dygraph(group = "por") %>% 
        dyHighlight(highlightSeriesOpts = list(strokeWidth = 3)) %>% 
        dyRangeSelector(height = 20) %>% 
        dyLegend(labelsDiv = "por_legend_quant",
                 labelsSeparateLines = TRUE)
    })
  })
  
  output$lf_index <- renderDygraph({
    withProgress(message = "Loading...", {
      xts(lf.index[, -1], order.by = lf.index[, 1]) %>% 
        dygraph(group = "lf") %>% 
        dyHighlight(highlightSeriesOpts = list(strokeWidth = 3)) %>% 
        dyRangeSelector(height = 20) %>% 
        dyLegend(labelsDiv = "lf_legend_index")
    })
  })
  
  output$lf_quant <- renderDygraph({
    withProgress(message = "Loading...", {
      xts(lf.quant[, -1], order.by = lf.quant[, 1]) %>% 
        dygraph(group = "lf") %>% 
        dyHighlight(highlightSeriesOpts = list(strokeWidth = 3)) %>% 
        dyRangeSelector(height = 20) %>% 
        dyLegend(labelsDiv = "lf_legend_quant",
                 labelsSeparateLines = TRUE)
    })
  })
}