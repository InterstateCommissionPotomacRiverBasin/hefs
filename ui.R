## app.R ##
library(shinydashboard)
library(shiny)
library(dygraphs)

ui <- dashboardPage(
  dashboardHeader(title = "HEFS Exploration"),
  dashboardSidebar(sidebarMenu(
    menuItem("Point of Rocks", tabName = "por_tab", icon = icon("plus", lib = "glyphicon")),
    menuItem("Little Falls", tabName = "lf_tab", icon = icon("plus", lib = "glyphicon"))
    )),
  dashboardBody(
    tabItems(
      tabItem(tabName = "por_tab",
              fluidRow(
                box(dygraphOutput("por_quant"), width=9),
                box(textOutput("por_legend_quant"), title = "Legend", collapsible = TRUE, width=3),
                box(dygraphOutput("por_index"), width=9),
                box(textOutput("por_legend_index"), title = "Legend", collapsible = TRUE, width=3)
                
              )
      ),
      tabItem(tabName = "lf_tab",
              fluidRow(
                box(dygraphOutput("lf_quant"), width=9),
                box(textOutput("lf_legend_quant"), title = "Legend", collapsible = TRUE, width=3),
                box(dygraphOutput("lf_index"), width=9),
                box(textOutput("lf_legend_index"), title = "Legend", collapsible = TRUE, width=3)
              )
      )
    )
  )
)
