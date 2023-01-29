# build setting
remote_theme: pages-themes/architect@v0.2.0
plugins:
- jekyll-remote-theme # add this line to the plugins list if you already have one

# GWP
GENOME-WIDE PREDICTION OF COMPLEX TRAITS IN HUMANS, PLANTS AND ANIMALS

**Material for the Course "GENOME-WIDE PREDICTION OF COMPLEX TRAITS IN HUMANS, PLANTS AND ANIMALS (GWP)"**

Instructors: *Evangelina Lopez de Maturana, Oscar Gonzalez-Recio, *

This course will introduce students, 
Each day the course will start at **14:00** and end at **20:00** (CET).

<!-- timetable: [here](https://docs.google.com/spreadsheets/d/1Cy8vBD6I_no8UPzYPU9bz7ASWyI3bc4Y9vcdr5S1TBw/edit#gid=0) -->


## Organization of the Code for the practical Sessions

1. preparatory_steps: 


## Content of the course

**Day 1**: Concepts review
- Presentation (E&O)
- Lecture 0	General Introduction / Overview of the Course []
- [General Introduction]<!--(slides/0_General_Introduction.pdf)-->
- Introduction to Genome-wide Prediction in Human genetics and Animal and Plant breeding. Breeding value vs Polygenic Risk Score. Factors affecting reliability of GWP. (E)
- Review of Quantitative genetics. (O)
- Linear mixed models. (O)
- Genotype imputation procedures (design the reference population).(E)
- Lab 1: imputation. (E)

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

