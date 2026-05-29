########################################################################################################
###
### Data prep script for 2023 & 2024 New Mexico Measures of Student Success and Achievement (MSSA)
###
########################################################################################################

### Load packages
require(data.table)

### Load data
New_Mexico_Data_LONG <- fread("Data/Base_Files/2023-24 AMD Prep SGPs.csv")
New_Mexico_CSEM_Data <- fread("Data/Base_Files/MSSA-CSEM.csv")

### Tidy up data
New_Mexico_Data_LONG[CONTENT_AREA=="MATH", CONTENT_AREA:="MATHEMATICS"]
New_Mexico_Data_LONG[CONTENT_AREA=="LA", CONTENT_AREA:="ELA"]
setnames(New_Mexico_Data_LONG, c("GRADE", "TestGr"), c("GRADE_ENROLLED", "GRADE"))
New_Mexico_Data_LONG[,GRADE:=as.character(GRADE)]
New_Mexico_Data_LONG[YEAR=="2021-22", YEAR:="2022"]
New_Mexico_Data_LONG[YEAR=="2022-23", YEAR:="2023"]
New_Mexico_Data_LONG[YEAR=="2023-24", YEAR:="2024"]
New_Mexico_Data_LONG[,ID:=as.character(ID)]
New_Mexico_Data_LONG[,SCALE_SCORE:=as.numeric(SCALE_SCORE)]

New_Mexico_Data_LONG[,ACHIEVEMENT_LEVEL:=as.factor(ACHIEVEMENT_LEVEL)]
setattr(New_Mexico_Data_LONG$ACHIEVEMENT_LEVEL, "levels", c("Novice", "Nearing Proficiency", "Proficient", "Advanced"))
New_Mexico_Data_LONG[,ACHIEVEMENT_LEVEL:=as.character(ACHIEVEMENT_LEVEL)]

New_Mexico_Data_LONG[,FRL.10:=as.factor(FRL.10)]
setattr(New_Mexico_Data_LONG$FRL.10, "levels", c("Free Reduced Lunch: No", "Free Reduced Lunch: Yes"))

New_Mexico_Data_LONG[,DirectCert.12:=as.factor(DirectCert.12)]
setattr(New_Mexico_Data_LONG$DirectCert.12, "levels", c("Direct Certification: No", "Direct Certification: Yes"))

New_Mexico_Data_LONG[,SwD.14:=as.factor(SwD.14)]
setattr(New_Mexico_Data_LONG$SwD.14, "levels", c("Disability: No", "Disability: Yes"))

New_Mexico_Data_LONG[,EL.16:=as.factor(EL.16)]
setattr(New_Mexico_Data_LONG$EL.16, "levels", c("English Language Learner: No", "English Language Learner: Yes"))

New_Mexico_Data_LONG[,Migrant.18:=as.factor(Migrant.18)]
setattr(New_Mexico_Data_LONG$Migrant.18, "levels", c("Migrant: No", "Migrant: Yes"))

New_Mexico_Data_LONG[,Homeless.19:=as.factor(Homeless.19)]
setattr(New_Mexico_Data_LONG$Homeless.19, "levels", c("Homeless: No", "Homeless: Yes"))

New_Mexico_Data_LONG[,Military.20:=as.factor(Military.20)]
setattr(New_Mexico_Data_LONG$Military.20, "levels", c("Military: No", "Military: Yes"))

New_Mexico_Data_LONG[,Foster.21:=as.factor(Foster.21)]
setattr(New_Mexico_Data_LONG$Foster.21, "levels", c("Foster: No", "Foster: Yes"))

New_Mexico_Data_LONG[ExclAccountabiltyReason=="", ExclAccountabiltyReason:=as.character(NA)]

setnames(New_Mexico_Data_LONG, "Accountable_School", "SCHOOL_NUMBER")
New_Mexico_Data_LONG[,SCHOOL_NAME:=paste("School", SCHOOL_NUMBER)]

New_Mexico_Data_LONG[!is.na(SCHOOL_NUMBER), SCHOOL_ENROLLMENT_STATUS:="Enrolled School: Yes"]

### Prep and Merge CSEM data
setnames(New_Mexico_CSEM_Data, c("CONTENT_AREA", "GRADE", "RAW_SCORE", "SCALE_SCORE_THETA", "SCALE_SCORE", "ACHIEVEMENT_LEVEL", "SCALE_SCORE_THETA_CSEM", "SCALE_SCORE_CSEM"))
New_Mexico_CSEM_Data[CONTENT_AREA=="MATH", CONTENT_AREA:="MATHEMATICS"]
New_Mexico_CSEM_Data[,GRADE:=as.character(GRADE)]
New_Mexico_CSEM_Data[,SCALE_SCORE:=as.numeric(SCALE_SCORE)]
New_Mexico_CSEM_Data[,ACHIEVEMENT_LEVEL:=NULL]
New_Mexico_CSEM_Data <- New_Mexico_CSEM_Data[CONTENT_AREA %in% c("ELA", "MATHEMATICS")]
New_Mexico_CSEM_Data <- New_Mexico_CSEM_Data[,SCALE_SCORE_CSEM_MEAN:=mean(SCALE_SCORE_CSEM), by=c("CONTENT_AREA", "GRADE")]
for (content_area.iter in c("ELA", "MATHEMATICS")) {
  for (grade.iter in c("3", "4", "5", "6", "7", "8")) {
    tmp.data <- unique(New_Mexico_CSEM_Data[CONTENT_AREA==content_area.iter & GRADE==grade.iter], by=c("CONTENT_AREA", "GRADE", "SCALE_SCORE"))
    tmp.approx.fun <- approxfun(tmp.data$SCALE_SCORE, tmp.data$SCALE_SCORE_CSEM)
    New_Mexico_Data_LONG[CONTENT_AREA==content_area.iter & GRADE==grade.iter, SCALE_SCORE_CSEM:=tmp.approx.fun(SCALE_SCORE)]
  }
}

### Create final data sets
New_Mexico_Data_LONG_2024 <- New_Mexico_Data_LONG[YEAR=="2024"]
New_Mexico_Data_LONG <- New_Mexico_Data_LONG[YEAR!="2024"]

### Save results
save(New_Mexico_Data_LONG, file="Data/New_Mexico_Data_LONG.Rdata")
save(New_Mexico_Data_LONG_2024, file="Data/New_Mexico_Data_LONG_2024.Rdata")
