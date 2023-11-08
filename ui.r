
library(shiny)
library(leaflet)
library(shinydashboard)

dashboardPage(
  skin = "purple",
  dashboardHeader(title = "NCAA Basketball"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "page1"),
      menuItem("Conference Statistics", tabName = "page2")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "page1", p("Home"),
      h2("Welcome!"),
      box(background = "purple", p("Introduction!"))
      
      ),
      tabItem(tabName = "page2", p("Conference Statistics"))
    )
  )
)

