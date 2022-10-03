library(readxl)
library(cgwtools)
library(scorekeeper)
library(tibble)
library(dplyr)
library(haven)
library(labelled)

#Loads BAM Raw Data
load('data/hbam_surveys_2021_2022.Rdata')

#discards consent data
hbam_surveys <- as_tibble(hbam_surveys_2021_2022) |> 
  filter(redcap_event_name != 'consent_arm_1') |> 
  mutate(gad_nervous = (as.double(gad_nervous))) |> 
  mutate(gad_worry = as.double(gad_worry)) |> 
  mutate(gad_worrydifferent = as.double(gad_worrydifferent)) |> 
  mutate(gad_relax = as.double(gad_relax)) |> 
  mutate(gad_restless = as.double(gad_restless)) |> 
  mutate(gad_annoy = as.double(gad_annoy)) |> 
  mutate(gad_afraid = as.double(gad_afraid))

#Loads All Individual Scoresheets (Alphabetical by Measure)

# Not Ready dwhq_score <- read_xlsx("scoresheets/WDHQ_scoresheet.xlsx")
# Not Ready ed_hx_score <- read_xlsx('scoresheets/ED_history_scoresheet.xlsx')
epsi_score <- read_xlsx("scoresheets/EPSI_scoresheet.xlsx")
gad7_score <- read_xlsx("scoresheets/GAD7_scoresheet.xlsx")
gffs_score <- read_xlsx("scoresheets/GFFS_scoresheet.xlsx")
ibss_score <- read_xlsx("scoresheets/IBSS_scoresheet.xlsx")
phq9_score <- read_xlsx("scoresheets/PHQ_scoresheet.xlsx")
sataq_score <- read_xlsx("scoresheets/SATAQ_scoresheet.xlsx")
umb_score <- read_xlsx("scoresheets/UMB-fat_scoresheet.xlsx")


#Cleans and saves cleaned data for each measure 

epsi_scored <- scorekeep(hbam_surveys, epsi_score)
EPSI <- epsi_scored[[5]]
save(EPSI, file = 'BAM_H_clean.RData')


gad7_scored <- scorekeep(hbam_surveys, gad7_score)
GAD7 <- gad7_scored[[6]]
resave(GAD7, file = 'BAM_H_clean.RData')
