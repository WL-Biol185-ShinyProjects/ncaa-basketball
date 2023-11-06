
library(shiny)
library(shinydashboard)

DashboardPage <- dashboardPage(
DashboardHeader <- dashboardHeader(title = "NCAA Basketball"),
Sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Home", tabName = "Home"),
    menuItem("Conferences", tabName = "Conferences")
  )
),

dashboardBody()
)





            

