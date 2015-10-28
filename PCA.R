#Make take a while to install
# install.packages("psych")
# install.packages("ggplot2")
library(psych)
library(ggplot2)

## Read the data into an object named data
data <- read.csv('new_prof_data.csv')

## Examine data:
names(data)
str(data)
summary(data)
head(data)

names(data) ## look up index
comp.data <- data[,3:8] ## extract data
names(comp.data) ## check

round(cor(comp.data), digits = 3) ## produces correlation matrix

pcaSolution <- prcomp(comp.data, center = TRUE, scale. = TRUE) 

## Produced the object with standard deviatons of all variables
## and Rotation -- or the loadings on the principal components

print(pcaSolution) ## prints PCA solution

pcaSolution$sdev^2

plot(pcaSolution, type = "l", pch = 16, lwd = 2) ## generates a scree plot
