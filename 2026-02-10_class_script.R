# 2026-02-10_class_script 2.7 Defining Fxns
# pre-class practice

# Defining functions
# consider writing a function whenever you've copied and pasted a block of code more than twice
# an simple example is computing averages - we can compute the avg of a vec x using the 
# sum() and length() fxns: sum(x)/length(x)
# it's more efficient to write a function since we do this repeatively - which is why we have the mean() fx

# when you write your own fxns, they are called 'user defined functions'

avg = function(x){
s = sum(x) 
n = length(x)
s/n                                  # a fxn automatically returns the value produced in the last line
}                                    # returns(s/n) or you can explicitly return an obj with the return() fxn

x = 1:100
avg(x)
mean(x)

# both return the same value of 50.5
# notice that vars defined inside a fxn are not saved in the workspace. So while we use s and n 
# when we call avg, the values are created and changed only during a call
# ex.

s = 3
avg(1:10)
# returns 5.5
s
# returns 3
# note how s is still 3 after we call avg

# in general fxns are objs, so we assign them to variable names with = or <-
# the fxn function() tells R you are about to define a fxn
# general form of a fxn:

# my_function = function(VARIABLE_NAME){
# perform operations on VARIABLE_NAME and calculate VALUE
# VALUE
# }

# The fxns you define can have multiple parameters or arguements as well as default values
# ex. define a fxn that computes either the arithmetic or geometric avg depending on a user-defined var
# the arithmetic mean (most common) is equal to the sum of n numbers divided by n
# the geometric mean is the n^th root of the product of n numbers
# modify the fxn so that either the arithmetic or geometric mean can be calc'd, and allow
# the user to specify which type of mean they want by passing a parameter.

# calc arithmetic mean by default or calc geometric mean if the parameter 'arithmetic' ,,,,
avg = function(x, arithmetic = TRUE){
  n = length(x)
  result = ifelse(arithmetic, sum(x)/n, prod(x)^(1/n))
  return(result)
}

# we assigned a default value to the arithmetic param, so when the fxn is called, this param 
# does not need to be specified - the default is set to calc the arithmetic mean
# However, if the param arithmetic = FALSE is passed to the fxn , the default will be overridden
# and the fxn will calc the geometric mean. 
# note that the data var x does not have a default since it is follower by an = sign
# this means that if someone tries to call the user-defined fxn avg() w/o specifying x, 
# there will be an error

# When you pass params to a fxn call, you can pass the parameter assignments in the exact order 
# that they are listed. In this case, the data that you want to take the mean of, x, is the 
# first param, and the boolean var that indicates whether you want the mean to be arithmetic
# is the second param.
# However, instead of relying on listing your params in the exact order provided in the fxn definition,
# you can explicitly provide the name of the param and not worry about the oder that you list them

# ex

dat = c(1,3,5,7)
avg(dat)                     # returns 4
avg(dat, TRUE)               # same answer since TRUE is the default
avg(x=dat, arithmetic = TRUE) # here we make our selection of the default param explicit
# returns 4
avg(arithmetic = FALSE, x=dat) # since the params are named explicitly, we don't need to be careful,,,
# returns 3.201086

# These calls will throw an error or result in unexpected behavior
avg() # didn't include the req param x
avg(FALSE, dat) # reversed the order of the params w/o explicitly naming the params
# returns 0 0 0 0

# In the last ex., since the params weren't explicitly named, the avg() fxn assumed that x=FALSE
# and attempted to take the avg of FALSE
# Good programmers who write fxns to share w/ others will deliberately code checks and error reporting 
# into the fxns they write. i.e., at the beginning of the avg() fxn, we could check to see if 
# x is numeric. If x isn't numeric, we can leave the fxn early with the stop() fxn and print out an 
# error msg to help guide the user.

# ex. 
avg = function(x, arithmetic=TRUE){
  if(!is.numeric(x)) {stop("Function failed. x must be a numeric")}
  n = length(x)
  ifelse(arithmetic, sum(x)/n, prod(x)^(1/n))
}

# we have now designed our fxn to throw an error and send out an error msg to the user

avg(FALSE)
# returns ! Function failed. x must be a numeric

