#########################################################################################
###
### R Script to create SGPs for New Mexico
###
#########################################################################################

### Load SGP Package

require(SGP)


### Load data

load("Data/New_Mexico_Data_LONG.Rdata")


### Customize SGPstateData

SGPstateData[['NM']][['SGP_Configuration']] <- NULL


###  Load configs

source("SGP_CONFIG/2018_2019/ELA.R")
source("SGP_CONFIG/2018_2019/READING_ISTAT.R")

New_Mexico.config <- c(ELA.2018_2019.config, READING_ISTAT.2018_2019.config)


### abcSGP

New_Mexico_SGP <- abcSGP(
		New_Mexico_Data_LONG,
		steps=c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
		sgp.config=New_Mexico.config,
		sgp.percentiles=TRUE,
		sgp.projections=FALSE,
		sgp.projections.lagged=FALSE,
		sgp.percentiles.baseline=FALSE,
		sgp.projections.baseline=FALSE,
		sgp.projections.lagged.baseline=FALSE,
		simulate.sgps=FALSE)#,
#		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4)))


#  Save the SGP Object as an .Rdata file:

#save(New_Mexico_SGP, file="Data/New_Mexico_SGP.Rdata")
