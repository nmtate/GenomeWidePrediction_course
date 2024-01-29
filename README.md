# Genomewide_prediction 

**Material for the Course "GENOME-WIDE PREDICTION OF COMPLEX TRAITS IN HUMANS, PLANTS AND ANIMALS (GWP)"**

Instructors: **Evangelina Lopez de Maturana**, **Oscar Gonzalez-Recio**

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
- Introduction to Genome-wide Prediction in Human genetics and Animal and Plant breeding. Breeding value vs Polygenic Risk Score. Factors affecting reliability of GWP. (E). [Slides](slides/Day1.IntroductiontoGWPinHGandAandPbreeding2024.pdf)
- Review of Quantitative genetics. Overview of Reference Populations. [Slides](slides/Day1.Review_Quantitative_Genetics.pdf)
- Linear mixed models. [Slides](slides/Day1.Linear_Mixed_Models.pdf)
- Genotype imputation procedures (design the reference population). [Slides](slides/Day1.Genotypeimputation.pdf)
- Lab 1: imputation. [code](Exercises/Day1.script_toimpute.txt) [training.ped](data/day1/training_tobeimputed.ped) [training.map](data/day1/training_tobeimputed.map) [testing.ped](data/day1/testing_tobeimputed.ped) [testing.map](data/day1/testing_tobeimputed.map) 

**Day 2**: Imputation
- The ‘Curse’ of Dimensionality in large p small n problems. Regularization and shrinkage estimation. [Slides](slides/Day2.CurseOfDimensionality.pdf)
- Breakout-rooms: Design of analytical approaches. (E&O)
- Resemblance among relatives: Pedigree vs Genomic-based. (E). [Slides](slides/Day2.Resemblanceamongrelatives2023.pdf)
- Lab 2: building relationship matrices (E). [code](Exercises/Day2.GRM_2022.R)  [data](data/day2/data.txt) 

**Day 3**: Kernel and Bayesian regression methods for GWP
- GBLUP and Kernel-based regression models. (E) [Slides](slides/Day3.GBLUPandkernel-basedmodels2024.pdf)
- Lab 3: (GBLUP,RKHS). [meta_data](data/day3/meta_data.txt) [testing_data](data/day3/testing.txt) [BGLR_VanRaden](Exercises/Day3.BGLR_VanRaden_GA.R) [BGLR_UAR](Exercises/Day3.BGLR_UAR.R) [BGLR_UARadj](Exercises/Day3.BGLR_UARadj.R) [BGLR_Gaussian](Exercises/Day3.BGLR_Gaussian.R)
- Bayesian alphabet (Methods on SNP regression). (O) [Slides](slides/Day3.Bayesianalphabet.pdf)
- Lab 4: [Bayesian Lasso](https://github.com/ogrecio/BLasso)
- Review on post-Gibbs convergence and McMC chains inspection analysis. (E) [Slides](slides/Day3.PostGibbs.pdf)
- Hands-on Post Gibbs (E) [code_toyGS](Exercises/Day3.Simple_example_GS1.R) [code_postGibbs](Exercises/Day3.PostGibbs.R)

**Day 4**: Machine Learning methods for GWP
- Predictive ability metrics: MSE, Pearson and Spearman correlations, AUC-ROC curves. (E) [Slides](slides/Day4.Predictiveabilitymetrics.pdf) [data](data/day4/labels_obs.txt) [code_AUC](Exercises/Day4.AUC.R) [code_Metrics](Exercises/Day4.Metrics.R)
- Cross validation strategies (E) [Slides](slides/Day4.Cross-validationstrategies2023.pdf) [data](data/day4/meta_data.txt) [code_CV](Exercises/Day4.CV.R) 
- Machine Learning (Advantages and disadvantages). [Slides](slides/Day4.MachineLearning.pdf)(O)
- Random Forest (O)
- Lab 5: [RanFog](https://github.com/ogrecio/RanFog) (O)
- Boosting (O)
- Lab 6: [RanBoost](https://github.com/ogrecio/RanBoost)(O)
- Other ML approaches and wrap up. (O)

**Day 5**: Practical session
- Build your own Genome-enabled prediction. Breakout rooms
 
 This is your [reference population](data/hackathon/training_hack.ped) and the corresponding [map file](data/hackathon/training_hack.map), and these are the [candidate individuals](data/hackathon/testing_hack.ped) and [SNP map file](data/hackathon/testing_hack.map) to predict their genomic value.
 
 Hackathon steps:
 - Imputation
 - Determine your predictive accuracy (internal), with different methods/models
 - Predict yet-to-be observed phenotypes with your preferred method(s)
 - submit results to instructors for final check

## Organization of the code for the practical Sessions
 
**Day 1**
 - [Code](Exercises/Day1.Exercise_Infinitesimal_Model.R) example to show the infinitesimal model
 - [Exercise](Exercises/Day1.SolveGSRU.R) on solving equations using residual updates.
 - [Imputation](Exercises/Day1.script_toimpute.txt)
 
**Day 3**
 - [Bayesian Lasso](https://github.com/ogrecio/BLasso)
 
**Day 4**
 - [RanFog](https://github.com/ogrecio/RanFog)
 - [RanBoost](https://github.com/ogrecio/RanBoost)
