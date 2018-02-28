por.df <- import_hefs("data/hefs_por.csv")
por.index <- spread(por.df, index, value)
por.quant <- calc_quant(por.df)
#------------------------------------------------------------------------------
lf.df <- import_hefs("data/hefs_lf.csv")
lf.index <- spread(lf.df, index, value)
lf.quant <- calc_quant(lf.df)