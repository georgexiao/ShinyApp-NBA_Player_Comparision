## This is the server file for NBA player comparision.
## This app is to created for the coursera course "Developing Data Product"
## Created by George Xiao on 7/23/16
## Last modified by George Xiao on 7/28/16
## -------------------------------------------------------------------------


library(shiny)
library(SportsAnalytics)
library(ggplot2)


##  Use Bar Chart to compare 
shinyServer(function(input, output) {
   
  # --- Retrieve nba data by season based on users' input
  selectedDataAll <- reactive({
    temp <- fetch_NBAPlayerStatistics(input$season)
    temp[order(-temp$TotalPoints, -temp$GamesPlayed),]
  })
  
  # --- Create dynamic drop-down selection for playerA
  output$playerDropdownA <- renderUI({
    selectInput("PlayerA", label = h4("Select Player A"), 
                choices = as.list(as.character(unique(selectedDataAll()$Name))), 
                # select 1st player
                 selected = as.list(as.character(unique(selectedDataAll()$Name)))[1],
                selectize = TRUE, 
                multiple = FALSE)
  })
    
    # --- Create dynamic drop-down selection for playerB
    output$playerDropdownB <- renderUI({
      selectInput("PlayerB", label = h4("Select Player B"), 
                  choices = as.list(as.character(unique(selectedDataAll()$Name))), 
                  # select 2nd player
                  selected = as.list(as.character(unique(selectedDataAll()$Name)))[2],
                  selectize = TRUE, 
                  multiple = FALSE)
  })
  
    # --- Subset data based on input (player & stats)
    plotData <- reactive({
      tempdf = data.frame()
      if (input$dataType == "Total") {
        playerA <- subset(selectedDataAll(), Name == input$PlayerA, select = c("Name", "GamesPlayed", input$stats))
        playerB <- subset(selectedDataAll(), Name == input$PlayerB, select = c("Name", "GamesPlayed",input$stats))
        tempdf <- rbind(playerA, playerB)
      } 
      else if (input$dataType == "Average") 
        {
        playerA <- subset(selectedDataAll(), Name == input$PlayerA, select = c("Name", "GamesPlayed",input$stats))
        playerA[, input$stats] <- playerA[, input$stats]/playerA$GamesPlayed
        playerB <- subset(selectedDataAll(), Name == input$PlayerB, select = c("Name", "GamesPlayed",input$stats))
        playerB[, input$stats] <- playerB[, input$stats]/playerB$GamesPlayed
        tempdf <- rbind(playerA, playerB)
      }
      
      # reshape the date from "wide" to "long"
      newdf <- reshape(tempdf, varying = input$stats,
                          v.names = "NBA_Stats",
                          timevar = "Stats_Type",
                          times = input$stats,
                          new.row.names = 1:10000,
                          direction = "long")
      newdf
    })
    
    # --- Create Bar Charts
    output$plot <- renderPlot({
      p <- ggplot(plotData(), aes(x=Stats_Type, y=NBA_Stats, fill=Name)) +
        geom_bar(position="dodge", stat="identity") +
        theme(axis.text=element_text(size=15),
              axis.title=element_text(size=17,face="bold"),
              legend.text=element_text(size=15)) +
        geom_text(aes(label=sprintf("%.02f", NBA_Stats)), 
                  position=position_dodge(width=0.9), 
                  vjust=-0.25, size=6)
        
      print(p)
    })
    
    
    # --- Download Data
    output$downloadData <- downloadHandler(
      filename = function() { 
        paste(paste(input$PlayerA, input$PlayerB, sep = " VS "), 
              ".csv", sep = "")
      },
      content = function(file) {
        write.csv(plotData(), file)
      }
    )
    
    # --- Download Plot
    output$downloadPlot <- downloadHandler(
      filename = function() { 
        paste(paste(input$PlayerA, input$PlayerB, sep = " VS "),
              ".pdf", sep = "")
      },
      content = function(file) {
        pdf(file)  # open the pdf device
        thisplot <- plotData()
        
          p <- ggplot(thisplot, aes(x=Stats_Type, y=NBA_Stats, fill=Name)) +
            geom_bar(position="dodge", stat="identity") +
            geom_text(aes(label=sprintf("%.02f", NBA_Stats)), position=position_dodge(width=0.9), vjust=-0.25)
          print(p)
          
        dev.off()  # turn the device off
      }
    )
    
})
