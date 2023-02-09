rm(list=ls())

library('BGLR')
#importing the metadata
data <- read.table('data/meta_data.txt',header=T, stringsAsFactors = F)
rownames(data) <- data$ID

load(file='../Day2/GRM/output/VanRaden_GRM.RData')

load(file='../Day2/GRM/output/UAR_GRM.RData')

load(file='../Day2/GRM/output/UARadj_GRM.RData')

load(file='../Day2/GRM/output/Gaussian_GRM.RData')

list.GRM = list(G_vanRaden$Ga, G_UAR, G_UARadj, G_Gaussian)

dir.create('output')

j=1
output_training = NULL
output_testing = NULL
temp=NULL
for (k in c('VanRaden_GRM', 'UAR_GRM', 'UARadj_GRM', 'Gaussian_GRM')){
  GRM_type=k
  print(k)

#setting the parameters
n.ind = length(data$ID)
total.iter = 20000
burn.in.iter = 10000
folds <- 5

#setting the seed
set.seed(123)

#cross-validation function

ETA.COV.GRM <- list(COV=list(~ as.factor(COHORT) + as.factor(LACTATION) + as.numeric(DIM), data=data, model="FIXED"), GRM=list(K=list.GRM[[j]], model="RKHS"))

sets <- c(rep(1:folds,n.ind/folds),rep(1:(n.ind-length(rep(1:folds,n.ind/folds)))))

sets <- sets[order(runif(n.ind))]

CV <- function(i){
  
  ##############################################################################################
  #I will estimate the predictive ability of the model 
  ##############################################################################################

  yNA <- data$trait
  yNA[which(sets==i)] <- NA
  # dir.create(paste0('RKHS_cov',i))
  fm.COV.GRM <- BGLR(yNA, response_type='gaussian', ETA=ETA.COV.GRM, nIter=total.iter, burnIn=burn.in.iter, thin=1, saveAt=paste0("output/",GRM_type, "_CV",i), S0=0, df0=3, verbose=FALSE)

  #training  
  #Pearson's and Spearman's correlations (y,EBV)
  Pearson_training <- cor(fm.COV.GRM$ETA$GRM$u[which(sets!=i)],fm.COV.GRM$y[which(sets!=i)])
  Spearman_training <- cor(fm.COV.GRM$ETA$GRM$u[which(sets!=i)],fm.COV.GRM$y[which(sets!=i)],method='spearman')
  #Coefficient of determination
  vare_training= var(fm.COV.GRM$y[which(!is.na(fm.COV.GRM$y))] -fm.COV.GRM$yHat[which(!is.na(fm.COV.GRM$y))])
  R2_training = var(fm.COV.GRM$ETA$GRM$u[which(!is.na(fm.COV.GRM$y))])/(var(fm.COV.GRM$ETA$GRM$u[which(!is.na(fm.COV.GRM$y))]) + vare_training)
  
  #testing  
  #Pearson's and Spearman's correlations (y,EBV)
  Pearson_testing <- cor(fm.COV.GRM$ETA$GRM$u[which(sets==i)],data$trait[which(sets==i)])
  Spearman_testing <- cor(fm.COV.GRM$ETA$GRM$u[which(sets==i)],data$trait[which(sets==i)],method='spearman')
  #Coefficient of determination
  vare_testing= var(fm.COV.GRM$ETA$COV$data$trait[which(is.na(fm.COV.GRM$y))] -fm.COV.GRM$yHat[which(is.na(fm.COV.GRM$y))])
  R2_testing = var(fm.COV.GRM$ETA$GRM$u[which(is.na(fm.COV.GRM$y))])/(var(fm.COV.GRM$ETA$GRM$u[which(is.na(fm.COV.GRM$y))]) + vare_testing)
  
   
  return(list(fit=fm.COV.GRM, Pearson_training=Pearson_training, Spearman_training=Spearman_training, R2_training= R2_training,
                              Pearson_testing=Pearson_testing, Spearman_testing=Spearman_testing, R2_testing= R2_testing))
}
proc.time()

sample.CV <- function(j){
  #to parallelize the runs
  #CV.pred.cov <- mclapply(1:folds, CV, mc.cores=10)
  CV.pred.cov <- lapply(1:folds, CV)
}
samples=1 #10
CV.pred.cov.samples <- lapply(1:samples,sample.CV)
proc.time()

Pearson_training = NULL
Spearman_training = NULL
Pearson_testing = NULL
Spearman_testing = NULL
R2_training = NULL
R2_testing = NULL

for (i in 1:folds){
  Pearson_training [i]<- CV.pred.cov.samples[[1]][[i]]$Pearson_training
  Spearman_training [i]<- CV.pred.cov.samples[[1]][[i]]$Spearman_training
  R2_training [i]<- CV.pred.cov.samples[[1]][[i]]$R2_training
  Pearson_testing [i]<- CV.pred.cov.samples[[1]][[i]]$Pearson_testing
  Spearman_testing [i]<- CV.pred.cov.samples[[1]][[i]]$Spearman_testing
  R2_testing [i]<- CV.pred.cov.samples[[1]][[i]]$R2_testing
}
Pearson_training_mean = mean(Pearson_training)
Pearson_testing_mean = mean(Pearson_testing)
Spearman_training_mean = mean(Spearman_training)
Spearman_testing_mean = mean(Spearman_testing)
R2_training_mean = mean(R2_training)
R2_testing_mean <- mean(R2_testing)

temp = c( Pearson_training_mean, Spearman_training_mean, R2_training_mean)
output_training = rbind(output_training,temp)
temp = c( Pearson_testing_mean, Spearman_testing_mean, R2_testing_mean)
output_testing = rbind(output_testing,temp)
rownames(output_training)[j] = GRM_type
rownames(output_testing)[j] = GRM_type
colnames(output_training) = c('Pearson_training_mean', 'Spearman_training_mean', 'R2_training_mean')
colnames(output_testing) = c('Pearson_testing_mean', 'Spearman_testing_mean', 'R2_testing_mean')
j=j+1

save( CV.pred.cov.samples, file=paste0('output/5_CV',GRM_type,'.RData'))
print(j)
}
