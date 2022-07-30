#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#



# Load libraries, data ------------------------------------------------
library(shiny)
library(DBI)
library(RSQLite)
library(shinythemes)
library(shinyWidgets)
library(shinyalert)
library(DT)
library(forecast)
library(ggplot2)
library(plotly)
library(maps)
library(leaflet)



volcanodata = read.csv("volcanoevents.csv")



# Create server -------------------------------------------------------
server <- function(input, output) {

output$plot10 = renderPlotly({
    plot_ly(volcanodata, lon = volcanodata$Longitude, lat = volcanodata$Latitude,  hoverinfo = 'volcanodata$Country',color = 'volcanodata$Type', 
            marker = list(size = 10),
            type = 'scattergeo',
            locationmode = 'natural earth') %>%
      layout(title = 'Locations')
})
  
  
  
  
  output$plot <- renderPlot({
  req(input$Country)
  volcanodata$Type <- factor(volcanodata$Type, 
                             levels = unique(volcanodata$Type[order(volcanodata$Country)]))
  req(volcanodata$Type)
  ggplot(data=volcanodata, aes_string(x="Type", y='input$Country', fill="Country")) +
    geom_bar(stat="identity", width=0.8) +
    labs(x="Type", y=input$Country) + coord_flip()
  
})

req(volcanodata$Total_Deaths)
output$plot2 <- renderPlot({
ggplot(data=volcanodata, aes_string(x = 'volcanodata$Country', y = volcanodata$Total_Deaths)) +
  geom_col(width = 1, fill = "darkred") +
  theme(axis.text.x = element_text(angle = 90, size = 10))+ 
  labs(
    x = "Country",
    y = "Number of Deaths",
    title = stringr::str_glue("Volcano Deaths")
    
  )
})


output$plot3 <- renderPlot({
  ggplot(data=volcanodata, aes_string(x='volcanodata$Country', y='volcanodata$Tsunami_Event')) +
    geom_bar(binwidth = 10, colour = "steelblue4", fill = "steelblue3", stat = "identity" ) +
    theme(axis.text.x = element_text(angle = 90, size = 10))+
    xlab("Country")+
    ylab("Total Volcano-Tsunami Events")
})

#output$plot4 = renderPlot({
#  return(hist(volcanodata$VEI, main  = "Histogram", xlab = volcanodata$Type))
#})

output$plot4 = renderPlot({
ggplot(volcanodata, aes_string('volcanodata$Type', volcanodata$VEI)) + stat_boxplot() +
    theme(axis.text.x = element_text(angle = 90, size = 10))+
    xlab("Volcano Type")+
    ylab("Explosivity Index")
})

output$plot5 = renderPlot({
ggplot(volcanodata, aes(volcanodata$Type)) +
  geom_histogram(stat="Count") +
    theme(axis.text.x = element_text(angle = 90, size = 10))+
    xlab("Volcano Type")
})


output$plot6 = renderPlot({
  ggplot(volcanodata, aes(volcanodata$Location)) +
    geom_histogram(stat="Count") +
    theme(axis.text.x = element_text(angle = 90, size = 10))+
    xlab("Location")
})


output$plot7 = renderPlot({
  ggplot(volcanodata, aes(volcanodata$VEI)) +
    geom_histogram(stat="Count") +
    theme(axis.text.x = element_text(angle = 90, size = 10))+
    xlab("Explosivity Index VEI")
})

output$plot8 = renderPlotly({
plot_ly(x = volcanodata$VEI,
              type = "histogram",
              histnorm = "probability") %>% 
  layout(title = "Frequency distribution of Explosivity Index",
         xaxis = list(title = "Explosivity Index VEI",
                      zeroline = FALSE),
         yaxis = list(title = "Frequency",
                      zeroline = FALSE))

})


output$scatterplot <- renderPlot({
  ggplot(data = read.csv("volcanoevents.csv")) +
    aes_string(x = volcanodata$Year, y = volcanodata$Total_Deaths, color= 'volcanodata$Country') +
    geom_point()
})


output$plot9 = renderPlotly({
ggplot(volcanodata, aes_string(volcanodata$Year, volcanodata$Total_Deaths))+
  geom_point(aes_string(colour='volcanodata$Country'))+
  geom_smooth(method="lm")+
  xlab("Year")+
  ylab("Total Deaths")
})
 

 
}




# 
# db <- dbConnect(RSQLite::SQLite(), dbname = "tsunamivolcano.db")
# 
# 
# Country <- dbGetQuery(db, 'select DISTINCT Country from TSUNAMIVOLCANO')
# Country
# 
# Country$Country
# 
# #VolcanoType <- dbGetQuery(db, 'select DISTINCT Type from TSUNAMIVOLCANO')
# #VolcanoType


#dbGetQuery(
#  conn = db,
#  statement = 
#    'select DISTINCT Type, Deaths
#    from TSUNAMIVOLCANO' )

#VolcanoType <- dbGetQuery(db, 'select DISTINCT Type from TSUNAMIVOLCANO')
#VolcanoType

#dbGetQuery(
  #  conn = db,
  #  statement = 
  #    'select DISTINCT Country, Type
  #    from TSUNAMIVOLCANO' )
  
  #Country <- dbGetQuery(db, 'select DISTINCT Country from TSUNAMIVOLCANO')
  #Country

