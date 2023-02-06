# Genomewide_prediction 

**Material for the Course "GENOME-WIDE PREDICTION OF COMPLEX TRAITS IN HUMANS, PLANTS AND ANIMALS (GWP)"**

Instructors: *Evangelina Lopez de Maturana, Oscar Gonzalez-Recio, *

This course will introduce students to perform prediction of complex traits using genomic information. 
Each day the course will start at **14:00** and end at **20:00** (CET).

<!-- timetable: [here](https://docs.google.com/spreadsheets/d/1Cy8vBD6I_no8UPzYPU9bz7ASWyI3bc4Y9vcdr5S1TBw/edit#gid=0) -->

## Preparatory_steps: 
For computing, we will use our EC2 AWS cloud, where most of the software needed for this course are already installed.

You will, therefore, only need a few applications installed on your laptop:
 SSH client
 Windows: [MobaXterm](https://mobaxterm.mobatek.net/download.html)

 Mac/Linux: not required, terminal should be installed as standard
 
 FTP client - transfers files to/from the server
 Windows/Mac/Linux -[Filezilla Client](https://filezilla-project.org/download.php?type=client)

This is my recommendation but any FTP client should be fine, including Mac/Linux built-in

Please make sure that you have installed on your laptop [R](https://cran.r-project.org/) and [RStudio](https://www.rstudio.com/products/rstudio/download/#download)

Once you have R and R Studio installed on your laptop, please install this list of packages using this command:
```
 rpkgs<-c("BGLR", "snpReady", "data.table", "pheatmap", "rsample", "coda", "ggplot2", "ROCR", "tidyverse", "rmarkdown","knitr", "pander")
 install.packages(rpkgs)
```

It is likely that when you install snpReady you get a message saying that ‘impute’ R package is necessary. You can install it as follows.
```
 if (!require("BiocManager", quietly = TRUE))
 install.packages("BiocManager")
 BiocManager::install("impute")
```

The ultimate check whether a package installation was successful is to load the package into your R session via:

 > library(<packagename>)
 #eg library(ggplot2)

## Content of the course

**Day 1**: Concepts review
- Presentation (E&O)
- General Introduction / Overview of the Course [General Introduction]<!--(slides/0_General_Introduction.pdf)-->
- Introduction to Genome-wide Prediction in Human genetics and Animal and Plant breeding. Breeding value vs Polygenic Risk Score. Factors affecting reliability of GWP. (E). [Slides](slides/Day1.IntroductiontoGWPinHGandAandPbreeding2023.pdf)
- Review of Quantitative genetics. [Slides](slides/Day1.Review_Quantitative_Genetics.pdf)
- Linear mixed models. [Slides](slides/Day1.Linear_Mixed_Models.pdf)
- Genotype imputation procedures (design the reference population). [Slides](slides/Day1.Genotypeimputation.pdf)
- Lab 1: imputation. [code](Exercises/Day1.script_toimpute.txt)

**Day 2**: Imputation
- The ‘Curse’ of Dimensionality in large p small n problems. Regularization and shrinkage estimation (O)
- Breakout-rooms: Design of analytical approaches. (E&O)
- Resemblance among relatives: Pedigree vs Genomic-based. (E). 
- Lab 2: building relationship matrices (E).

**Day 3**: Kernel and Bayesian regression methods for GWP
- GBLUP and Kernel-based regression models. (E&O)
- Lab 3: (GBLUP,RKHS). 
- Bayesian alphabet (Methods on SNP regression). (O)
- Lab 4: (Bayes L).
- Review on post-Gibbs convergence and McMC chains inspection analysis. (E)
- Hands-on Post Gibbs (E&O)

**Day 4**: Machine Learning methods for GWP
- Predictive ability metrics: MSE, Pearson and Spearman correlations, AUC-ROC curves. (E)
- Cross validation strategies
- Machine Learning (Advantages and disadvantages). (O)
- Random Forest (O)
- Lab 5: RanFog (O)
- Boosting (O)
- Lab 6: RanBoost(O)
- Other ML approaches and wrap up. (O)

**Day 5**: Practical session
- Build your own Genome-enabled prediction. Breakout rooms
        Imputation
        Determine your predictive accuracy (internal)
        Hackathon: Predict yet-to-be observed phenotypes

## Organization of the code for the practical Sessions
**Day 1**
 - [Code](Exercises/Day1.Exercise_Infinitesimal_Model.R) example to show the infinitesimal model
 - [Exercise](Exercises/Day1.SolveGSRU.R) on solving equations using residual updates.
 - [Imputation](Exercises/Day1.script_toimpute.txt)
