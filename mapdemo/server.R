
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(maps)     
library(ggplot2)	
library(sp)
# options(shiny.cache=TRUE)
shinyServer(function(input, output) {
  
  con <- url("http://gadm.org/data/rda/IND_adm1.RData")  # Get map of India from GADM
  # print(load(con))	# Load the map
  load(con)
  close (con)
  US_map.ff <- fortify(gadm)		# Create ggplot compatible data.frame
  
  # Extract polygon corners and merge with shapefile data
  gadm@data$id <- rownames(gadm@data)
  
  US_map.df <- merge(gadm@data, US_map.ff, by = "id", all.y = TRUE)
  
  output$plot <- reactivePlot(function() {
  usa.selected_regions <- input$reg  #c(input$reg1, input$reg2)
  #Build up the plot
  p1 <- ggplot() + 
    theme_bw() + theme(panel.border = element_blank(),
                       panel.grid.major = element_blank(),
                       panel.grid.minor = element_blank())
  p3 <- p1 + 
     ggtitle("GADM Level 1 Map of India - Selected Regions Highlighted") +
     geom_path(data = US_map.df, aes(x = long, y = lat, group = group)) +
     geom_polygon(data = subset(US_map.df, NAME_1 %in% usa.selected_regions),		
                  aes(x = long, y = lat, group = group, fill = NAME_1))
  p3	# Plot selected regions
  
  }, height=700)
})
