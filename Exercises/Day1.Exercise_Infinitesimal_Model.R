#Assume k loci regulatin the trait. Each locus has 2 alleless (A y a), with A being the allele with largest effect on the trait (e.g. it codifies for a more efficient protein).
k=20
#Assume that the observable effect for us is beta=Effect(protein_A)-Effect(protein_a)
#Assume all loci have a small effect on the phenotype (infinitesimal)
#Assume many loci affecting the trait (infinitesimal)
#J is the number of alleles with big effect (A)
j=seq(1,2*k,1)
#(2k-j) is the number of alleles with smaller effect (a)

#If random mating, we expect the following probability distribution for inheritance
#C(2K,J)=(1/2)**2K * (2K)!/(J!(2K-J)!)
freq<-0.5**(2*k)*factorial(2*k)/(factorial(j)*factorial(2*k-j))
plot(j,freq,type="b",xlab="Number of A alleles",ylab="density")