# in-class script
x=c(1,2,3,4)
mean(x)

avg = function(x){
  s = sum(x)
  n = length(x)
  answer = s/n 
  return(answer)
}

avg(x)

avg(seq(from = 3, to = 500))

# this fxn will calc the arith. mean by default, otherwise calc geomet. mean
avg = function(x, arithmetic=TRUE){
  if( !is.numeric(x)){
    stop("x isn't numeric you dummy") # check
  }
  if(arithmetic){
    result = sum(x)/length(x)
   } else if (arithmetic == FALSE) { # assume user wants geometric mean
      result = prod(x)^(1/length(x))
   } else {
      print("Unclear if you wanted an arithmetic mean")
   }
  return(result)
}

avg(x) # 2.5
avg(x, arithmetic = FALSE) # 2.213364
avg(arithmetic = F, x = seq(from = 5, to = 13)) #8.607887
avg(FALSE, seq(from = 5, to = 13)) # error - R cannot interpret this
avg(x, TRUE) # 2.5 - R assumed the order of the parameters was the same as the fxn
avg("hi") # x isn't numeric you dummy


# Exercise 7.1
# Create a fxn that reads in someone’s grade percentage points and returns 
# their letter grade (A: 90-100, B: 80-90, etc.). You can imagine how you could make this function 
# fancier by including grading scheme info in the parameters to ask if the function user wanted to 
# also know if the student earned a B+, B or B-.

x = 85

calc_letter_grade = function(x)
letter_grade = {
  if (x => 90) {
    print("You got an A")
  } else
  if (x < 90 & x > 80) {
    print("You got a B")
  }
}
return(letter_grade)


# Naming fxns
# Generally, fxn names should be verbs, arguments should be nouns. There are some exceptions:
# nouns are okay if the fxn computes a very well known noun (i.e. mean() is better than compute_mean()),
# or accessing some property of an obj (i.e., coef() is better than get_coefficients()). A good sign
# that a noun might be a better choice is if you're using a very broad verb like "get", "compute",
# "calculate", or "determine". Use your best judgement and don't be afraid to rename a fxn if you
# figure out a better name later.

f() # too short
my_awesome_function() # not a verb, or descriptive

# long, but clear
remove_na()
plot_time_series()


# 2.8 Global Temperature

# Data from: http://climate.nasa.gov/vital-signs/global-temperature
# Raw: https://data.giss.nasa.gov/gistemp/graphs/graph_data/Global_Mean_Estimates_based_on_Land_and_Ocean_Data/graph.txt

# NASA’s Goddard Institute of Space Studies (outside Washington D.C.) has created an annual global land-ocean
# temperature index. Many of the last years have set new records on global temperature. In this section 
# we will download, explore and analyze global mean temperature data.


# NASA global temp index

# if you use the online url instead of you're saved file, your data set will update as NASA updates
url = "https://data.giss.nasa.gov/gistemp/graphs/graph_data/Global_Mean_Estimates_based_on_Land_and_Ocean_Data/graph.txt"
temp_anomaly = read.delim(file = url, skip = 5, sep = "", header = FALSE,
  col.names = c("Year", "No_Smoothing", "Lowess_5"))
head(temp_anomaly)
tail(temp_anomaly)
summary(temp_anomaly)

plot(No_Smoothing ~ Year, data = temp_anomaly, ylab="Global Temp Anomaly °C")
lines(No_Smoothing ~ Year, data = temp_anomaly)
lines(Lowess_5 ~ Year, data = temp_anomaly, col="red")

# Evaluating the evidence for a “Pause” in warming?
# The 2013 IPCC Report included a tentative observation of a “much smaller increasing trend” 
# in global mean temperatures since 1998 than was observed previously. This led to much 
# discussion in the media about the existence of a “Pause” or “Hiatus” in global warming rates, 
# as well as much research looking into where the extra heat could have gone. (Examples discussing 
# this question include articles in The Guardian, BBC News, and Wikipedia).

# This example should give us some caution in how we subset our data when we are looking at trends, 
# and how difficult it is to determine whether we are in the middle of a new pattern. If you draw 
# a line between the 1998 and 2012 data points (which is probably when the 2013 IPCC report was 
# finalized), it seems like warming patterns are slowing down. Grab the No_smoothing temperature 
# values in those 2 years by subsetting with the which() function.

