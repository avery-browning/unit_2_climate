# 2026-01-29 class script

vec = c(1,0,2,1)
vec
vec[ c(T,F,T,F)]

3 == 3
x = 156
y = 3
x != y

# you can't just use = , because that is used for assigning the value

x %in% vec

# %in% is element wise - in our vector here, it asks the ele 4 times

c(1,2,3,4) %in% c(3,2,1)

# returns T T T F

world_oceans2 = data.frame(oceans = c("Atlantic", "Pacific", "Indian", "Arctic", "Southern"), 
                          area_km2 = c(77e6, 156e6, 69e6, 14e6, 20e6), 
                          avg_depth_m = c(3926, 4028, 3963, 3953, 4500))
world_oceans2

world_oceans2[ world_oceans2$avg_depth_m > 4000, ]

1 + 2 == 3
0.1 + 0.2 == 0.3

# binary cannot perfectly replicate a decimal

(0.1 + 0.2) - 0.3

# still wrong

error_threshold = 0.001
abs( (0.3 - 0.1 + 0.2 )) > error_threshold

# boolean operators

x = 7
x > 5 & x %in% c(1,2,3,7)

vec1 = c(1,2,3)
vec2 = c(3,2,1)
vec1 == vec2

world_oceans2[ (world_oceans2$avg_depth_m > 4000) & world_oceans2$avg_km2 > 100e6 ]

vec2 = c(1,2,NA,4)
2 %in% vec2
NA %in% vec2
x = NA
y = NA
x == y

# is x in na?
is.na(x)

# is na in vec2?
is.na(vec2)

# if you try to do math on a logical ---------
# coerced each logic into a numerical 
sum( is.na(vec2) )

# if statements
num = -50
if(num < 0) {
   num = num * -1
  print("I made num positive!")
}
num

temp = 99
if(temp > 98.6) {
  print("Fever")
  diff = temp - 98.6
  print(diff)
{if (temp > 101) 
  print("Warning - Fever")}
}

# else statemets 

# a = 200
# b = "hazel quit"
# if(a>b){
#  if(! is.numeric(b) | ! is.numeric(a))
#    print("your data sucks")
#  print("a wins!")
# } else if (b>a){
#  print("b wins!")
# } else {
#  print("it's a tie!")
# } else {
#  print("something is wrong with your data...")
# }
