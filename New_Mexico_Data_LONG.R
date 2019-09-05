##########################################################
###
### Data prep script for New Mexico ISTATION and PARCC data
###
##########################################################

### Load packages

require(data.table)


### Load data

New_Mexico_Data_LONG <- fread("Data/Base_Files/Istation_SGP.csv", colClasses=rep("character", 10))


### Tidy up data

setnames(New_Mexico_Data_LONG, c("ID", "YEAR", "DISTRICT_NUMBER", "SCHOOL_NUMBER", "TEST_NAME", "CONTENT_AREA", "TEST_LANGUAGE", "TEST_WINDOW", "GRADE", "SCALE_SCORE"))

New_Mexico_Data_LONG[,YEAR:=as.factor(YEAR)]
setattr(New_Mexico_Data_LONG$YEAR, "levels", c("2016_2017", "2017_2018", "2018_2019"))
New_Mexico_Data_LONG[,YEAR:=as.character(YEAR)]
New_Mexico_Data_LONG[TEST_NAME=="ISTAT" & TEST_WINDOW=="Fall", YEAR:=paste0(YEAR, ".FALL")]
New_Mexico_Data_LONG[TEST_NAME=="ISTAT" & TEST_WINDOW=="Winter", YEAR:=paste0(YEAR, ".WINTER")]
New_Mexico_Data_LONG[TEST_NAME=="ISTAT" & TEST_WINDOW=="Spring", YEAR:=paste0(YEAR, ".SPRING")]


New_Mexico_Data_LONG[,DISTRICT_NUMBER:=as.numeric(DISTRICT_NUMBER)]
New_Mexico_Data_LONG[,SCHOOL_NUMBER:=as.numeric(SCHOOL_NUMBER)]

New_Mexico_Data_LONG[CONTENT_AREA=="READ", CONTENT_AREA:="READING"]
New_Mexico_Data_LONG[TEST_NAME=="ISTAT", CONTENT_AREA:=paste0(CONTENT_AREA, "_ISTAT")]

New_Mexico_Data_LONG[,SCALE_SCORE:=as.numeric(SCALE_SCORE)]

New_Mexico_Data_LONG[,VALID_CASE:="VALID_CASE"]

setcolorder(New_Mexico_Data_LONG,c(11,6,2,9,1,10,3,4,5,7,8))


### Test for duplicates

setkey(New_Mexico_Data_LONG, VALID_CASE, CONTENT_AREA, YEAR, GRADE, ID, SCALE_SCORE)
setkey(New_Mexico_Data_LONG, VALID_CASE, CONTENT_AREA, YEAR, GRADE, ID)
New_Mexico_Data_LONG[which(duplicated(New_Mexico_Data_LONG, by=key(New_Mexico_Data_LONG)))-1, VALID_CASE := "INVALID_CASE"]
setkey(New_Mexico_Data_LONG, VALID_CASE, CONTENT_AREA, YEAR, GRADE, ID)


### Save Results

save(New_Mexico_Data_LONG, file="Data/New_Mexico_Data_LONG.Rdata")
