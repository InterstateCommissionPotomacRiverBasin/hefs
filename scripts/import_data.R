#por.df <- import_hefs("data/hefs_por.csv")
file.dir <- "data/hefs_por.gz"
por.df <- xml_to_df("data/hefs_por.gz")
por.index <- spread(por.df, index, value)
por.quant <- calc_quant(por.df)
#------------------------------------------------------------------------------
#lf.df <- import_hefs("data/hefs_lf.csv")
lf.df <- xml_to_df("data/hefs_lf.gz")
lf.index <- spread(lf.df, index, value)
lf.quant <- calc_quant(lf.df)