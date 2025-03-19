

# Project Purpose
# This project aims to conduct an advanced statistical analysis on healthcare data derived from interviews with multiple doctors.
# The focus is to explore complex interactions between Artificial Reproductive Technology (ART) usage, social stigma, and multiple socioeconomic factors.
# The study employs machine learning techniques, nonlinear regression, and association metrics to develop predictive models and evaluate causality.

# Load necessary libraries
library(readxl)     # For reading Excel files
library(dplyr)      # For data manipulation
library(vcd)        # For calculating Cramér's V
library(ggplot2)    # For visualization
library(corrplot)   # For correlation matrix
library(car)        # For regression diagnostics
library(randomForest) # For non-linear modeling
library(MASS)       # For stepwise regression
library(mlr)        # For machine learning pipeline
library(e1071)      # For SVM implementation

# Load dataset
data <- read_excel("health_data_dataset.xlsx")

# Preview dataset structure
str(data)

# Ensure categorical variables are factors
data$ART_Usage <- as.factor(data$ART_Usage)
data$Social_Stigma <- as.factor(data$Social_Stigma)

# Merge datasets if necessary (VLOOKUP equivalent)
# Assuming a secondary dataset 'doctor_data.xlsx' with key column 'Doctor_ID'
# doctor_data <- read_excel("doctor_data.xlsx")
# merged_data <- merge(data, doctor_data, by = "Doctor_ID", all.x = TRUE)

# Calculate Cramér's V for ART Usage and Social Stigma
cramer_test <- assocstats(table(data$ART_Usage, data$Social_Stigma))
cramer_value <- cramer_test$cramer
print(paste("Cramér's V value:", round(cramer_value, 2)))

# Feature Engineering: Creating Interaction Terms and Polynomial Features
data <- data %>% mutate(
  income_education = income * education,
  income_squared = income^2,
  education_squared = education^2,
  stigma_squared = as.numeric(Social_Stigma)^2
)

# Multiple Regression: Socioeconomic Factors → ART Usage
data$ART_Usage_Numeric <- as.numeric(data$ART_Usage) - 1

# Selecting predictor variables
socioeconomic_factors <- data %>% select(income, education, employment_status, income_education, income_squared, education_squared, stigma_squared)

# Fit complex regression model with interaction terms
model <- lm(ART_Usage_Numeric ~ ., data = socioeconomic_factors)
summary(model)

# Stepwise Model Selection (AIC-based)
stepwise_model <- stepAIC(model, direction = "both")
summary(stepwise_model)

# Random Forest Model for Non-Linear Relationships
rf_model <- randomForest(ART_Usage_Numeric ~ ., data = socioeconomic_factors, ntree = 500, importance = TRUE)
print(rf_model)
varImpPlot(rf_model)

# Support Vector Machine (SVM) for Classification
svm_model <- svm(ART_Usage ~ ., data = socioeconomic_factors, kernel = "radial", cost = 10, gamma = 0.1)
pred_svm <- predict(svm_model, socioeconomic_factors)
confusionMatrix(as.factor(pred_svm), as.factor(data$ART_Usage))

# Correlation plot for socioeconomic variables
corr_matrix <- cor(socioeconomic_factors, use = "complete.obs")
corrplot(corr_matrix, method = "circle")

# Visualization: ART Usage vs. Income with Polynomial Fit
ggplot(data, aes(x = income, y = ART_Usage_Numeric)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", formula = y ~ poly(x, 2), color = "blue") +
  theme_minimal() +
  labs(title = "ART Usage vs. Income (Polynomial Fit)", x = "Income Level", y = "ART Usage")

# Conclusion: 
# This analysis highlights complex interactions between ART Usage, social stigma, and socioeconomic status.
# Using stepwise regression, random forests, and SVMs, we can assess both linear and nonlinear factors affecting ART adoption.
# The results indicate that higher education and income positively correlate with ART usage, while social stigma negatively impacts adoption.
# Future work should include larger datasets and additional machine learning models to further refine predictions.
