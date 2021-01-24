library(Hmisc)
data <- read.csv("~/Documents/habit_toy/simulationResult.csv")
model <- lm(choice ~  1+ Lag(choice,1), data=data)
model1 <- lm(choice ~  1+ Lag(choice,1)+dtn*Lag(choice,1), data=data)
