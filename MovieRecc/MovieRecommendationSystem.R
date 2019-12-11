# MOVIE RECOMMENDATION SYSTEM by : Preethi Prakash
library(recommenderlab)
library(reshape2)
#Importing Movie Dataset and Ratings Dataset
movies <- read.csv("movies.csv", header = TRUE, stringsAsFactors=FALSE)
ratings <- read.csv("ratings.csv", header = TRUE)
#Combining movie and rating DS and excluding uncommon movies between both files
movies2 <- movies[-which((movies$movieId %in% ratings$movieId) == FALSE),]

movie_recommendation <- function(movieInput1,movieInput2,movieInput3) {
  row_numM1 <- which(movies2[,2] == "Good Will Hunting (1997)")
  row_numM2 <- which(movies2[,2] == "Inception (2010)")
  row_numM3 <- which(movies2[,2] == "Shutter Island (2010)")
  # gets the input number of the movies 
  row_numM1 <- which(movies2[,2] == movieInput1)
  row_numM2 <- which(movies2[,2] == movieInput2)
  row_numM3 <- which(movies2[,2] == movieInput3)
  # creating the user select the size of rows from csv file
  userSelect <- matrix(NA,10325)
  #row_numM1
  #userSelect[row_numM1]
  userSelect[row_numM1] <- 5 #hard code first movie selection to rating 5
  userSelect[row_numM2] <- 4 #hard code second movie selection to rating 4
  userSelect[row_numM3] <- 3 #hard code third movie selection to rating 3
  
  #Transpose of matrix
  userSelect
  userSelect <- t(userSelect)
  #casting from wide to long format using reshape2
  #Create ratings matrix. Rows = userId, Columns = movieId
  ratingmat <- dcast(ratings, userId~movieId, value.var = "rating", na.rm=FALSE)
  ratingmat <- ratingmat[,-1]
  #ratingmat
  colnames(userSelect) <- colnames(ratingmat)
  colnames(userSelect)
  ratingmat2 <- rbind(userSelect,ratingmat)
  ratingmat2 <- as.matrix(ratingmat2)
  #Convert rating matrix into a sparse matrix
  ## coerce into a realRatingMAtrix
  #When you call a function with an argument of the wrong type, R will try to coerce values to a different type so that the function will work.
  ratingmat2 <- as(ratingmat2, "realRatingMatrix")
  #669 x 10325 rating matrix of class ‘realRatingMatrix’ with 105342 ratings.
  ratingmat2
  #Create Recommender Model. "UBCF" stands for user-based collaborative filtering using cosine similarity between 30 users 
  recommender_model <- Recommender(ratingmat2, method = "UBCF",param=list(method="Cosine",nn=30))
  #predict(object, newdata, n = 10, data=NULL,
  #type="topNList", ...)
  #Recommendations as ‘topNList’ with n = 10 for 1 users. 
  ratingmat2[1]
  recom <- predict(recommender_model, ratingmat2[1], n=10)
  #returns a list of recommended movies as a list of row numbers 
  recom_list <- as(recom, "list")
  no_result <- data.frame(matrix(NA,1))
  recom_result <- data.frame(matrix(NA,10))
  as.character(recom_list[1])
  if (as.character(recom_list[1])=='character(0)'){
    no_result[1,1] <- "Sorry, there is not enough information in our database on the movies you've selected. Try to select different movies you like."
    colnames(no_result) <- "No results"
    return(no_result) 
  } else {
    for (i in c(1:10)){
      recom_result[i,1] <- as.character(subset(movies, 
                                               movies$movieId == as.integer(recom_list[[1]][i]))$title)
    }
    colnames(recom_result) <- "User-Based Collaborative Filtering Recommended movie Titles"
    #recom_result
    return(recom_result)
  }
}
