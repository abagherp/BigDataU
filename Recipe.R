# recipes <- read.csv("recipes.csv")
head(recipes)
recipes$country <- tolower(as.character(recipes$country)) 
recipes$country[recipes$country == "china"] <- "chinese"
recipes$country[recipes$country == "france"] <- "french"
recipes$country[recipes$country == "germany"] <- "german"
recipes$country[recipes$country == "india"] <- "indian"
recipes$country[recipes$country == "israel"] <- "jewish"
recipes$country[recipes$country == "italy"] <- "italian"
recipes$country[recipes$country == "japan"] <- "japanese"
recipes$country[recipes$country == "korea"] <- "korean"
recipes$country[recipes$country == "mexico"] <- "mexican"
recipes$country[recipes$country == "scandinavia"] <- "scandinavian"
recipes$country[recipes$country == "thailand"] <- "thai"
recipes$country[recipes$country == "vietnam"] <- "vietnamese"
recipes[,names(recipes)] <- lapply(recipes[,names(recipes)] , as.factor)
str(recipes)

## Sum the row count when the value of the row in a column is equal to "Yes" (which equals 2)
ing_df <- unlist(lapply(recipes[,names(recipes)] , function(x) sum(as.integer(x) == 2)))

## Transpose the dataframe so that each row is an ingredient
ing_df <- as.data.frame(t(as.data.frame(ing_df)))
ing_df <- data.frame("ingredient" = names(ing_df), "count" = as.numeric(ing_df[1,]))

ing_df[order(ing_df$count, decreasing = TRUE),][-1,]

## Install libraries
#install.packages("rpart", repo = "http://cran.utstat.utoronto.ca/")
#install.packages("rpart.plot", repo = "http://cran.utstat.utoronto.ca/")
library(rpart) #for classification trees
library(rpart.plot) #to plot rpart trees

## Create decision tree on subset of countries (East Asian + Indian)
bamboo_tree <- rpart(formula = country ~ .,data = recipes[recipes$country %in% c("korean", "japanese","chinese", "thai","indian"),],method ="class")

## Plot the East Asian + Indian model
## run "?rpart.plot" if you want to see the arguments for rpart.plot
rpart.plot(bamboo_tree, type = 3, extra = 2, under = TRUE, cex = 0.75, varlen = 0, faclen = 0)

## Summary of Asian tree
summary(bamboo_tree)

