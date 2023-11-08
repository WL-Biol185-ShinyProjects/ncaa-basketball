
library(shiny)
library(leaflet)
library(shinydashboard)

dashboardPage(
  skin = "purple",
dashboardHeader(title = "NCAA Basketball", titleWidth = 300),
dashboardSidebar(
  sidebarMenu(
    menuItem("Introduction", tabName = "Introduction"),
    menuItem("Conferences", tabName = "Conferences")
  )
),
dashboardBody(
 
# Introduction Page 
  tabItems(
  tabItem("Introduction", tabName = "Introduction"),
           h2("Welcome!"),
          box(background = "blue", p(" Here is the data!"))
           )
   ),
  
# Conference Page 
  tabItem("Conferences", tabName = "Conferences"),
           h2("Conferences"),
           )
#Conferences tab 
tabItem(tabName = "Conferences",
fluidPage(box(width = 12, p("This page shows the NCAA statistics separated by conference, Press on all of the tabs to explore different things!")
             )), 



  
  
)
 
  
  



