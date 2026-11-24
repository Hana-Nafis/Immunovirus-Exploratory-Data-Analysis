# Applied Data Science – Immunovirus Dataset Analysis

## Project Overview

This project was completed as part of the MA52098 Applied Data Science module for the MSc Statistics and Data Science programme at the University of Bath.

The project explores a longitudinal immunovirus patient dataset through exploratory data analysis (EDA). The analysis investigates patient characteristics, infection status, treatment groups, biomarker measurements, and time to liver disease progression.

The objective was to understand the structure and characteristics of the dataset, identify patterns and relationships between variables, and communicate findings through statistical summaries and visualisations.

## Project Objectives

- Examine the structure, quality, and completeness of the dataset.
- Explore patient characteristics and categorical variables.
- Investigate infection patterns across different patient groups.
- Analyse distributions and relationships between continuous variables.
- Examine biomarker measurements and their association over time.
- Explore differences in time to liver disease across infection status groups.

## Methodology

The analysis was conducted in R and followed an exploratory data analysis approach.

Key stages included:

1. Data loading and inspection – importing the dataset and examining its dimensions, variable types, and structure.
2. Data quality assessment – identifying missing observations and reviewing data completeness.
3. Descriptive analysis – summarising categorical and continuous variables.
4. Distribution analysis – examining variable distributions using appropriate visualisations.
5. Group comparisons – exploring infection rates across categorical variables and comparing continuous measurements by infection status.
6. Time-to-event exploration – examining the distribution of time to liver disease.
7. Biomarker analysis – investigating relationships between baseline and six-month biomarker measurements.
8. Correlation analysis – assessing associations between continuous variables and presenting them using a correlation heatmap.

## Key Findings

- The dataset contained 1,647 observations across 11 variables.
- A total of 50 missing values were identified, concentrated in the Drugs (30) and Homosexual (20) variables.
- Baseline and six-month biomarker measurements showed a positive correlation (r = 0.76), indicating an association between measurements at the two time points.
- The distribution of time to liver disease showed considerable variation across patients, with a median of approximately 999 days.
- Differences in time to liver disease were observed across infection status groups.
- Several continuous variables displayed skewed distributions and potential outliers, highlighting the importance of examining distributions rather than relying solely on summary statistics.

These findings are exploratory and describe patterns within the observed dataset. They do not establish causal relationships.

## Tools and Libraries

- R
- RStudio
- tidyverse
- dplyr
- ggplot2
- tidyr
- readr
- kableExtra
- patchwork

## Repository Structure

```text
MSc-Applied-Data-Science-Immunovirus/
│
├── README.md
├── immunovirus_eda.R
│
└── data/
    └── README.md
```

## Dataset Information

The dataset was supplied for academic coursework at the University of Bath and is not included in this repository because it is not publicly available.

The R script expects the dataset to be named `immunovirus.csv`. An authorised copy must be placed in the appropriate working directory before running the analysis.

See `data/README.md` for further information.

## Reproducibility

The analysis script contains the R code used to perform the exploratory data analysis. The original dataset is required to reproduce the analysis and generate the visualisations.

