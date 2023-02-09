rm(list=ls())

#setwd('C:/Users/melopezdm/OneDrive - Centro Nacional de Investigaciones Oncol?gicas/Physalia_2022/practical_sessions/Day3_BGLR/output')

#We will use the outputs of BGLR of Day 3
j=1

output_training = NULL
output_testing = NULL
temp=NULL

for (i in c('BGLR_VanRaden_GA.RData', 'BGLR_UAR.RData', 'BGLR_UARadj.RData', 'BGLR_Gaussian.RData')){
 print(j)
  load(file=i)
  GRM_type=gsub('.RData','',gsub('BGLR_','', i))

#compute the Pearson and Spearman correlation between the yhat and the observed data in the training set
Pcor_yhat_y_training = cor(fm.COV.GRM$yHat[-fm.COV.GRM$whichNa], fm.COV.GRM$y[-fm.COV.GRM$whichNa])
Scor_yhat_y_training = cor(fm.COV.GRM$yHat[-fm.COV.GRM$whichNa], fm.COV.GRM$y[-fm.COV.GRM$whichNa], method='spearman')

#compute the correlation between the u and the observed data in the training set
Pcor_u_y_training = cor(fm.COV.GRM$ETA$GRM$u[-fm.COV.GRM$whichNa], fm.COV.GRM$y[-fm.COV.GRM$whichNa])
Scor_u_y_training = cor(fm.COV.GRM$ETA$GRM$u[-fm.COV.GRM$whichNa], fm.COV.GRM$y[-fm.COV.GRM$whichNa], method='spearman')

#scatterplot y and yhat
pdf(paste0('scatterplot_yhat_y_training_',GRM_type,'.pdf'))
plot(fm.COV.GRM$yHat[-fm.COV.GRM$whichNa], fm.COV.GRM$ETA$COV$data$trait[-fm.COV.GRM$whichNa],xlab='yHat', ylab='y', main='training')
dev.off()

#scatterplot y and u
pdf(paste0('scatterplot_u_y_training_', GRM_type,'.pdf'))
plot(fm.COV.GRM$ETA$GRM$u[-fm.COV.GRM$whichNa], fm.COV.GRM$ETA$COV$data$trait[-fm.COV.GRM$whichNa],xlab='yHat', ylab='y' , main='training')
dev.off()

#compute the MSE in the training set
MSE_yhat_training = mean((fm.COV.GRM$yHat[-fm.COV.GRM$whichNa]- fm.COV.GRM$y[-fm.COV.GRM$whichNa])**2)

MSE_u_training = mean((fm.COV.GRM$ETA$GRM$u[-fm.COV.GRM$whichNa]- fm.COV.GRM$y[-fm.COV.GRM$whichNa])**2)

#######################################testing###########################################################

#compute the correlation between the yhat and the observed data in the testing set
Pcor_yhat_y_testing = cor(fm.COV.GRM$yHat[fm.COV.GRM$whichNa], fm.COV.GRM$ETA$COV$data$trait[fm.COV.GRM$whichNa])
Scor_yhat_y_testing = cor(fm.COV.GRM$yHat[fm.COV.GRM$whichNa], fm.COV.GRM$ETA$COV$data$trait[fm.COV.GRM$whichNa], method='spearman')

#compute the correlation between the u and the observed data in the testing set
Pcor_u_y_testing = cor(fm.COV.GRM$ETA$GRM$u[fm.COV.GRM$whichNa], fm.COV.GRM$ETA$COV$data$trait[fm.COV.GRM$whichNa])
Scor_u_y_testing = cor(fm.COV.GRM$ETA$GRM$u[fm.COV.GRM$whichNa], fm.COV.GRM$ETA$COV$data$trait[fm.COV.GRM$whichNa], method='spearman')

#scatterplot y and yhat
pdf(paste0('scatterplot_yhat_y_testing_', GRM_type,'.pdf'))
plot(fm.COV.GRM$yHat[fm.COV.GRM$whichNa], fm.COV.GRM$ETA$COV$data$trait[fm.COV.GRM$whichNa],xlab='yHat', ylab='y', main='testing')
dev.off()

#scatterplot y and u
pdf(paste0('scatterplot_u_y_testing_', GRM_type,'.pdf'))
plot(fm.COV.GRM$ETA$GRM$u[fm.COV.GRM$whichNa], fm.COV.GRM$ETA$COV$data$trait[fm.COV.GRM$whichNa],xlab='u', ylab='y', main='testing')
dev.off()

#compute the MSE in the testing set
MSE_yhat_testing = mean((fm.COV.GRM$yHat[fm.COV.GRM$whichNa]- fm.COV.GRM$ETA$COV$data$trait[fm.COV.GRM$whichNa])**2)

MSE_u_testing = mean((fm.COV.GRM$ETA$GRM$u[fm.COV.GRM$whichNa]- fm.COV.GRM$ETA$COV$data$trait[fm.COV.GRM$whichNa])**2)

temp = c( Pcor_yhat_y_training, Scor_yhat_y_training, Pcor_u_y_training, Scor_u_y_training, MSE_yhat_training, MSE_u_training)
output_training = rbind(output_training,temp)
temp = c( Pcor_yhat_y_testing, Scor_yhat_y_testing, Pcor_u_y_testing, Scor_u_y_testing, MSE_yhat_testing, MSE_u_testing)
output_testing = rbind(output_testing,temp)
rownames(output_training)[j] = GRM_type
rownames(output_testing)[j] = GRM_type
colnames(output_training) = c('Pcor_yhat_y_training', 'Scor_yhat_y_training', 'Pcor_u_y_training', 'Scor_u_y_training', 'MSE_yhat_training', 'MSE_u_training')
colnames(output_testing) = c('Pcor_yhat_y_testing', 'Scor_yhat_y_testing', 'Pcor_u_y_testing', 'Scor_u_y_testing', 'MSE_yhat_testing', 'MSE_u_testing')
j=j+1

}
