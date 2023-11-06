
library(shiny)
library(shinydashboard)

DashboardPage <- dashboardPage(
DashboardHeader <- dashboardHeader(title = "NCAA Basketball"),
Sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Home", tabName = "Home"),
    menuItem("Confrences", tabName = "Conferences")
  )
),
<<<<<<< HEAD
dashboardBody()
)
=======

dashboardBody()

)

            
>>>>>>> f27915d10ee656e3646271f4dace0dc9013d596b
