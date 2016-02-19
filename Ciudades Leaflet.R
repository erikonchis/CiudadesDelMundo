library (shiny)
library (leaflet)
setwd("/home/erika/Desktop/Practice")
#coords = read.csv("worldcitiespop.csv", header=T, sep=',')
ui<- fluidPage(
  leafletOutput("ciudades"),
  sliderInput("num", "Selecciona el número de ciudades a buscar", min=1, max=250, value=100),
  actionButton("actualiza", "Busca nuevas ciudades")
)

server<-function(input, output){
  muestra <- eventReactive(input$actualiza, {coords[runif(input$num, 1, nrow(coords)),]}
                           )
  output$ciudades<-renderLeaflet(
    leaflet() %>%
      addProviderTiles("Stamen.TonerLite",
                       options = providerTileOptions(noWrap=TRUE)
      ) %>%
      addMarkers(data=muestra(), lng=~Longitude, lat=~Latitude, popup=~City)
  )
}

shinyApp(ui, server)
