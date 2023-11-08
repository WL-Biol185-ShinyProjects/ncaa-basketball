
library(shiny)
library(shinydashboard)

DashboardPage <- dashboardPage(
  skin = "red",
DashboardHeader <- dashboardHeader(title = "NCAA Basketball", titleWidth = 300),
Sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Home", tabName = "Home"),
    menuItem("Conferences", tabName = "Conferences")
  )
),

body<-dashboardBody(
 
   tabItems(
  tabItem(tabName = "Home",
           h2("Welcome!"),
          box(background = "orange", p(" Here is the data!"))
           )
   ),
  
  tabItem(tabName = "Conferences",
           h2("Conferences")
           ),
  
  
#conference tab 
tabItem(tabName= "Conferences",
fluidPage(box(background = "blue", width = 12, p("This page shows the NCAA statistics separated by conference, Press on all of the tabs to explore different things!")
             )), 
  selectInput("Conferences"),
  plotOutput("Free Throws")



  
  
)
 
  
  )
)


