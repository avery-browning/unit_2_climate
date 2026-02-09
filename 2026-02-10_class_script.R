# 2026-02-10_class_script 2.7 Defining Fxns
# pre-class practice

# Functions
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

# Exercise 7.1
# Create a fxn that Create a function that reads in someone’s grade percentage points and returns 
# their letter grade (A: 90-100, B: 80-90, etc.). You can imagine how you could make this function 
# fancier by including grading scheme info in the parameters to ask if the function user wanted to 
# also know if the student earned a B+, B or B-.

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