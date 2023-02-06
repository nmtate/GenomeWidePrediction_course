rm(list=ls())

library('snpReady')
# if (!require("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# 
# BiocManager::install("impute")
library(pheatmap)

#loading the file with the SNP genotypes
#set the working directory
workdir = 'C:/Users/melopezdm/OneDrive - Centro Nacional de Investigaciones Oncol?gicas/Physalia_2023/practical_sessions/Day2/GRM/'
setwd(workdir)
data <- read.table('./data/data.txt',header=F)

#Exploring the dataset
data[1:5,1:5] #genotypes start in column 3
dim(data) #647 10667

genotypes <- data[,c(3:ncol(data))]
dim(genotypes)

#Filtering out the monomorphic SNPs
genotypes_filt <- genotypes[,-which(colSums(genotypes)==0 | colMeans(genotypes)==2)] #1275 SNPs are monomorphic
dim(genotypes_filt)
rownames(genotypes_filt) = data$V2 

#Calculating and Inspecting the allele frequency of the SNPs
p <- colMeans(genotypes_filt)/2
summary(p)
#create a folder for the output
dir.create('output')

#https://www.rdocumentation.org/packages/snpReady/versions/0.9.6/topics/G.matrix
#VanRaden's G matrix
G_vanRaden <- G.matrix(genotypes_filt, method="VanRaden", plot = TRUE, format = 'wide') #if format = 'long' returns the low diagonal
save(G_vanRaden, file='output/VanRaden_GRM.RData')


pheatmap(G_vanRaden$Ga, annotation_col = NA, annotation_row = NA,
         show_rownames = FALSE, 
         show_colnames = FALSE, cutree_rows = 4, cutree_cols = 4,
         main = "VanRaden's GRM (Ga)",
         filename = "output/Heatmap_VanRaden_Ga.png")

pheatmap(G_vanRaden$Gd, annotation_col = NA, annotation_row = NA,
         show_rownames = FALSE, 
         show_colnames = FALSE, cutree_rows = 4, cutree_cols = 4,
         main = "VanRaden's GRM (Gd)",
         filename = "output/Heatmap_VanRaden_Gd.png")

#Yang's G matrix 
G_UAR <- G.matrix(genotypes_filt, method="UAR", plot = TRUE, format = 'wide')
save(G_UAR, file='output/UAR_GRM.RData')

pheatmap(G_UAR, annotation_col = NA, annotation_row = NA,
         show_rownames = FALSE, 
         show_colnames = FALSE, cutree_rows = 4, cutree_cols = 4,
         main = "Yang's GRM",
         filename = "output/Heatmap_Yang_GRM.png")


#Yang's G matrix (adjusted)
G_UARadj <- G.matrix(genotypes_filt, method="UARadj", plot = TRUE, format = 'wide')
save(G_UARadj, file='output/UARadj_GRM.RData')

pheatmap(G_UARadj, annotation_col = NA, annotation_row = NA,
         show_rownames = FALSE, 
         show_colnames = FALSE, cutree_rows = 4, cutree_cols = 4,
         main = "Yang's adjusted GRM",
         filename = "output/Heatmap_Yang_adj_GRM.png")

#Gaussian kernel
G_Gaussian <- G.matrix(genotypes_filt, method="GK", plot = TRUE, format = 'wide')

pheatmap(G_Gaussian, annotation_col = NA, annotation_row = NA,
         show_rownames = FALSE, 
         show_colnames = FALSE, cutree_rows = 4, cutree_cols = 4,
         main = "Gaussian GRM",
         filename = "output/Heatmap_Gaussian_GRM.png")

save(G_Gaussian, file='output/Gaussian_GRM.RData')

