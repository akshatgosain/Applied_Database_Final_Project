
# Load data and libraries -------------------------------------------
#install.packages("shiny")

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


# Load data  -------------------------------------------

source("ui.R")
source("server.R")


# Create shiny application ------------------------------------------
shinyApp(ui = ui, server = server)





