
library(shiny)
library(shinydashboard)

dashboardPage(
dashboardHeader(title = "NCAA Basketball"),
dashboardSidebar(),
dashboardBody(
  
        fluidRow(
          box(plotOutput("plot1", height = 250)),
          
          box(
            title = "Controls",
            sliderInput("slider", "Number of observations:", 1, 100, 50)
          )
        )
  )
  )

            
            
