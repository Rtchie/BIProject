.libPaths()

# One of the libraries should be a folder inside the project if you are using
# renv

# Then execute the following command to see which packages are available in
# each library:
lapply(.libPaths(), list.files)



if (require("languageserver")) {
  require("languageserver")
} else {
  install.packages("languageserver", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## plumber ----
if (require("plumber")) {
  require("plumber")
} else {
  install.packages("plumber", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## caret ----
if (require("caret")) {
  require("caret")
} else {
  install.packages("caret", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

#load model
model_to_predict_class <- readRDS("vulnarability.rds")

#STEP 1 Creating the REST API using Plumber

#* @apiTitle Vulnarability Prediction Model API

#* @apiDescription Used to predict whether a person is vulnerable or not.

#* @param arg_userId User Income history
#* @param arg_age The users age

#* @get /class


predict_class <- function(arg_userId, arg_age) {
  # Create a data frame using the arguments
  to_be_predicted <- data.frame(userId = as.numeric(arg_userId), age = as.numeric(arg_age))
  
 
  
  # Predict the class using the model_to_predict_class
  predict(model_to_predict_class, newdata = to_be_predicted)
}