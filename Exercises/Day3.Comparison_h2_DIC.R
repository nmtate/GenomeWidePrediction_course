rm(list=ls())

workdir = 'C:/Users/melopezdm/OneDrive - Centro Nacional de Investigaciones Oncológicas/Physalia_2023/practical_sessions/Day3_BGLR/'

setwd(paste0(workdir,'output/'))

load(file='h2_DIC_VanRaden_GA.RData')
load(file='h2_DIC_UAR.RData')
load(file='h2_DIC_UARadj.RData')
load(file='h2_DIC_Gaussian.RData')

total_output <- rbind(output_vanRaden, output_UAR, output_UARadj, output_Gaussian)

rownames(total_output) = c('vanRaden_Ga', 'UAR', 'UAR_adj', 'Gaussian')

total_output