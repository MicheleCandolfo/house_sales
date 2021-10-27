install.packages("dplyr")
library("dplyr")


#1 Load data 

house_prices <- read.csv(file = '/Users/michelecandolfo/Documents/Shiny App/Abgabe/HousePriceDataSet/kc_house_data.csv')

View(house_prices)

#2 Tidy data 

summary(house_prices)
count(house_prices, bedrooms)
count(house_prices, bathrooms)

# Plausibilty check 
df2 <- select(house_prices, id, sqft_living, bedrooms)
df3 <- filter(df2, bedrooms == 33)
View(df3)
a <- df3[1, 2]
b <- df3[1, 3]
c <- a / b 
c * 0.092903
# 33 is not a plausible amount of bedrooms because the bedroom itself has only around 5 square meters, we will change it to 3

# Create a copy of house_prices

house_prices2 <- house_prices

# Change bedroom value from 33 to 3
house_prices2[house_prices2$id==2402100895, "bedrooms"] <- 3

# Eliminate all the data which has bedrooms or bathrooms = 0

house_prices3<-house_prices2[!(house_prices2$bedrooms==0 | house_prices2$bathrooms==0),]

# Duplicate check 

dup <- filter(count(house_prices3, id), n!=1)
count(dup, n)
View(dup)

# Sample
sample_check1 <- house_prices3[house_prices3$id == 526059224,]
View(sample_check1)

#-> Value of the features are the same except for the price which had a increase 
sample_check2 <- house_prices3[house_prices3$id == 795000620,]
View(sample_check2)

#-> Value of the features are the same except for the price which had a increase 
sample_check3 <- house_prices3[house_prices3$id == 7504021310,]
View(sample_check3)

# We checked all the sample duplicates and got the result that the value of the features are the same except for
# the price which had a increase. 







