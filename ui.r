
library(shiny)
library(shinydashboard)

DashboardPage <- dashboardPage(
DashboardHeader <- dashboardHeader(title = "NCAA Basketball"),
Sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Home", tabName = "Home"),
    menuItem("Free Throws", tabName = "Free Throws")
  )
),
dashboardBody()
)
