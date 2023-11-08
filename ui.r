
library(shiny)
library(leaflet)
library(shinydashboard)

dashboardPage(
<<<<<<< HEAD
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
 
  
  



=======
  dashboardHeader(title = "NCAA Basketball"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "page1"),
      menuItem("Success by Conference", tabName = "page2")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "page1", p("Free Throws")),
      tabItem(tabName = "page2", p("Percent Win"))
    )
  )
)
>>>>>>> 8ad66174ebb276017537e7af70014cf9f17e8f9e
