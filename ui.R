#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyjs)
library(leaflet)

# Define UI for application that draws a map
shinyUI(navbarPage("Toronto Public Library Branch Location",
  
  # Application title
  tabPanel(p(icon("search"), "Search Branch"),
  
  # Sidebar  
    sidebarPanel(
       shinyjs::useShinyjs(),
       id = "side-panel",
       uiOutput("region"),
       uiOutput("hours"),
       uiOutput("pc"),
       uiOutput("seating"),
       uiOutput("publicTransit"),
       actionButton("reset", "Reset All", icon = icon("trash"))
    ),
    
    # Show an interactive map of results
    mainPanel(
       tabsetPanel(
         #Map
         tabPanel(p(icon("map-marker"), "Map"),
           leafletOutput("map", width = "100%", height="560")
         ),
         tabPanel(p(icon("table"), "Dataset"),
           dataTableOutput("dTable")
         )
       )
    )
  ),
  tabPanel("About",
    mainPanel(
      includeMarkdown("about.md")
    )
  )
))
