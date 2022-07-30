#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

#install.packages("shiny")
library(shiny)
library(shinythemes)

# Load libraries, data -----------------------------------------------

volcanodata = read.csv("volcanoevents.csv")

# Page 1 - Introduction ----------------------------------------------
intro_panel <- tabPanel(
  "Introduction",
  
  br(),br(),
  titlePanel("Volcano Characteristics"),
  
  img(src = "volcano.jpg", height = 400, width = 800),
  br(), br(),
  
  p("This is an R Shiny app to show how volcano causes tsunamis. And if we are able to predict a Tsunami in time, imagine how many lives 
  we can save. I have created this application with two tabs and 
    interesting visualizations. In the second tab, I have used plots/graphs/charts/histograms in order to explore characteristics of each volcano."),
  br(),
  h2('About The Project'),  
    p("Volcanic tsunamis aren't limited to only a few areas around the globe. Entire ocean coastlines are at risk. This includes the 'Ring of Fire' that wraps around the pacific and central Atlantic. Considering Earth is more than 70% covered in water, and experiencing vigorous plate tectonic shifts, that leaves many coastal populations at risk of tsunamis. Detecting tsunamis caused by volcanic activity is incredibly difficult today.
    This project aims to analyze historic data about volcanos and how they are connected to earthquakes and tsunamis by analyzing attributes about the volcanic event. These attributes include explosion VEI, damage, injuries, date/time, (etc)."),
    br(),
  h2('About The Data'),  
    p("The data is directly reported from the NOAA site.
    The Significant Volcanic Eruption Database is a global listing of over 500 significant eruptions which includes information on the latitude, longitude, elevation, type of volcano, and last known eruption.
    National Geophysical Data Center / World Data Service (NGDC/WDS): NCEI/WDS Global Significant Volcanic Eruptions Database. NOAA National Centers for Environmental Information.
    Considering the lack of technology and tools to measure volcano activity, the data is filtered from year 0 to 2021. No additional filters are applied."),
    br(),
    h2('Objectives:'),
    p("
    •	Which type of volcano has been the deadliest? "),
  p("
    •	Which type of volcano is the most active? By location? VEI? "),
  p("
    •	Which type of volcano tends to trigger tsunamis the most? "),
  
  p(a(href = "https://www.ngdc.noaa.gov/hazel/view/hazards/volcano/event-search", "Data Source (NOAA)")),
  p(a(href = "https://www.kaggle.com/code/kerneler/starter-volcano-tsunami-511690c8-6/data?select=volcano-events0-21.csv", "Data Source (Kaggle)"))
)

req(volcanodata$Country)


# Page 2 - Vizualizations -------------------------------------------

sidebar_content <- sidebarPanel(
  selectInput(
    "Country",
    label = "Country",
    choices = volcanodata$Country,
    selected = "'Greece'"
  )
)

main_content <- mainPanel(
  plotlyOutput("plot10"),
  br(), br(),
  plotOutput("plot"),
  br(),br(),
  plotOutput("plot2"),
  br(),br(),
  plotOutput("plot3"),
  br(),br(),
  plotOutput("plot4"),
  br(),br(),
  plotOutput("plot5"),
  br(),br(),
  plotOutput("plot6"),
  br(),br(),
  plotOutput("plot7"),
  br(),br(),
  plotlyOutput("plot8"),
  br(),br(),
  plotOutput("scatterplot"),
  br(),br(),
  plotOutput("plot9")
)

second_panel <- tabPanel(
  "Visualizations",
  br(),br(),
  titlePanel("What are the characteristics of Volcano?"),
  p("Use the selector input below to choose country, We will show you the different characteristics of volcano recorded through visualizations."),
  sidebarLayout(
    sidebar_content, main_content
  )
)


# User Interface -----------------------------------------------------
ui <- navbarPage(
  title = 'Volcano Events',
  windowTitle = 'Navigation Bar', 
  position = 'fixed-top', 
  collapsible = TRUE, 
  theme = shinytheme('cosmo'), 
  intro_panel,
  second_panel
)