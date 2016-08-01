## This is the server file for NBA player comparision.
## This app is to created for the coursera course "Developing Data Product"
## Created by George Xiao on 7/23/16
## Last modified by George Xiao on 7/28/16
## ---------------------------------------------------------------------------------------------------


library(shiny)

## --- UI body
shinyUI(fluidPage(
  titlePanel("NBA Player Stat Comparison"),
  
  sidebarLayout(
    wellPanel(
      tags$style(
        type = "text/css",
        '#leftPanel { width:450px;
        float:left; overflow-y:scroll; max-height: 850px}'
      ),
      id = "leftPanel",
      
      # --- descriptions
      div(
        "This is a web application to compare two NBA palyers' statistics from season 01-02 to 15-16.
        You can compare points, threes, rebouds, assists, steals, blocks and turnovers."
      ),
      h3("How To Use?"),
      tags$ol(
        tags$li("Select a season from the drop-down list."),
        tags$li(
          "Select a player. The player names are based on the registered nba players list of the season."
        ),
        tags$li("Selet another player."),
        tags$li("Select data type: Average or Total "),
        tags$li(
          "Select the statistics you want to compare, e.g., Points and Rebounds."
        ),
        tags$li(
          "Click download buttons to retrieve the data
          in csv or the plot in pdf."
        )
        ),
      br(),
      
      # --- users inputs
      selectInput(
        "season",
        "NBA Season",
        # select Season
        c(
          # "88-89" = "88-89",
          # "89-90" = "89-90",
          # "90-91" = "90-91",
          # "91-92" = "91-92",
          # "92-93" = "92-93",
          # "93-94" = "93-94",
          # "94-95" = "94-95",
          # "95-96" = "95-96",
          # "96-97" = "96-97",
          # "97-98" = "97-98",
          # "98-99" = "98-99",
          # "99-01" = "99-01",
          "01-02" = "01-02",
          "02-03" = "02-03",
          "03-04" = "03-04",
          "04-05" = "04-05",
          "05-06" = "05-06",
          "06-07" = "06-07",
          "07-08" = "07-08",
          "08-09" = "08-09",
          "09-10" = "09-10",
          "10-11" = "10-11",
          "11-12" = "11-12",
          "12-13" = "12-13",
          "13-14" = "13-14",
          "14-15" = "14-15",
          "15-16" = "15-16"
        ),
        selected = "15-16"
      ),
      
      
      uiOutput("playerDropdownA"),
      # select Player A, based on the season you selected
      
      uiOutput("playerDropdownB"),
      # select player B
      
      radioButtons(
        "dataType",
        label = "Stat Type",
        choices = c("Average", "Total"),
        selected = "Average"
      ),
      # select data type
      
      checkboxGroupInput(
        "stats",
        label = "Stats To Include",
        choices = c(
          "Points" = "TotalPoints",
          "Threes Made" = "ThreesMade",
          "Rebounds" = "TotalRebounds",
          "Assists" = "Assists",
          "Steals" = "Steals",
          "Blocks" = "Blocks",
          "Turnovers" = "Turnovers"
        ),
        selected = c(
          "TotalPoints",
          "ThreesMade",
          "TotalRebounds",
          "Assists",
          "Steals",
          "Blocks",
          "Turnovers"
        ),
        inline = "TRUE"
      ),
      # select data type
      
      downloadButton('downloadData', 'Download Data'),
      
      downloadButton('downloadPlot', 'Download Plot')
      
      ),
    
    mainPanel(# --- This is the dynamic UI for the plots
      plotOutput("plot", height = "750px" ))
      )
))
