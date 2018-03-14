stars <- read.csv("../data/hygdata_v3.csv", stringsAsFactors = F)

stars$dist_log <- floor(log10(stars$dist))

# Hmmm. There are no stars in the [1e4, 1e5) range,
# then 10,215 that are exactly allegedly exactly 100,000 parsecs from the Sun
table(stars$dist_log)

outliers <- stars[stars$dist == 100000,]
inliers <- stars[stars$dist < 100000,]

# Let's look at the median luminosity as a function of distance
median_luminosity <- aggregate(lum ~ dist_log, data=stars[-c(1),], FUN=median)

barplot(
  log10(median_luminosity$lum), names.arg = median_luminosity$dist_log, 
  main="Luminosity by Distance (log10 by log10)",
  xlab=("distance in parsecs (lower bound of log10)"),
  ylab=("median luminosity")
)

png('../images/luminosity.png', width = 600, height = 400)
barplot(
  log10(median_luminosity$lum), names.arg = median_luminosity$dist_log, 
  main="Luminosity by Distance (log10 by log10)",
  xlab=("distance in parsecs (lower bound of log10)"),
  ylab=("median luminosity")
)
dev.off()
