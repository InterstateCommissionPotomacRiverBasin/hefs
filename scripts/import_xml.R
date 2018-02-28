
library(XML)
file.dir <- "C:/Users/zsmith/Desktop/2018022712_PORM2POT_hefs_export.xml/2018022712_PORM2POT_hefs_export.xml"
doc = xmlParse(system.file("exampleData", file.dir, package = "XML"))

els = getNodeSet(doc, "/doc//a[@status]")
sapply(els, function(el) xmlGetAttr(el, "status"))

test = xmlInternalTreeParse(file.dir)
df <- xmlToDataFrame(test)
xml.p <- xmlParse(file.dir)
nodes <- xmlRoot(xml.p)




xml.list <- xmlToList(file.dir, simplify = TRUE)
xml.list$series["header"] <- NULL
xml.list["timeZone"] <- NULL

test <- purrr::map_df(xml.list, data.frame)


df <- xmlToDataFrame(nodes = getNodeSet(xml.p, "//xml.p/series/event"))

nodes[2]
test <- XML::getChildrenStrings(xml.p)
test <- purrr::map_df(nodes, data.frame)
test3 <- xmlToDataFrame(nodes)
detaildf<-xmlToDataFrame(nodes = getNodeSet(test2, "/datainfo/data/item"))
xmltop  <- xmlRoot(parsed.xml)
xmltop[1]
test2 <- purrr::map_df(xmlToList(file.dir), function(list.i) {
  test1 <- as.data.frame(test3$series$header)
  test1 <- as.data.frame()
})
test3 <- xmlToList(file.dir, simplify = TRUE)
test <- purrr::map_df(xmlToList(file.dir), function(x) data.frame(x))
test3[1]
test3$series[1]
bind_rows(test3$series$event)
test4 <- test3$series
test4["header"] <- NULL
test5 <- t(data.frame(test4))
test5 <- bind_rows(xmlToList(file.dir)$series)
test <- do.call(c, unlist(test3, recursive=FALSE))
test2 <- data.frame(test)