temp_1998 = temp_anomaly$No_Smoothing[temp_anomaly$Year == 1998]
temp_2012 = temp_anomaly$No_Smoothing[temp_anomaly$Year == 2012]
# 2012 b/c reports was published in 2013 but finalized in 2012
abline(v = 1998, lty="dashed") # draws a line, v for vertical, h for horizontal
abline(v = 2013, lty="dashed")
lines(x = c(1998, 2012), y =c(temp_1998,temp_2012), col="blue", lwd = 3) 

# Now that we can see the 1998-2012 trend that was discussed in the 2013 IPCC report, it does seem 
# like the rate of warming has slowed way down. However, now that we have the luxury of another 
# decade of data, those dates seem completely cherry-picked and there is no observable slow-down to speak of.


# Calculating rolling averages
# In the last lesson we calculated annual averages and 5 year averages to get a smoother look at 
# our data and be less susceptible to random perturbations. In that lesson, we defined the 5 year 
# average as the average of the data from a given year along with the 2 years before and 2 years 
# after (i.e. the 5-year rolling average of 2005 temperature = the temperature mean from 2003-2007).
# Sometimes scientists calculate moving averages where they simply just look at the period prior to 
# a given year. For example, we could define a 5 year average as the average over a given year and 
# the 4 years prior (i.e. the 5-year rolling average of 2005 temperature = the average temperature 
# from 2001-2005). Either definition is acceptable as long as you are explicit with which definition 
# you are using. The advantage of calculating moving averages for an endpoint (instead of a midpoint) 
# is that they are slightly simpler to calculate and you can provide averages up to the most current date. 
# For this lesson, we’ll calculate moving averages using the simpler end-point definition.


# Let’s create a user defined function that will calculate the moving average for any vector of 
# numbers, and the user can choose what the size of the moving window will be (i.e. whether 
# it will be a 1-year average, 5-year average, 10-year average, etc.).

# -Define a 5 year average as the average over a given year and the 4 years prior.
# -Construct 5 year averages from the annual data. Construct 10 & 20-year averages.
# -Plot the different averages and describe what differences you see and why.

# data = seq(1,20)
# i = 10
# moving_window = 5

calc_rolling_avg = function(data, moving_window = 5){
  result = rep(NA, length(data))
  for (i in seq(from = moving_window, to = length(result))){ # skip the elems preceding the length of the moving window
      result[i] = mean(data[seq( from = (i - moving_window + 1), to = i )])
  }
  return(result)
}

head(temp_anomaly)
temp_anomaly$avg_5_yr = calc_rolling_avg(temp_anomaly$No_Smoothing)
temp_anomaly$avg_10_yr = calc_rolling_avg(temp_anomaly$No_Smoothing, moving_window = 10)
head(temp_anomaly) # something off here - avg_5_yr and avg_10_yr not found

plot(No_Smoothing ~ Year, data = temp_anomaly, type='l')
lines(avg_5_yr ~ Year, data = temp_anomaly, col="red", lwd = 2)
lines(avg_10_yr ~ Year, data = temp_anomaly, col="green", lwd = 2)

# Exercise 8.1
# Calculate the 10-year and 20-year rolling averages of the temperature anomaly data using our new 
# user defined function calc_rolling_average. Plot the 5, 10 and 20 year rolling averages onto the 
# same figure. How would you change the design of the function if you wanted it to calculate the 
# moving average where the reference year was at the midpoint of the moving window, rather than 
# the endpoint of the moving window?

# top of my ice core source fxn
source("my_functions.r")

#Do you see the advantage of this? Once your rolling average user defined function has been 
# written, you can repeat this type of calculation on any of your diverse datasets with a 
# very easy-to-use line of code. To use this function in future code, you can copy and paste 
# the function at the top of your new R scripts. Or you could save it in an .R script on its own 
# and import that script at the top of any new R scripts that you build using the source() function. 
# If you were really ambitious, you could put your function into a time series analysis package 
# and make it available on CRAN.



