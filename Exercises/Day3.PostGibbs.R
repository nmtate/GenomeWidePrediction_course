rm(list=ls())

#Importing the files with the chains of variance components, systematic effects, model mean and residual variance
varE <- read.table(file='../Day3_BGLR/output/VanRaden_GAvarE.dat')

varU <- read.table(file='../Day3_BGLR/output/VanRaden_GAETA_GRM_varU.dat')

mu <- read.table(file='../Day3_BGLR/output/VanRaden_GAmu.dat')

##################################################################
##################################################################
############visual inspection of the chains#######################
##################################################################
##################################################################

# function to calculate the running mean 
runmeans <- function(data){
  means <- cumsum(data)/seq_along(data)
  return(means)
}


par(mfrow=c(2, 2))

plot(runmeans(varU$V1),col=2,xlab='iterations', ylab='Running mean of the genomic variance', type='l')

plot(runmeans(varE$V1),col=2,xlab='iterations', ylab='Running mean of the residual variance',type='l')

plot(runmeans(mu$V1),col=2,xlab='iterations', ylab='Running mean of the model mean',type='l')

#trace
par(mfrow=c(2, 2))

totaliter = 50000

plot(1:totaliter, varU$V1,col=2,xlab='iterations', ylab='Genomic variance', type='l')

plot(1:totaliter, varE$V1,col=2,xlab='iterations', ylab='Residual variance',type='l')

plot(1:totaliter, mu$V1,col=2,xlab='iterations', ylab='Model mean',type='l')

#use of coda and mcmc packages
#install.packages('coda')

library('coda')


chains_varU_varE_mu <- data.frame(varU = varU$V1, varE = varE$V1, mu = mu$V1)
  
#I transformed the output into an mcmc object

chains_mcmc <- mcmc(as.matrix(chains_varU_varE_mu))

autocorr.diag(chains_mcmc)

autocorr(chains_mcmc)

par(mfrow=c(2, 2))
densplot(chains_mcmc)

#to check the convergence: Geweke's convergence diagnostic
#we obtain the pvalues for the test
2*pnorm(abs(geweke.diag(chains_mcmc)$z),lower.tail = FALSE)

#Plotting the Geweke-Brooks plot
geweke.plot(chains_mcmc)

#heidel.diag
heidel.diag(chains_mcmc)

#Raftery and Lewis diagnostic
raftery.diag(chains_mcmc)

#HPD interval
HPDinterval(chains_mcmc)

#Ploting the trace to inspect the mixing of the chain
traceplot(chains_mcmc)

#Ploting the autocorrelation
autocorr.plot(chains_mcmc)

