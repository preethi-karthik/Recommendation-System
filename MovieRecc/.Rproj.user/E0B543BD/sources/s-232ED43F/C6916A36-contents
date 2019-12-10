#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
# inspired by Jekaterina's Project on Movie Recommendation System 
library(shiny)

genre <- c("Action", "Adventure", "Animation", "Children", 
                "Comedy", "Crime","Documentary", "Drama", "Fantasy",
                "Film.Noir", "Horror", "Musical", "Mystery","Romance",
                "Sci.Fi", "Thriller", "War", "Western")

shinyUI(fluidPage(
titlePanel("MOVIE RECOMMENDATION SYSTEM"),
 h4("- Preethi Prakash & Shruthi "),
 h5("Dataset used : Movielens - https://grouplens.org/datasets/movielens/latest/"),
 img(src = "MRs.jpg", height = 300, width = 600),
  fluidRow(
   
    column(4, h3("Select the Movie Genres You Prefer:"),
           wellPanel(
             selectInput("input_genre", "Genre #1",
                         genre),
             selectInput("input_genre2", "Genre #2",
                         genre),
             selectInput("input_genre3", "Genre #3",
                         genre)
             
           )),
    
    column(4, h3("Select Movies You Like of these Genres:"),
           wellPanel(

             uiOutput("MovieList1"),
             uiOutput("MovieList2"),
             uiOutput("MovieList3")
             #submitButton("Get Recommendations")
           )),
    
    column(4,
           h3("You Might Like The Following Movies Too!"),
           tableOutput("MovieRecommTable")
    )
  )
))