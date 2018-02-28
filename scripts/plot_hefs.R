library(tidyverse)
library(xts)
library(dygraphs)
#------------------------------------------------------------------------------
por.df <- data.table::fread("data/hefs_por.csv") %>% 
  select('ns1:stationName', 'ns1:ensembleMemberIndex', date6, time7, value, flag) %>% 
  rename(station = 'ns1:stationName',
         index = 'ns1:ensembleMemberIndex',
         date = date6,
         time = time7) %>% 
  mutate(date_time = paste(date, time),
         date_time = as.POSIXct(date_time, format = "%m/%d/%Y %H:%M:%S")) %>% 
  select(date_time, index, value)
#------------------------------------------------------------------------------
por.index <- por.df %>% 
  spread(index, value)

xts(por.index[, -1], order.by = por.index[, 1]) %>% 
  dygraph(group = "test") %>% 
  dyHighlight(highlightSeriesOpts = list(strokeWidth = 3)) %>% 
  dyRangeSelector(height = 20) %>% 
  dyLegend(width = 100,
           labelsSeparateLines = TRUE)
#------------------------------------------------------------------------------
por.quant <- por.df %>% 
  group_by(date_time) %>% 
  summarize(min = min(value),
            'quant_5' = quantile(value, 0.05),
            'quant_25' = quantile(value, 0.25),
            median = quantile(value, 0.50),
            'quant_75' = quantile(value, 0.75),
            'quant_95' = quantile(value, 0.95),
            max = max(value)) %>% 
  ungroup() %>% 
  data.frame()



xts(por.quant[, -1], order.by = por.quant[, 1]) %>% 
  dygraph(group = "test") %>% 
  dyHighlight(highlightSeriesOpts = list(strokeWidth = 3)) %>% 
  dyRangeSelector(height = 20) %>% 
  dyLegend(width = 100,
           labelsSeparateLines = TRUE)
#------------------------------------------------------------------------------
