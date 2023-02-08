rm(list=ls())
#use of coda package
#install.packages('coda')

library('coda')
####################################
####Example of a Gibbs Sampling#####
####################################
set.seed(1234)
#My data
y<- rnorm(n = 1000, mean = 27, sd = 10)

pmu=NULL # I create a vector to store the samples for the posterior distribution of the mean
pvar=NULL # I create a vector to store the samples for the posterior distribution of the variance
postNormalGS<-function(niter,yobs) {
  pmu[1] <- 10 # initial value for the mean
  pvar[1] <- 3 # initial value for the variance
  nobs <- length(yobs) # number of observations
  ybar<- mean(yobs) # sample mean
  for (i in 2:niter) {
    #https://en.wikipedia.org/wiki/Scaled_inverse_chi-squared_distribution
    pvar[i] <- sum((y-pmu[i-1])^2)/rchisq(1,df = nobs) #conditional posterior distribution is an scale-inverted chisq
    pmu[i] <- rnorm(1, mean = ybar, sd = sqrt(pvar[i]/nobs)) #conditional posterior distribution is a normal dist
  }
  return(list(pmu.samples=pmu,
              pvar.samples=pvar)) }

totaliter=10000
norm<-postNormalGS(totaliter,y)

##################################################################
##################################################################
############visual inspection of the chains#######################
##################################################################
##################################################################

#trace
par(mfrow=c(1, 2))

plot(1:totaliter, norm$pmu.samples,col=2,xlab='iterations', ylab='Mean value', type='l')

plot(1:totaliter, norm$pvar.samples,col=2,xlab='iterations', ylab='Variance value',type='l')

#I transformed the output into an mcmc object
norm_mat <- matrix(unlist(norm),ncol=2)
colnames(norm_mat) = names(norm)
norm_mcmc <- mcmc(norm_mat)

#Ploting the trace to inspect the mixing of the chain
traceplot(norm_mcmc)

# function to calculate the running mean 
runmeans <- function(data){
  means <- cumsum(data)/seq_along(data)
  return(means)
}


par(mfrow=c(1, 2))
rmns <- lapply(norm,runmeans)
plot(rmns$pmu.samples,col=2,xlab='iterations', ylab='Running mean of the mean', type='l')

plot(rmns$pvar.samples,col=2,xlab='iterations', ylab='Running mean of the variance',type='l')

densplot(norm_mcmc)

autocorr.plot(norm_mcmc)

#to check the convergence: Geweke's convergence diagnostic
2*pnorm(abs(geweke.diag(norm_mcmc)$z),lower.tail = FALSE)

#Plotting the Geweke-Brooks plot
geweke.plot(norm_mcmc)

#Raftery and Lewis diagnostic
raftery.diag(norm_mcmc)

#heidel.diag
heidel.diag(norm_mcmc)
#HPD interval
HPDinterval(norm_mcmc)


