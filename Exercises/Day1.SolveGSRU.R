
#Create matrices
y<-c(20,25,30,35,20,30)
X<-matrix(c(
     1,0,0,
     1,0,0,
     0,1,0,
     0,1,0,
     0,0,1,
     0,0,1),ncol=3,byrow = T)
Z<-matrix(c(1,0,
            1,0,
            1,0,
            0,1,
            0,1,
            0,1),ncol=2,byrow = T)

XZ<-cbind(X,Z)

##Initial parameters
niter=10000 #number of iterations
ve=100;vp=30 #variances values 
beta_hat<-rnorm(dim(XZ)[2])*0.1 #initial beta

#work with residuals
residuals<-y-beta_hat%*%t(XZ)

#Solve system with Gauss-Seidel and residual updates
for (iter in 1:niter){

    for (j in 1:dim(XZ)[2]){
        xpx<-sum(crossprod(XZ[,j],XZ[,j]))
        temp<-residuals+beta_hat[j]*XZ[,j]
        beta_hat[j]<-(sum(XZ[,j]*temp))/(xpx)
        if (j>dim(X)[2]) beta_hat[j]<-(sum(XZ[,j]*temp))/(xpx + ve/vp)
        residuals<-temp-beta_hat[j]*XZ[,j]
    }

}

beta_hat

#Inversion of matrices
C<-rbind( cbind(t(X)%*%X,t(X)%*%Z) , cbind(t(Z)%*%X,t(Z)%*%Z+diag(dim(Z)[2])*ve/vp) )
rhs<-rbind(t(X)%*%y,t(Z)%*%y)
solve(C)%*%rhs
