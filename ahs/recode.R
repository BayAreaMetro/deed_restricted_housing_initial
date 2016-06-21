#this script was originally written by anthony j damico
#it was licensed GPL-3

ahs.dbname <- "ahs.db"
#install.packages( c( "sqldf" ) )

library(downloader) # downloads and then runs the source() function on scripts from github
library(survey)     # load survey package (analyzes complex design surveys)
library(RSQLite)    # load RSQLite package (creates database files in R)
library(sqldf)      # load the sqldf package (enables sql queries on data frames)

# R will exactly match SUDAAN results and Stata with the MSE option results
options( survey.replicates.mse = TRUE )

db <- dbConnect( SQLite() , ahs.dbname )

#dbSendQuery( db , "CREATE TABLE recoded_tnewhouse_trepwgt_2011_nationalandmetropolitanv14 AS SELECT * FROM tnewhouse_trepwgt_2011_nationalandmetropolitanv14" )

dbSendQuery( db , "ALTER TABLE recoded_tnewhouse_trepwgt_2011_nationalandmetropolitanv14 ADD COLUMN fpubsub INTEGER" )


#
# \--                                         \(STATUS = 1 and TENURE = 2-3) or \
# \                                           \(STATUS = 2-3 and (VACANCY = 1-2 or VACANCY = 4))
# \
# \[B]Rent Reductions
# \
# \No subsidy                                 \PUBSUB = 1 or PUBSUB = 2 or PUBSUB = 3 or \
# \\PUBSUB = 4 or PUBSUB = 5
# \  Rent control                             \PUBSUB = 1
# \  No rent control                          \PUBSUB = 2 or PUBSUB = 3 or PUBSUB = 4
# \    Reduced by owner                       \PUBSUB = 2
# \    Not reduced by owner                   \PUBSUB = 3
# \    Owner reduction not reported           \PUBSUB = 4
# \  Rent control not reported                \PUBSUB = 5
# \Owned by public housing authority          \PUBSUB = 6
# \Government subsidy                         \PUBSUB = 7
# \Other income verification                  \PUBSUB = 8
# \Subsidy not reported                       \PUBSUB = 9



#   |if (STATUS eq 1 and TENURE eq 2-3) or (STATUS eq 2-3 and (VACANCY eq 1-2 or VACANCY eq 4) then do;
# |   if PROJ eq 1 then PUBSUB = 6;
# |   else if (SUBRNT eq 1 and PROJ ne 1) or VCHER eq 1 or APPLY eq 1 then PUBSUB = 7;
# |   else if RENEW eq 1 and PROJ ne 1 and SUBRNT ne 1 and VCHER ne 1 and apply ne 1 then PUBSUB = 8;
# |   else if RCNTRL eq 1 then PUBSUB = 1;
# |   else if SUBRNT eq 2 and RENEW = 2 and (RCNTRL eq 'D' or RCNTRL eq 'R' or RCNTRL eq ' ') then PUBSUB = 5;
# |   else if RCNTRL eq 2 and RNTADJ eq 1 then PUBSUB = 2;
# |   else if RCNTRL eq 2 and RNTADJ eq 2 then PUBSUB = 3;
# |   else if RCNTRL eq 2 and ((RNTADJ eq 'D' or RNTADJ eq 'R' or RNTADJ eq ' ') or
#                              |      (STATUS eq 2-3 and (VACANCY eq 1-2 or VACANCY eq 4) and RNTADJ eq 'B')) then PUBSUB = 4;
# |   else PUBSUB = 9;

dbSendQuery(db , "
UPDATE recoded_tnewhouse_trepwgt_2011_nationalandmetropolitanv14
SET fpubsub =
  CASE
      WHEN
      (
        (
          status = '1' AND
          (
          tenure IN (2,3)
          )
        )
        OR
        (
          (
           status in (2,3)
          )
          AND
          (
           vacancy IN (1,2,4)
          )
        )
      )
      THEN
          CASE
          WHEN proj = '1'
            THEN 6
          WHEN rcntrl = '1'
            THEN 1
          WHEN ((subrnt = 1 AND proj != 1) OR vcher = 1 OR apply = 1)
            THEN 7
          WHEN (renew = 1 AND proj != 1 AND subrnt != 1 AND vcher != 1 AND apply != 1) THEN 8
          WHEN rcntrl = 1 THEN 1
          WHEN (subrnt = 2 AND renew = 2 AND (rcntrl = 'D' OR rcntrl = 'R' OR rcntrl = ' ')) THEN 5
          WHEN (rcntrl = 2 AND rntadj = 1) THEN 2
          WHEN (rcntrl = 2 AND rntadj = 2) THEN 3
          WHEN (rcntrl = 2 AND ((rntadj = 'D' OR rntadj = 'R' OR rntadj = ' ') OR
                  (status = 2-3 AND (vacancy = 1-2 OR vacancy = 4) AND rntadj = 'B'))) THEN 4
          else 9
          END
      ELSE 10
  END
;" )

#check on stuff
dbGetQuery(db , "
                        SELECT zone, fpubsub, tenure, status, vacancy, COUNT(*)
                       from recoded_tnewhouse_trepwgt_2011_nationalandmetropolitanv14
                       group by zone, fpubsub, tenure, status, vacancy
                       ;")
 
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

bay_area_smsa <- ahs_bay_area_zones[["SMSA"]]

ahs.design.bay_area <- subset( ahs.design , smsa %in% c(5775,7360,7400))

svyby(
  ~one ,
  ~zone ,
  ahs.design.bay_area ,
  unwtd.count
)

svyby(
  ~one ,
  ~zone ,
  ahs.design.bay_area ,
  svytotal
)

pubsub.total.bay.area <-
     svytotal(
         ~factor( fpubsub ) ,
         design = ahs.design.bay_area ,
         na.rm = TRUE
       )

ahs_geographies_bay_area <- read.csv("~/Projects/ahs/ahs_geographies_bay_area.csv")


estimate_pubsub <- function(designobj, zone_id){
  ahs.design.bay_area.test <- subset(ahs.design, zone == 110)
  pubsub.total.bay.area.test <-
    svytotal(
      ~factor( fpubsub ) ,
      design = ahs.design.bay_area.test ,
      na.rm = TRUE
    )
  return(ftable(pubsub.total.bay.area.test))
}

somevar = 110



pubsub.total.bay.area.test <-
  svytotal(
    ~factor( fpubsub ) ,
    design = ahs.design.bay_area.test ,
    na.rm = TRUE
  )
ftable(pubsub.total.bay.area.test)



