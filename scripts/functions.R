#------------------------------------------------------------------------------
import_hefs <- function(file.path) {
  data.table::fread(file.path) %>% 
    select('ns1:stationName', 'ns1:ensembleMemberIndex', date6, time7, value, flag) %>% 
    rename(station = 'ns1:stationName',
           index = 'ns1:ensembleMemberIndex',
           date = date6,
           time = time7) %>% 
    mutate(date_time = paste(date, time),
           date_time = as.POSIXct(date_time, format = "%m/%d/%Y %H:%M:%S")) %>% 
    select(date_time, index, value)
}
#------------------------------------------------------------------------------
calc_quant <- function(x) {
  x %>% 
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
}
#------------------------------------------------------------------------------