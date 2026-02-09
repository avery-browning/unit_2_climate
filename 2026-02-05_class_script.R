# 2026-02-05 class script

# NOAA arctic sea ice coverage - unit 2.6
url = "https://noaadata.apps.nsidc.org/NOAA/G02135/north/daily/data/N_seaice_extent_daily_v4.0.csv"
arctic_ice = read.delim(url, skip = 2, header = F)
col.names = c("Year", "Month", "Day", "Extent", "Missing", "Source_data")

head(arctic_ice)
tail(arctic_ice)
summary(arctic_ice)

# install.packages("lubridate") # only do this once EVER - normally just run in console
library(lubridate) # do this ever r session # using make_date()

arctic_ice$date = make_date(year = arctic_ice$Year, month = arctic_ice$Month, day = arctic_ice$Day)
head(arctic_ice)
class(arctic_ice$date)

plot(Extent ~ date, date=arctic_ice, type="l", 
main = "NOAA arctic sea ice", 
ylab = "Sea ice extent (*10^6 km^2")

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

arctic_ice_averages$date = make_date(year = arctic_ice_averages$Year, month = 6, day = 30)
head(arctic_ice_averages)
class(arctic_ice_averages$date)

plot(Exten ~ date, data = arctic_ice, type = "l")
lines(extent_annual_avg ~ date, data = arctic_ice_averages, type = "l", col = "red")
lines(extent_5yr_avg ~ date, data = arctic_ice_averages, type = "l", col = "blue")

# Exercise 6.1
