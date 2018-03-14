# uncomment the third line one time if you don't have one of these packages installed
# you may need to update or install the GCC compiler
#install.packages(c("plot3D", rgl", "car"))
library(plot3D)
library(car)

stars <- read.csv("../data/hygdata_v3.csv", stringsAsFactors = F)

# looks like the coordinates are conveniently capped at +/- 10e6
print(paste(min(stars$x), max(stars$x)))
print(paste(min(stars$y), max(stars$y)))
print(paste(min(stars$z), max(stars$z)))

# here goes nothing
plot(stars$x, stars$y, cex=0.1)
plot(stars$x, stars$z, cex=0.1)
plot(stars$y, stars$z, cex=0.1)

# let's try 3D!
scatter3D(stars$x, stars$y, stars$z, cex=0.1) # static 3D plot using `plot3D`
scatter3d(stars$x, stars$y, stars$z, cex=0.1) # dynamic 3D plot using `car`

# save the static image
png('../images/stars_3d.png', width = 800, height = 800)
scatter3D(stars$x, stars$y, stars$z, cex=0.3)
dev.off()

# Let's look at the distribution of distances from Sol in parsecs.
# Looks like there may be a cluster toward the center
stars$dist_log <- log10(stars$dist)
distances <- hist(stars[-1,]$dist_log, 100, plot=FALSE)
x_labels <- lapply(seq(0,5,1), function(x) 10^x)
plot(distances$breaks[-1], distances$density, type="l", xlab = "distance from Sol", ylab="density", axes=F)
axis(side=1, at=seq(0,5,1), labels=x_labels)
axis(side=2, at=seq(0,2, 0.25))

# Save that image
png('../images/stars_distance.png', width = 800, height = 400)
plot(distances$breaks[-1], distances$density, type="l", xlab = "distance from Sol", ylab="density", axes=F, cex.lab=1.5)
axis(side=1, at=seq(0,5,1), labels=x_labels)
axis(side=2, at=seq(0,2, 0.25))
dev.off()

# Interesting! It appears that the distances of very-distant stars
# is capped a 10e5 parsecs, which accounts for the tidy sphere shape
# According to the Github docs,
# "A value >= 10000000 indicates missing or dubious (e.g., negative) parallax data in Hipparcos."
# But the cap is at 10,000, where there at 10,215 instances
print(NROW(stars[stars$dist_log == 5,]))

# Let's reduce to "near stars"
near_stars = stars[stars$dist_log < 5,]
scatter3D(near_stars$x, near_stars$y, near_stars$z, cex=0.1) # static 3D plot using `plot3D`

# This looks more like it
# save this image too
png('../images/near_stars_3d.png', width = 800, height = 800)
scatter3D(near_stars$x, near_stars$y, near_stars$z, cex=0.3)
dev.off()

# The farthest star is less than 1,000 parsecs away
print(max(near_stars$dist_log))

# This is a much more natural distribution
distances <- hist(near_stars[-1,]$dist_log, 100, plot=FALSE)
x_labels <- lapply(seq(0,3,1), function(x) 10^x)
plot(distances$breaks[-1], distances$density, type="l", xlab = "distance from Sol", ylab="density", axes=F)
axis(side=1, at=seq(0,3,1), labels=x_labels)
axis(side=2, at=seq(0,2, 0.25), cex=2)

png('../images/near_stars_distance.png', width = 800, height = 400)
plot(distances$breaks[-1], distances$density, type="l", xlab = "distance from Sol", ylab="density", axes=F, cex.lab=1.5)
axis(side=1, at=seq(0,3,1), labels=x_labels)
axis(side=2, at=seq(0,2, 0.25), cex=1.5)
dev.off()

# let's save the near star data
write.csv(near_stars, "../data/near_stars.csv", row.names = F)