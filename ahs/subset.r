#this presumes existing AHS db. see 'get_data' and 'recode..' scripts if it doesn't exist

ahs.dbname <- "ahs/ahs.db"
#install.packages( c( "sqldf" ) )

library(downloader) # downloads and then runs the source() function on scripts from github
library(survey)     # load survey package (analyzes complex design surveys)
library(RSQLite)    # load RSQLite package (creates database files in R)
library(sqldf)      # load the sqldf package (enables sql queries on data frames)

# R will exactly match SUDAAN results and Stata with the MSE option results
options( survey.replicates.mse = TRUE )

db <- dbConnect( SQLite() , ahs.dbname )

#get the survey design object
#haven't adjusted the arguments here
#from anthony j damico's script much
#might be worth looking into if numbers seem off
ahs.design <-
  svrepdesign(
    weights = ~repwgt0,
    repweights = "repwgt[1-9]" ,
    type = "Fay" ,
    rho = ( 1 - 1 / sqrt( 4 ) ) ,
    data = "recoded_tnewhouse_trepwgt_2011_nationalandmetropolitanv14" ,
    dbtype = "SQLite" ,
    dbname = ahs.dbname
  )
  
l_z <- list()
zones <- c()
smsas <- c()
units <- c()
std_err <- c()
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 7 & smsa == 5775)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,7)
smsas <- append(smsas,5775)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))

ahs.design.bay_area.subset <-  subset(ahs.design, zone == 103 & smsa == 5775)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,103) 
smsas <- append(smsas,5775)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 104 & smsa == 5775)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,104) 
smsas <- append(smsas,5775)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 105 & smsa == 5775)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,105) 
smsas <- append(smsas,5775)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 106 & smsa == 5775)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,106) 
smsas <- append(smsas,5775)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
                          df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
                          df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
                              df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
                              df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 107 & smsa == 5775)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,107) 
smsas <- append(smsas,5775)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 108 & smsa == 5775)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,108) 
smsas <- append(smsas,5775)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 109 & smsa == 5775)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,109) 
smsas <- append(smsas,5775)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 110 & smsa == 5775)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,110) 
smsas <- append(smsas,5775)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 111 & smsa == 5775)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,111) 
smsas <- append(smsas,7360)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 1 & smsa == 7360)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,1) 
smsas <- append(smsas,7360)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 2 & smsa == 7360)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,2) 
smsas <- append(smsas,7360)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 3 & smsa == 7360)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,3) 
smsas <- append(smsas,7360)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 4 & smsa == 7360)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,4) 
smsas <- append(smsas,7360)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 5 & smsa == 7360)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,5) 
smsas <- append(smsas,7360)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 6 & smsa == 7360)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,6) 
smsas <- append(smsas,7360)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 101 & smsa == 7360)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,101) 
smsas <- append(smsas,7360)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 102 & smsa == 7360)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,102) 
smsas <- append(smsas,7360)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 112 & smsa == 7360)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,112) 
smsas <- append(smsas,7360)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 113 & smsa == 7360)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,113) 
smsas <- append(smsas,7360)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 114 & smsa == 7360)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,114) 
smsas <- append(smsas,7360)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 115 & smsa == 7360)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,115) 
smsas <- append(smsas,7400)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 1 & smsa == 7400)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,1) 
smsas <- append(smsas,7400)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 2 & smsa == 7400)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,2) 
smsas <- append(smsas,7400)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 3 & smsa == 7400)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,3) 
smsas <- append(smsas,7400)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 4 & smsa == 7400)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,4) 
smsas <- append(smsas,7400)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 5 & smsa == 7400)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,5) 
smsas <- append(smsas,7400)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 101 & smsa == 7400)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,101) 
smsas <- append(smsas,7400)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 102 & smsa == 7400)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,102) 
smsas <- append(smsas,7400)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 103 & smsa == 7400)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,103) 
smsas <- append(smsas,7400)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 104 & smsa == 7400)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )
df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,104) 
smsas <- append(smsas,7400)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))
ahs.design.bay_area.subset <-  subset(ahs.design, zone == 105 & smsa == 7400)
pubsub.subset.bay.area <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.subset,
    na.rm = TRUE
  )

df <- as.data.frame(ftable(pubsub.subset.bay.area))
zones <- append(zones,105) 
smsas <- append(smsas,7400)
units <- append(units,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="A","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="A","Freq"]))
std_err <- append(std_err,sum(df[df$Var1=="factor(fpubsub)6" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)7" & df$Var2=="B","Freq"],
df[df$Var1=="factor(fpubsub)8" & df$Var2=="B","Freq"]))

df <- data.frame(zones, smsas, units, std_err)

write.table(df,file="ahs_deed_restricted_by_zone.csv", sep=",")
