# 2026-02-03 class script
# Mauna loa CO2 data from NASA

url = 'unit_2_climate/data/co2_mm_mlo.txt'

co2 = read.table(url, col.names = c(
                "year", 
                "month", 
                "decimal_date",
                "monthly_average", 
                "deseasonalized", 
                "n_days", 
                "st_dev_days", 
                "monthly_mean_uncertainty"))

# read.table auto skips lines that start with the comment char #, so we don't 
# have to manually pass a param to tell the fx to skip the header
class(co2)
head(co2)
summary(co2)

# where does the time series start and end? What is the max co2 recorded at Mauna Loa?
range(co2$decimal_date)
range(co2$monthly_average)

# plot it!
plot(monthly_average ~ decimal_date, data=co2, type="l")

# NASA provided the de-seasonalized data - i.e., they removed the monthly cycle so that
# we can see the trend over time more easily - plot the de-seasonalized data over the 
# monthly avg data
plot(monthly_average ~ decimal_date, type = 'l', data = co2, ylab="CO2 ppm", xlab="Year", main="Keeling Curve")
lines(deseasonalized ~ decimal_date, data=co2, col="red")

# save figure
pdf('unit_2_climate/figures/keelingCurve.pdf', width=7, height=5)
plot(monthly_average ~ decimal_date, type='l', data = co2, ylab='CO2 ppm', xlab='Year', main='Keeling Curve')
lines(y=co2$deseasonalized, x=co2$decimal_date, col='red')
dev.off()

# examine seasonality of co2 data

co2$seasonal_cycle = co2$monthly_average - co2$deseasonalized # calc detrended co2 flux
head(co2)

plot(seasonal_cycle ~ decimal_date, data = co2, type = "l")

# subset and grab most recent 5 years and plot it 

# subsetting refresher
# 2 ways to get the 3rd row of the 1st column:
co2[1,3]
co2$year[3]

# 2 ways to get the whole 2nd col
co2[, 2]
co2$month

# 2 ways to get the first 6 rows of every col
co2[c(1:6),]
head(co2)

# to subset the data, we can write a boolean expression to create a vector of logical variables
# we can also use the which() function to return just the indices of the elements in the vec
# that meet some logical criteria
# there are still other ways to subset, including using the subset() fx or using filter()
# in the dplyr package


# to grab the last 5 years, we only want values of co2$decimal_date greater than 2021
# we can use a conditional statement > to signal values greater than 2021

# 2 ways to subset this
summary(co2$decimal_date > 2021) # vector of TRUES and FALSES

summary(which(co2$decimal_date > 2021)) # vector of indices that meet condition

# either can be used
co2_2021to2026 = co2[co2$decimal_date > 2021, ]
summary(co2_2021to2026)

plot(seasonal_cycle ~ decimal_date, data = co2_2021to2026, type = "l")

# it's hard to see which month is which on this plot - make a table that
# shows the avg co2 anomaly for ea month over the time series
# we can calc the monthly anomaly for January by subsetting only data where month==1
# and then taking the mean of our seasonal_cycle variable

# 2 ways to grab seasonal_cycle data only from the month of January
# jan_anomalies = co2[which(co2$month==1), 'seasonal_cycle']
jan_anomalies = co2$seasonal_cycle[which(co2$month==1)]

# calc the mean
mean(jan_anomalies)

# calc the avg monthly anomaly for all 12 months - to do this, let's make a new data.frame to hold results
# it should have 2 cols - one for month, one for avg anomaly for that month
# then we can calc the avg anomaly for ea month and insert it in the right spot in the data.frame

head(co2)


# create a data frame with monthly detrended co2 anomalies
co2_monthly_cycle = data.frame(month = seq(12), detrended_monthly_cycle = NA)
head(co2_monthly_cycle)

#fill in the data
co2_monthly_cycle$detrended_monthly_cycle[1] = mean(co2$seasonal_cycle[co2$month == 1])
co2_monthly_cycle

co2_monthly_cycle$detrended_monthly_cycle[2] = mean(co2$seasonal_cycle[co2$month == 2])
co2_monthly_cycle

