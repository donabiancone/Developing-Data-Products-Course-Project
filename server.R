#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

source("utils.R")

# Define server logic required to draw a map
shinyServer(function(input, output) {
  
  df <- within(df, {
  PopUp <- paste0("<strong style='color:blue;font-size:14px'>", df$Branch.Name, "</strong>", "<br>",
                  "<strong>Address: </strong>", df$Address, "<br>",
                  "<strong>ZIP Code: </strong>", df$Postal.Code, "<br>",
                  "<strong>Telephone: </strong>", df$Telephone, "<br>",
                  "<strong>Neighborhood: </strong>", df$NBHD.Name, "<br>",
                  "<strong>Region: </strong>", df$Ward.Region, "<br>",
                  "<strong>Collection Size: </strong>", df$Collection.Size, "<br>",
                  "<strong>Public Parking Spaces: </strong>", df$Public.Parking.Spaces)
  })
  
  output$region <- renderUI({
    selectInput("region", "Ward Region:", regions)
  })
  output$hours <- renderUI({
    sliderInput("hours", "Hours Open per Week (incl. Sundays):", minHours, maxHours, c(minHours, maxHours))
  })
  output$pc <- renderUI({
    sliderInput("pc", "Public PCs with Internet Access:", minPC, maxPC, c(minPC, maxPC))
  })
  output$seating <- renderUI({
    sliderInput("seating", "Seating:", minSeating, maxSeating, c(minSeating, maxSeating))
  })
  output$publicTransit <- renderUI({
    checkboxGroupInput("publicTransit", "Distance from Public Transit:", unique(publicTransit), selected = publicTransit)
  })
  output$map <- renderLeaflet({
    leaflet(df) %>%
      addTiles() %>%
      setView(lng = mean(df$longitude), lat = mean(df$latitude), zoom = 11) %>%
      addMarkers(data = df, lng = ~ longitude, lat = ~ latitude, popup = df$PopUp)
  })
  output$dTable <- renderDataTable({
    df[, !(names(df)) %in% "PopUp"]
  }, options = list(scrollX = TRUE))
  
  observe({
    wardRegion <- input$region
    hoursOpenWeek <- input$hours
    pcNo <- input$pc
    seatingNo <- input$seating
    distanceTransit <- input$publicTransit
    
    filteredData <- df
    
    if("" %in% wardRegion | is.null(wardRegion)) filteredData <- df
      else filteredData <- filteredData[regions %in% wardRegion,]
  
    filteredData <- subset(filteredData, (
                         hoursOpen>=hoursOpenWeek[1] & hoursOpen<=hoursOpenWeek[2] &
                         PCs>=pcNo[1] & PCs<=pcNo[2] &
                         seatNo>=seatingNo[1] & seatNo<=seatingNo[2] &
                         publicTransit %in% distanceTransit
                         ))
        
    leafletProxy("map", data=filteredData) %>%
      clearMarkers() %>%
      addMarkers(data=filteredData, lng = ~ longitude, lat = ~ latitude, popup = filteredData$PopUp)
    
    output$dTable <- renderDataTable(filteredData[, !(names(df)) %in% "PopUp"], options = list(scrollX = TRUE))
  })
  
  observeEvent(input$reset, {
    shinyjs::reset("side-panel")
  })
})
