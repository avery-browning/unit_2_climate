# 2026-02-05 class script

# NOAA arctic sea ice coverage - unit 2.6
url = "https://noaadata.apps.nsidc.org/NOAA/G02135/north/daily/data/N_seaice_extent_daily_v4.0.csv"
arctic_ice = read.delim(url, skip = 2, header = F)
col.names = c("Year", "Month", "Day", "Extent", "Missing", "Source_data")

head(arctic_ice)
tail(arctic_ice)
summary(arctic_ice)

# Notice that unlike in previous data sets, the date information is split into three columns: year, month, day.
# This will make it harder to plot a time series since we can only plot one variable along the x axis. We could
# do the math to turn the month and day variables into decimal dates. Another, simpler, option is to take
# advantage of the lubridate package that was designed by other R users. Installing, loading and using
# functions from R packages can save you loads of time and dramatically increase the functionality of the R
# language. We will use many other packages throughout the course.

# First, we need to install the lubridate package from the CRAN library. You can do this in RStudio using the
# top menu: Tools -> Install packages.... Then type the name of the package you want (lubridate) into
# the text box, make sure the Install Dependencies box is checked and click Install. Or you can simply do
# it at your command line with the function install.packages("lubridate"). Once installed, you need to
# load the package functions into your environment with the library() function. Now that the lubridate
# package is loaded up, we can use the function make_date() to transform your year, month and day into a
# date type variable. Don’t forget you can use the command ?make_date to find out more about the function
# (or just search for the function in the Help tab of the lower left panel in RStudio).


# install.packages("lubridate") # only do this once EVER - normally just run in console
library(lubridate) # do this ever r session # using make_date()

arctic_ice$date = make_date(year = arctic_ice$Year, month = arctic_ice$Month, day = arctic_ice$Day)
head(arctic_ice)
class(arctic_ice$date)

plot(Extent ~ date, date=arctic_ice, type="l", 
main = "NOAA arctic sea ice", 
ylab = "Sea ice extent (*10^6 km^2")

# Use for loops to calculate the annual average Arctic sea ice extent and the 5-year-average Arctic sea ice
# extent. The annual average is the mean of all of the sea ice extent observations within a given year. We’ll
# define the 5-year-average ice extent for some given year x as the mean of all sea ice extent observations
# within the year x as well as the 2 years prior and the 2 years after year x. For example, the 5-year-average
# sea ice extent for 2010 is the mean of all observations from Jan. 1 2008 to Dec. 31 2012.


# calculate the annual average Arctic sea ice extent


min(arctic_ice$Year)
max(arctic_ice$Year)
arctic_ice_averages = data.frame(Year = seq(from = min(arctic_ice$Year) + 1, 
to = max(arctic_ice&Year) - 1), extent_annual_avg = NA, extent_5yr_avg = NA)
arctic_ice_averages

arctic_ice_averages$extent_annual_avg[1] = mean(arctic_ice$Extent[arctic_ice$Year == 1979])
head(arctic_ice_averages)

for(i in seq(dim(arctic_ice_averages)[1])){
  arctic_ice_averages$extent_annual_avg[i] = mean(arctic_ice$Extent[arctic_ice$Year == arctic_ice_averages$Year[1]])
print(paste("i = ", i, "year = ", arctic_ice_averages$Year[i]))
}

plot(extent_annual_avg ~ Year, data = arctic_ice_averages, type="l")


nrow(arctic_ice_averages)
ncol(arctic_ice_averages)
dim(arctic_ice_averages)
for (i in seq(3, dim(arctic_ice_averages)[1] - 2)){
  years = seq(from = arctic_ice_averages$Year[i] - 2, 
    to = arctic_ice_averages$Year[i] + 2)
    arctic_ice_averages$extent_5yr_avg[i] = mean(arctic_ice$Extent[arctic_ice$Year %in% years])
    print(years)
}

head(arctic_ice_averages)

plot(extent_5yr_avg ~ Year, data = arctic_ice_averages, type="l")
lines(extent_annual_avg ~ Year, data = arctic_ice_averages, type="b", col="yellowgreen") 

# As you’d expect, the 5-year-average really smooths out some of that year-to-year variability and makes it a
# bit easier to observe the overall trend through time.
# If we want to plot the annual and 5-year averages on the same plot as the original observations, we’ll have
# to change our Year variable into a date-type variable that will plot nicely along the dates in the original
# observation dataset:
arctic_ice_averages$date = make_date(year = arctic_ice_averages$Year, month = 6, day = 30)
head(arctic_ice_averages)
class(arctic_ice_averages$date)

plot(Exten ~ date, data = arctic_ice, type = "l")
lines(extent_annual_avg ~ date, data = arctic_ice_averages, type = "l", col = "red")
lines(extent_5yr_avg ~ date, data = arctic_ice_averages, type = "l", col = "blue")

# Exercise 6.1