co2_monthly_cycle$detrended_monthly_cycle[3] = mean(co2$seasonal_cycle[co2$month == 3])
co2_monthly_cycle$detrended_monthly_cycle[4] = mean(co2$seasonal_cycle[co2$month == 4])
co2_monthly_cycle$detrended_monthly_cycle[5] = mean(co2$seasonal_cycle[co2$month == 5])
co2_monthly_cycle$detrended_monthly_cycle[6] = mean(co2$seasonal_cycle[co2$month == 6])
co2_monthly_cycle$detrended_monthly_cycle[7] = mean(co2$seasonal_cycle[co2$month == 7])
co2_monthly_cycle$detrended_monthly_cycle[8] = mean(co2$seasonal_cycle[co2$month == 8])
co2_monthly_cycle$detrended_monthly_cycle[9] = mean(co2$seasonal_cycle[co2$month == 9])
co2_monthly_cycle$detrended_monthly_cycle[10] = mean(co2$seasonal_cycle[co2$month == 10])
co2_monthly_cycle$detrended_monthly_cycle[11] = mean(co2$seasonal_cycle[co2$month == 11])
co2_monthly_cycle$detrended_monthly_cycle[12] = mean(co2$seasonal_cycle[co2$month == 12])

co2_monthly_cycle
plot(detrended_monthly_cycle ~ month, data = co2_monthly_cycle, type ="l", col = "navyblue")

# what if you have a GIANT data set? Loops!
# if you have a task to complete 3 or more times, code it to repeat itself - helps to avoid mistakes

# for loops - need to know how many times you want it to repeat -> "do this for every value of that"

# for (value in that ){
#  this
#  }

# i is the classic name you use for the variable to step through your loop (iterand - what you are iterating)
# each time the for loop ran is called an iteration

c(1,2,3,4)
for (i in c(1:4)){
  print(c("one run", i))
}

# i holds a memory of where it was last

sentence = c("loops", "are", "fun", "y'all")
for (word in sentence){
  print(word)
}


for(value in c("My", "second", "for", "loop")){
  print(value)
}


# using the iterand as an index
# the most common usage of a for loop is to create some iterand (often named i) that will step through
# ea element inside in a vec and act on the elements of that vec in some way with the iterand acting 
# as an element inside the loop

# ex find the square of each value in your data
my_vector = c(1,3,5,2,4)
my_vector

# task - square every element in the vector
n_my_vector = length(my_vector)
my_vector_squared = rep(NA, n_my_vector) # initialize the results vector
my_vector
# now you have a space to square each of your values

for (i in seq(n_my_vector)){
  print( paste("I'm on iteration: ", i) )
  my_vector_squared[i] = my_vector[i]^2
  print(paste("my answer is: ", my_vector_squared[i]) )  
}
my_vector_squared


# calculate total of a vector
my_vector = c(1,3,5,2,4)
n_my_vector = length(my_vector)
my_vector_total = 0
for (i in seq (n_my_vector)){
  print(paste("before the calc:", my_vector_total))
  my_vector_total = my_vector_total + my_vector[i]
  print(paste("after the calc:", my_vector_total))
}

my_vector_total

# initialize your variable right above your loop ----

# exercise 5.1
# my_factorial_loop = c(1,2,3,4,5)
# n_factorial_loop = length(my_factorial_loop)
# my_factorial_total = 0
# for (i in seq (n_factorial_loop)){
#     print(i!)
# }
# my_factorial_loop

num = 5
factorial_result = 1
for( i in seq(num)){
  factorial_result = i * factorial_result
  print(factorial_result)
}
factorial_result

# cont. 2026-02-05

# nesting for loops

mat = matrix(c(2,0,8,3,5,-4), nrow = 2, ncol = 3)
mat
mat_squared = matrix(rep(NA, 6), nrow = 2, ncol = 3)

dim(mat)
for(i in seq(dim(mat)[1])){
  for (j in seq(dim(mat)[2])){
    print(paste("I'm on row: ", i, " and column: ", j))
    mat_squared[i,j] = mat[i,j]^2
  }
}
mat_squared

# while loops - when you don't know how many times you'll repeat a task

x = 5
while(x > 0){
  x = x - 1
}

# fish catching game - max fish weight limit = 50 , fish until you reach the condition

total_catch_lb = 0
n_fish = 0
while(total_catch_lb < 50){ #keep fishing
 new_fish_weight = rnorm(n = 1, mean = 2, sd = 1)
 total_catch_lb = total_catch_lb + new_fish_weight
 n_fish = n_fish + 1
 print(paste("n fish = ", n_fish, "and new fish weight = ", new_fish_weight))
}
n_fish
total_catch_lb
new_fish_weight

# Exercise 5.2
# Use a while loop to build a simple number matching game. Pick a number between 1 and 10 outside of the
# loop. Then, inside the loop, step through 1 to 10 and test if that iteration of the loop has guessed the
# correct number. At the end, print out the number of guesses it took for your loop to guess the right
# number. You could make this game fancier by stepping through random numbers inside the loop to guess
# the right number using guess=round(runif(n=1, min=1, max=10))

