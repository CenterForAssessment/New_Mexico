###################################################################
###
### R script for 2023 SGP analyses for NM MSSA
###
###################################################################:w

### Load packages
require(SGP)
require(data.table)

### Load data
load("Data/New_Mexico_Data_LONG.Rdata")

### Parameters
parallel.config <- list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4, BASELINE_PERCENTILES=4, PROJECTIONS=4, LAGGED_PROJECTIONS=4, SGP_SCALE_SCORE_TARGETS=4))

### Run abcSGP
New_Mexico_SGP <- abcSGP(
        sgp_object = New_Mexico_Data_LONG,
        steps = c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
        sgp.percentiles = TRUE,
        sgp.projections = TRUE,
        sgp.projections.lagged = TRUE,
        sgp.percentiles.baseline = FALSE,
        sgp.projections.baseline = FALSE,
        sgp.projections.lagged.baseline = FALSE,
        parallel.config = parallel.config
)

### Save results
save(New_Mexico_SGP, file="Data/New_Mexico_SGP.Rdata")