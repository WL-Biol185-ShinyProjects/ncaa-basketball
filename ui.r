
library(shiny)
library(shinydashboard)

dashboardPage(
  dashboardHeader(title = "NCAA Basketball"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "page1"),
      menuItem("Success by Conference", tabName = "page2")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "page1", p("Welcome to our website on NCAA Men's Basketball!")),
      tabItem(tabName = "page2", p("Free Throws"))
    )
  )
)