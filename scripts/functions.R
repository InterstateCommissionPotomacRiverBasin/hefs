#------------------------------------------------------------------------------
prep_hefs <- function(x) {
  x %>% 
    dplyr::rename_all(tolower) %>% 
    dplyr::mutate(date_time = paste(date, time),
                  date_time = as.POSIXct(date_time, format = "%Y-%m-%d %H:%M:%S"),
                  value = as.numeric(value)) %>% 
    dplyr::rename(index = ensemblememberindex) %>% 
    dplyr::select(date_time, index, value)
}
#------------------------------------------------------------------------------
xml_to_df <- function(file.dir) {
  xml.parse <- XML::xmlParse(file.dir)
  xml.root <- XML::xmlRoot(xml.parse)
  
  xml.series <- xml.root[names(xml.root) == "series"]
  
  final.df <- purrr::map_df(seq(length(xml.series)), function(x) {
    #index.scalar <- XML::getChildrenStrings(xml.series[x]$series["header"]$header)["ensembleMemberIndex"]
    header.df <- XML::xmlToDataFrame(xml.series[x]$series["header"], stringsAsFactors = FALSE) %>% 
      mutate(group = 1)
    
    event.list <- XML::xmlToList(xml.series[x]$series)
    event.list <- event.list[names(event.list) == "event"] 
    names(event.list) <- paste0("event", seq(length(names(event.list))))
    event.df <- tibble::enframe(event.list) %>% tidyr::unnest()
    event.df <- as.data.frame(event.list, stringsAsFactors = FALSE) %>% 
      tibble::rownames_to_column() %>% 
      tidyr::gather(event, value, -rowname) %>% 
      tidyr::spread(rowname, value) %>% 
      dplyr::select(-event) %>% 
      dplyr::mutate(group = 1)
    
    dplyr::right_join(header.df, event.df, by = "group") %>% 
      dplyr::select(-group)
  }) %>% 
    prep_hefs()
  
  return(final.df)
}

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