# 2017-01-07 in response to Google Groups thread by Jannik Vindelov 
# Response from Stephen McDaniel at PowerTrip Analytics
#
#   Topic: Shiny, hover labels quickly disappear with ggplot output
#             added text info dialogs for current hover and last hover
# Program: app.R 
#    Data: mtcars
#
# Solution requires an initial, non-reactive ggplot object, 
#    an initial reactive plot output object,
#    and an observeEvent for the hover item, this triggers 
#    a graph update with the hover as well as text info dialog updates
#
# License: MIT License
# Attribution, package authors for shiny and ggvis on CRAN.

library(ggplot2)
library(dplyr)
library(shiny)

ui <- basicPage(
  plotOutput("plot1",
     # added options for controlling hover behaviors
     hover = hoverOpts(id = "plot_hover", delay = 100, 
       delayType = "debounce",
       clip = TRUE, nullOutside = TRUE)
  ),
  verbatimTextOutput("last_info"), # last hover location
  verbatimTextOutput("info"), # only when currently hovering
  absolutePanel( # add your organization info/logo here
      bottom = 10,
      right = 10,
      HTML('<a href="http://www.powertripanalytics.com/" target="_new"><span style="color:#CC0000">Power</span><span style="color:#004de6">Trip</span> 
         <span style="color:#009933">Analytics</span></a>	 
	      </span></span>')
   )
)

server <- function(input, output) {
  
   # non-reactive plot object
   mt_plot <- mtcars %>%
      ggplot(aes(x = wt, y = mpg))+
      geom_point()
   
   # start render of plot
   output$plot1 <- renderPlot({mt_plot})
   
   # starting state of info table is blank
   output$info <- renderText({""})

    # plot after mouse over
    # note that other reactive outputs can be contained within
    observeEvent(input$plot_hover, {
        
        # hover tooltip
        hover_data <- nearPoints(mtcars, input$plot_hover) %>% 
           mutate(label = paste("MPG:", mpg, 
              "\nCylinders:", cyl, "\nDisplacement:", disp, 
              "\nHorsepower:", hp, sep = ""))
        
        # hover x and y coordinates
        hover_summary <- paste0("x=", round(input$plot_hover$x, 3), 
           "\ny=", round(input$plot_hover$y, 3))
        
        # output the plot post-startup
        output$plot1 <- renderPlot({
     
          # if hover_data has a row, then add it to geom_label
          if(nrow(hover_data) == 1) {
             mt_plot +
                geom_label(data = hover_data, 
                   aes(label = label), 
                   nudge_x = 0.2
                )
          } else mt_plot # back to original state if no hover_data

       })
       
       # no if else needed for info as it is blank with no hover 
       output$last_info <- renderText({
          paste("Last hover values\n", hover_summary)
       })

       # for current hover value, blank otherwise
       output$info <- renderText({
          if(nrow(hover_data) == 1) {
             paste("Current hover values\n", hover_summary)
          } else ""
       })

    })
  
}

shinyApp(ui, server)