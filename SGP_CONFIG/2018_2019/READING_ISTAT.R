################################################################################
###                                                                          ###
###             SGP Configurations for Spring 2019 READING subjects          ###
###                                                                          ###
################################################################################

READING_ISTAT.2018_2019.config <- list(
	READING_ISTAT.2019 = list(
		sgp.content.areas=rep("READING_ISTAT", 2),
		sgp.panel.years=c("2018_2019.1", "2018_2019.3"),
		sgp.grade.sequences=list(c("0", "0"))),

	READING_ISTAT_SPANISH.2019 = list(
		sgp.content.areas=rep("READING_ISTAT_SPANISH", 2),
		sgp.panel.years=c("2018_2019.1", "2018_2019.3"),
		sgp.grade.sequences=list(c("0", "0"))),

	READING_ISTAT.2019 = list(
		sgp.content.areas=rep("READING_ISTAT", 3),
		sgp.panel.years=c("2016_2017.3", "2017_2018.3", "2018_2019.3"),
		sgp.grade.sequences=list(c("0", "1"), c("0", "1", "2"))),

	READING_ISTAT_SPANISH.2019 = list(
		sgp.content.areas=rep("READING_ISTAT_SPANISH", 3),
		sgp.panel.years=c("2016_2017.3", "2017_2018.3", "2018_2019.3"),
		sgp.grade.sequences=list(c("0", "1"), c("0", "1", "2")))
)
