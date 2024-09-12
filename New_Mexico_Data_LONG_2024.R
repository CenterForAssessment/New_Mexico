########################################################################################################
###
### Data prep script for 2022 and 2023 New Mexico Measures of Student Success and Achievement (MSSA)
###
########################################################################################################

### Load packages
require(data.table)

### Load data
New_Mexico_Data_LONG <- fread("Data/Base_Files/New_Mexico_Data_LONG_081324.csv")

### Tidy up data
New_Mexico_Data_LONG[CONTENT_AREA=="MATH", CONTENT_AREA:="MATHEMATICS"]
setnames(New_Mexico_Data_LONG, c("GRADE", "TestGr"), c("GRADE_ENROLLED", "GRADE"))
New_Mexico_Data_LONG[,GRADE:=as.character(GRADE)]
New_Mexico_Data_LONG[YEAR=="2021-22", YEAR:="2022"]
New_Mexico_Data_LONG[YEAR=="2022-23", YEAR:="2023"]
New_Mexico_Data_LONG[,ID:=as.character(ID)]
New_Mexico_Data_LONG[,SCALE_SCORE:=as.numeric(SCALE_SCORE)]
New_Mexico_Data_LONG[,ACHIEVEMENT_LEVEL:=as.factor(ACHIEVEMENT_LEVEL)]
setattr(New_Mexico_Data_LONG$ACHIEVEMENT_LEVEL, "levels", c("Novice", "Nearing Proficiency", "Proficient", "Advanced"))
New_Mexico_Data_LONG[,ACHIEVEMENT_LEVEL:=as.character(ACHIEVEMENT_LEVEL)]
New_Mexico_Data_LONG[Female.2==1, GENDER:="Female"]
New_Mexico_Data_LONG[Male.3==1, GENDER:="Male"]
New_Mexico_Data_LONG[,c("Female.2", "Male.3"):=NULL]

setnames(New_Mexico_Data_LONG, c("Hispanic.4", "White.5", "Black.6", "Asian.7", "Native.8", "Multirace.9"), c("HISPANIC", "WHITE", "BLACK", "ASIAN", "NATIVE", "MULTIRACE"))
New_Mexico_Data_LONG[WHITE==1,ETHNICITY:="White"]
New_Mexico_Data_LONG[ASIAN==1,ETHNICITY:="Asian"]
New_Mexico_Data_LONG[BLACK==1,ETHNICITY:="Black"]
New_Mexico_Data_LONG[HISPANIC==1,ETHNICITY:="Hispanic"]
New_Mexico_Data_LONG[NATIVE==1,ETHNICITY:="Native"]
New_Mexico_Data_LONG[MULTIRACE==1,ETHNICITY:="Multirace"]

setnames(New_Mexico_Data_LONG, c("FRL.10", "DirectCert.12", "SwD.14", "EL.16","Migrant.18", "Homeless.19", "Military.20", "Foster.21"),
    c("FREE_REDUCED_LUNCH_STATUS", "DIRECT_CERTIFICATION_STATUS", "DISABILITY_STATUS", "ENGLISH_LANGUAGE_LEARNER_STATUS", "MIGRANT_STATUS", "HOMELESS_STATUS", "MILITARY_STATUS", "FOSTER_STATUS"))

New_Mexico_Data_LONG[,FREE_REDUCED_LUNCH_STATUS:=as.factor(FREE_REDUCED_LUNCH_STATUS)]
setattr(New_Mexico_Data_LONG$FREE_REDUCED_LUNCH_STATUS, "levels", c("Free Reduced Lunch: No", "Free Reduced Lunch: Yes"))

New_Mexico_Data_LONG[,DIRECT_CERTIFICATION_STATUS:=as.factor(DIRECT_CERTIFICATION_STATUS)]
setattr(New_Mexico_Data_LONG$DIRECT_CERTIFICATION_STATUS, "levels", c("Direct Certification: No", "Direct Certification: Yes"))

New_Mexico_Data_LONG[,DISABILITY_STATUS:=as.factor(DISABILITY_STATUS)]
setattr(New_Mexico_Data_LONG$DISABILITY_STATUS, "levels", c("Disability: No", "Disability: Yes"))

New_Mexico_Data_LONG[,ENGLISH_LANGUAGE_LEARNER_STATUS:=as.factor(ENGLISH_LANGUAGE_LEARNER_STATUS)]
setattr(New_Mexico_Data_LONG$ENGLISH_LANGUAGE_LEARNER_STATUS, "levels", c("English Language Learner: No", "English Language Learner: Yes"))

New_Mexico_Data_LONG[,MIGRANT_STATUS:=as.factor(MIGRANT_STATUS)]
setattr(New_Mexico_Data_LONG$MIGRANT_STATUS, "levels", c("Migrant: No", "Migrant: Yes"))

New_Mexico_Data_LONG[,HOMELESS_STATUS:=as.factor(HOMELESS_STATUS)]
setattr(New_Mexico_Data_LONG$HOMELESS_STATUS, "levels", c("Homeless: No", "Homeless: Yes"))

New_Mexico_Data_LONG[,MILITARY_STATUS:=as.factor(MILITARY_STATUS)]
setattr(New_Mexico_Data_LONG$MILITARY_STATUS, "levels", c("Military: No", "Military: Yes"))

New_Mexico_Data_LONG[,FOSTER_STATUS:=as.factor(FOSTER_STATUS)]
setattr(New_Mexico_Data_LONG$FOSTER_STATUS, "levels", c("Foster: No", "Foster: Yes"))

New_Mexico_Data_LONG[ExclAccountabiltyReason=="", ExclAccountabiltyReason:=as.character(NA)]

setcolorder(New_Mexico_Data_LONG, c(1,2,3,23,4,6:22,5,24:27))

### Save results
save(New_Mexico_Data_LONG, file="Data/New_Mexico_Data_LONG.Rdata")
