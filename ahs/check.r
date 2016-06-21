library(maptools)
library(sp)

ahs_zone_shapes <- readShapePoly("ahs_geographies_bay_area.shp")
proj4string(ahs_zone_shapes) <- CRS("+proj=utm +zone=10 +datum=NAD83 +units=m +no_defs")
names(ahs_zone_shapes) <- c("zone","smsa")

mtc_units <- read.csv("deed_restricted_units_by_location.csv", header=TRUE)
coords = cbind(mtc_units['longitude'],mtc_units['latitude'])
spdf = SpatialPointsDataFrame(coords, mtc_units)
proj4string(spdf) <- CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
spdf <- spTransform(spdf,CRS(proj4string(ahs_zone_shapes)))

#sum up units in mtc zone count
spdf@data <- cbind(spdf@data,over(spdf,ahs_zone_shapes))
library(plyr)
mtc_units_by_zone <- as.data.frame(summarize(group_by(spdf@data,zone,smsa),mtc_units=sum(units)))

ahs_zone_counts <- read.csv("ahs_deed_restricted_by_zone.csv", header=TRUE)
names(ahs_zone_counts) <- c("zone","smsa","units","std_err")

m1 <- merge(x = ahs_zone_shapes@data, y = ahs_zone_counts, by = c("zone","smsa"), all.x=TRUE)
m1 <- m1[!duplicated(m1), ]
m2 <- merge(x = m1, y = mtc_units_by_zone, by = c("zone","smsa"), all.x=TRUE)
m2 <- m2[!duplicated(m2), ]
ahs_zone_shapes@data <- merge(x=m2,y=ahs_zone_shapes@data, by = c("zone","smsa"), all.x=TRUE)

names(m2) <- c("zone","smsa","ahs_units","std_err","mtc_units")

writeSpatialShape(ahs_zone_shapes, 'mtc_ahs_units_comparison.shp')
file.copy('ahs_geographies_bay_area.prj','mtc_ahs_units_comparison.prj')
write.table(m2,file="mtc_ahs_units.comparison.csv", sep=",")

