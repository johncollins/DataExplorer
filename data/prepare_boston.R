library(MASS)
boston <- Boston
boston$chas <- as.factor(boston$chas)
boston$rad <- as.factor(boston$rad)

save(list=c('boston'), file='boston.RData')
