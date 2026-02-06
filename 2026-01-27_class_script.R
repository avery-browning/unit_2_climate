# 2026-01-27 ; class script

# read in data - using the relative path
ant_ice_loss = read.table("unit_2_climate/data/antarctica_mass_200204_202505.txt",
                          skip=31, header=F, col.names= c("decimal_date", "mass_Gt", "sigma_Gt"))
ant_ice_loss
grn_ice_loss = read.table("unit_2_climate/data/greenland_mass_200204_202505.txt",
                          skip=31, header=F, col.names= c("decimal_date", "mass_Gt", "sigma_Gt"))
head(grn_ice_loss)
#head prints out the first 6 rows
dim(grn_ice_loss)
summary(grn_ice_loss)

#plot
range(grn_ice_loss$mass_Gt)

plot(x=ant_ice_loss$decimal_date, y=ant_ice_loss$mass_Gt,
    ylim = range(grn_ice_loss$mass_Gt),
    type="l", xlab="", ylab="Ice mass loss (Gt)")

#plot mass_Gt as a function of decimal_date -> formula y ~ x

lines(mass_Gt ~ decimal_date,
    data=grn_ice_loss,
    type="l", xlab="", col= "red")

# add a break between GRACE missions

data_break = data.frame(decimal_date = 2018,
                        mass_Gt = NA,
                        sigma_Gt = NA)
data_break
ant_ice_loss_NA = rbind(ant_ice_loss, data_break)
head(ant_ice_loss_NA)
tail(ant_ice_loss_NA)

ant_ice_loss_NA$decimal_date
order(ant_ice_loss_NA$decimal_date)

ant_ice_loss_NA = ant_ice_loss_NA[order(ant_ice_loss_NA$decimal_date), ]
tail(ant_ice_loss_NA)

# do to greenland
grn_ice_loss_NA = rbind(grn_ice_loss, data_break)
grn_ice_loss_NA = grn_ice_loss_NA[order(grn_ice_loss_NA$decimal_date), ]

# can use + to link multiple plots together
plot(mass_Gt ~ decimal_date,
    data= ant_ice_loss_NA,  
    ylim = range(grn_ice_loss$mass_Gt, na.rm=TRUE),
    type="l", xlab="", ylab="") +

lines(mass_Gt ~ decimal_date, data = grn_ice_loss_NA, type='l', col='red')

head(ant_ice_loss_NA)

# NASA gave sigma (1 std dev) which represents 68% of uncertainty
# in the header, they call it "1-sigma", meaning '1 std', and NOT '1 minus the std'
# sometimes we show error as "2-sigma", where 2 X sigma represents 95% uncertainty
# we can plot 95% confidence intervals around the data by adding and subtracting 2*sigma from the mass loss estimates

plot(mass_Gt ~ decimal_date, data = ant_ice_loss_NA, ylab='Antarctica Mass Loss (Gt)', xlab='Year',
type='l', lwd=2) +
lines((mass_Gt+2*sigma_Gt) ~ decimal_date, data = ant_ice_loss_NA, type='l', lty='dashed') +
lines((mass_Gt-2*sigma_Gt) ~ decimal_date, data = ant_ice_loss_NA, type='l', lty='dashed')

# combine Ant and Grn time series plots into the same plot and save plot to hard drive
pdf('unit_2_climate/figures/ice_mass_trends.pdf', width = 7, height = 5)
plot(mass_Gt ~ decimal_date, data = ant_ice_loss_NA, ylab = "Ice Sheet Mass Loss (Gt)",
    xlab="Year", type='l', ylim=range(grn_ice_loss_NA$mass_Gt, na.rm=TRUE), lwd=2) +
lines((mass_Gt+2*sigma_Gt) ~ decimal_date, data = ant_ice_loss_NA, type='l', lty='dashed') +
lines((mass_Gt-2*sigma_Gt) ~ decimal_date, data = ant_ice_loss_NA, type='l', lty='dashed') +
lines((mass_Gt ~ decimal_date), data=grn_ice_loss_NA, type='l', lwd=2) +
lines((mass_Gt+2*sigma_Gt) ~ decimal_date, data=grn_ice_loss_NA, type='l', lty='dashed', col='red') +
lines((mass_Gt-2*sigma_Gt) ~ decimal_date, data=grn_ice_loss_NA, type='l', lty='dashed', col='red')
dev.off()

# make a bar plot
## largest observed decrease in ice mass loss in Antarctica
min(ant_ice_loss$mass_Gt)

# barplot of largest observed ice loss in Antarctica and Greenland
barplot(height=c(min(ant_ice_loss$mass_Gt), min(grn_ice_loss$mass_Gt)))

#flip to negative to positive, add x-axis labels, add more tick marks on y-axis, add y-axis title
barplot(height= c(min(ant_ice_loss$mass_Gt)*(-1), min(grn_ice_loss$mass_Gt)*(-1)), 
        names.arg=c("Antarctica", "Greenland"), ylim=c(0,6000), ylab="Ice loss in Gt")
