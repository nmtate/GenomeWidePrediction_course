rm(list=ls())
library(ROCR)
#setwd('C:/Users/melopezdm/OneDrive - Centro Nacional de Investigaciones Oncol?gicas/Physalia_2022/practical_sessions/Day4_metrics/')

#I set the directory to Day4_metrics

# I import the file with the observed binary data
obs <- read.table('data/labels_obs.txt')

#I load the object with the results from the CV analysis with BGLR and VanRaden's matrix
mean_auc = NULL
sd_auc = NULL
j=1

par(mfrow=c(2, 2))

dir.create('output')
for (GRM_type in c('VanRaden_GRM', 'UAR_GRM', 'UARadj_GRM', 'Gaussian_GRM')){
load(file=paste0('../Day4_CV/output/5_CV',GRM_type,'.RData'))
  print(GRM_type)

nfolds = 5

predictions = NULL
obs_testing = NULL

for (i in 1:nfolds) {
  predictions[[i]] <- CV.pred.cov.samples[[1]][[i]]$fit$ETA$GRM$u[CV.pred.cov.samples[[1]][[i]]$fit$whichNa] 
  obs_testing[[i]] <- obs$V1[CV.pred.cov.samples[[1]][[i]]$fit$whichNa]
}
pred <- prediction(predictions, obs_testing)
perf <- performance(pred,"tpr","fpr")
plot(perf, avg='vertical',  spread.estimate='stderror', lwd=3, main=GRM_type)
plot(perf,col="grey82",lty=3, add = T)

auc <- performance(pred, measure = "auc")
auc@y.values

mean_auc[GRM_type] = mean(unlist(auc@y.values))
sd_auc[GRM_type] = sd(unlist(auc@y.values))

j = j+1

}
