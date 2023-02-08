rm(list=ls())
require("BGLR")

###################################################################################################
####RKHS model with the following non-genetic covariates:
####COHORT LACTATION DIM
###################################################################################################
#Both metadata and kernel matrix are in the same order
#
data <- read.table('data/meta_data.txt',header=T, stringsAsFactors = F)
rownames(data) <- data$ID

head(data)
#ID trait COHORT LACTATION DIM

load('../Day2/GRM/output/UAR_GRM.RData')

#checking the order in the metadata file and GRM

which(rownames(G_UAR) != data$ID)

#NAs for the outcomes of the individuals in the testing set
test.data <- read.table('data/testing.txt',header=F, stringsAsFactors = F)
rownames(test.data) <- test.data$V2

data$traitNA = data$trait

data$traitNA[which(rownames(data) %in% test.data$V2)] = NA

#I specify the model I am going to analyse using BGLR function
ETA.COV.GRM <- list(COV=list(~ as.factor(COHORT) + as.factor(LACTATION) + as.numeric(DIM), data=data, model="FIXED"), GRM=list(K=G_UAR, model="RKHS"))

dir.create('output')

fm.COV.GRM <- BGLR(y=data$traitNA, response_type='gaussian', ETA=ETA.COV.GRM, nIter=50000, burnIn=10000, thin=1, saveAt="output/UAR", S0=0.5, df0=3, verbose=FALSE)

summary(fm.COV.GRM)

#DIC
fm.COV.GRM$fit$DIC

#Computing the heritability 
vare_UAR = fm.COV.GRM$varE
varu_UAR = fm.COV.GRM$ETA$GRM$varU

h2_UAR_mean = fm.COV.GRM$ETA$GRM$varU/(fm.COV.GRM$ETA$GRM$varU+fm.COV.GRM$varE)

output_UAR <- data.frame (DIC = fm.COV.GRM$fit$DIC, h2 = h2_UAR_mean)

save( fm.COV.GRM, file='output/BGLR_UAR.RData')

save(output_UAR, file='output/h2_DIC_UAR.RData')
