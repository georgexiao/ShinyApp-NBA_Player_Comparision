Coursera Developing Data Products Project - Shiny App Pitch-book
========================================================
author: George Xiao
date: 7/31/2016

What is it?
========================================================

As a NBA and data lover, I created this Shiny application to do some basic basketball stats analysis. This is a app to compare two NBA players' statistics.

In this app, you can:

- Compare **16** years of data: from season *01-02* to *15-16*.
- Compare **7** stats: *points, three points made, rebounds, assists, steals, blocks* and *turnovers*.
- Compare in **2** ways: *total* or *average*
- Download source data and plot to your machine

How to compare?
========================================================

1. Select a season from the drop-down list.
2. Select a player. The player names are based on the registered NBA players list of the season.
3. Select another player. By default, the top two scorers are pre-selected.
4. Select data type: Average or Total
5. Select the statistics you want to compare, e.g., Points and Rebounds.
6. View the chart.
7. If you want, click download buttons to retrieve the data in csv or the plot in pdf.

How does the chart look like?
========================================================
The chart is based on package ggplot2
![plot of chunk unnamed-chunk-1](Coursera Developing Data Products Project - Shiny App Pitchbook-figure/unnamed-chunk-1-1.png)

Links - All you need
========================================================

This shinyApp is on shinyApp io: https://georgexiao.shinyapps.io/NBA_Player_Comparison/

The server.R, ui.R and R presentation the are on Github: https://github.com/georgexiao/ShinyApp-NBA_Player_Comparision

Rpub presentation: http://rpubs.com/GeorgeXiao/NBA_PLAYER


