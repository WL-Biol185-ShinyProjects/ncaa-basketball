
library(shiny)
library(shinydashboard)

  dashboardPage(
  dashboardHeader(title = "NCAA Basketball"),
  dashboardSidebar(),
  dashboardBody(

fluidRow(
box(plotOutput("plot 1", height = 250)),

      box(
        title = "Number of National Championship Wins",



   sliderInput ("slider", "Wins", 1, 25, 10)

    )
  )
)
)




