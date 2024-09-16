###################################################################
###
### R script for 2025 SGP analyses for NM MSSA
###
###################################################################:w

### Load packages
require(SGP)
require(data.table)

### Load data
load("Data/New_Mexico_SGP.Rdata")
load("Data/New_Mexico_Data_LONG_2025.Rdata")

### Parameters
parallel.config <- list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4, BASELINE_PERCENTILES=4, PROJECTIONS=4, LAGGED_PROJECTIONS=4, SGP_SCALE_SCORE_TARGETS=4))

### Run abcSGP
New_Mexico_SGP <- updateSGP(
        what_sgp_object = New_Mexico_SGP,
        with_sgp_data_LONG = New_Mexico_Data_LONG_2025,
        steps = c("prepareSGP", "analyzeSGP", "combineSGP", "summarizeSGP", "visualizeSGP", "outputSGP"),
        sgp.percentiles = TRUE,
        sgp.projections = TRUE,
        sgp.projections.lagged = TRUE,
        sgp.percentiles.baseline = FALSE,
        sgp.projections.baseline = FALSE,
        sgp.projections.lagged.baseline = FALSE,
	sgPlot.demo.report = TRUE,
        save.intermediate.results = FALSE,
        parallel.config = parallel.config
)

### Save results
save(New_Mexico_SGP, file="Data/New_Mexico_SGP.Rdata")
