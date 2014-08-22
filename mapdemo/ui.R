
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)

shinyUI(pageWithSidebar(
  
  headerPanel("India Administrative Areas"),
  
  sidebarPanel(  
    
    
    selectInput('reg', 'Please wait...downloading the map.\nSelect Region to Highlight:', c("Andhra Pradesh","Assam","Bihar","Gujarat","Haryana","Himachal Pradesh","Jharkhand","Karnataka","Kerala","Madhya Pradesh","Maharashtra","Orissa","Punjab","Rajasthan","Tamil Nadu","Uttaranchal","Uttar Pradesh","West Bengal" ))
    ),
    
    mainPanel( 
      plotOutput('plot')
    )
  )
)

