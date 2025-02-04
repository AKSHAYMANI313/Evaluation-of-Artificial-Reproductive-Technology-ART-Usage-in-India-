# Evaluation-of-Artificial-Reproductive-Technology-ART-Usage-in-India-
This project focuses on analyzing healthcare data derived from interviews with multiple doctors. The goal is to explore relationships between Artificial Reproductive Technology (ART) usage, social stigma, and socioeconomic factors that may explain ART usage variance. The analysis combines data from 5+ doctors into a unified dataset, computes association metrics, and performs regression analysis to identify key factors influencing ART usage.

Key Steps and Methodology
Data Integration:

Data from interviews with 5+ doctors was combined into a single unified dataset using Excel's VLOOKUP and Pivot Tables. This method ensured that the doctor-specific information was merged with patient interview data to create a comprehensive dataset.

Cramer's V Calculation:

A Cramer's V statistic was calculated to assess the strength of the association between ART usage and social stigma. Using the VCD library in R, we calculated a Cramer's V value of 0.57, indicating a strong association between these two variables.
Regression Analysis:

A custom regression analysis was performed in R to investigate the relationship between socioeconomic factors and ART usage. The analysis showed that socioeconomic factors explained 73.5% of the variance in ART usage, highlighting the importance of these factors in understanding ART adoption.

Key Libraries and Tools Used

Excel for data integration and analysis:

VLOOKUP for merging datasets.

Pivot Tables for summarizing and organizing data.

R Programming for statistical analysis:

VCD library for calculating Cramer's V.
lm() function for regression analysis.

Dataset
The dataset used for analysis contains information on patients, ART usage, social stigma, and socioeconomic factors. It was gathered from interviews with doctors across various specialties, including oncologists, cardiologists, neurologists, general practitioners, and pediatricians.

The dataset includes the following columns:

Doctor_ID: ID of the doctor conducting the interview.(Name Masked)

Patient_ID: Unique ID of the patient.

Interview_Data: Data collected from the interview.

Doctor_Name: Name of the doctor.

Specialty: Specialty of the doctor.

ART_Usage: Whether the patient is using Artificial Reproductive Technology (Yes/No).

Social_Stigma: Level of social stigma (High/Low).

Socioeconomic_Factor1, Factor2, Factor3: Various socioeconomic factors affecting ART usage.

Files Included:
health_data_dataset.xlsx: Excel file containing the complete dataset of 500 data points.
R_Code.R: R script containing the code for regression analysis and Cramer's V calculation.
Running the Analysis

Data Preparation:

The dataset is loaded into R from the Excel file using the readxl library.

Cramer's V Calculation:

A contingency table is created between ART usage and social stigma, followed by the calculation of Cramer's V using the assocstats() function from the VCD library.
Regression Analysis:

Socioeconomic factors are modeled using a logistic regression model (lm() function) to explain ART usage variance. The results are displayed with the R-squared value showing the proportion of variance explained.
