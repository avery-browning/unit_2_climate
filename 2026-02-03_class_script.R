# 2026-02-03 class script
# Mauna loa CO2 data from NASA

url = 'ftp://aftp.cmdl.noaa.gov/products/trends/co2/co2_mm_mlo.txt'

co2 = read.table(file = url, col.names = c(
                "year", 
                "month", 
                "decimal_date",
                "monthly_average", 
                "deseasonalized", 
                "n_days", 
                "st_dev_days", 
                "monthly_mean_uncertainty"))
summary(co2)
range(co2$decimal_date)
range(co2$monthly_average)

# plot it!
plot(monthly_average ~ decimal_date, data=co2, type="l")
lines(deseasonalized ~ decimal_date, data=co2, col="red")

co2$seasonal_cycle = co2$monthly_average - co2$deseasonalized
head(co2)

plot(seasonal_cycle ~ decimal_date, data = co2, type = "l")

# grab most recent 5 years and plot it 

co2_2021to2026 = co2[co2$decimal_date > 2021, ]
summary(co2_2021to2026)

plot(seasonal_cycle ~ decimal_date, data = co2_2021to2026, type = "l")

jan_anomalies = mean(co2$seasonal_cycle[co2$month == 1])
jan_anomalies

# create a data frame with monthly detrended co2 anomalies
co2_monthly_cycle = data.frame(month = seq(12), detrended_monthly_cycle = NA)
co2_monthly_cycle

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

# what if you have a giant data set? Loops!
# if you have a task to complete 3 or more times, code it to repeat itself - helps to avoid mistakes

# for loops - need to know how many times you want it to repeat -> "do this for every value of that"

# for (value in that ){
#  this
#  }

# i is the classic name you use for the variable to step through your loop (iterand - what you are iterating)
for (i in c(1:4)){
  print(i)
}

# i holds a memory of where it was last

sentence = c("loops", "are", "fun", "y'all")
for (word in sentence){
  print(word)
}

my_vector = c(1,3,5,2,4)
my_vector

# task - square every element in the vector
n_my_vector = length(my_vector)
my_vector_squared = rep(NA, n_my_vector)
my_vector
# now you have a space to square each of your values

for (i in seq(n_my_vector)){
  print( paste("I'm on iteration: ", i) )
  my_vector_squared[i] = my_vector[i]^2
  print(paste("my answer is: ", my_vector_squared[i]) )  
}
my_vector_squared

# ^ go back to video to check code

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
