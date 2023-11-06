
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
<<<<<<< HEAD
=======


>>>>>>> ccd53d4c2e813bd31e180e2726c5c996ffc3a610
