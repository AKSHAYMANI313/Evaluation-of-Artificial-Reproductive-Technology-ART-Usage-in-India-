

# Load necessary libraries
library(readxl)  # For reading Excel files
library(dplyr)   # For data manipulation
library(vcd)     # For calculating Cramér's V
library(ggplot2) # For visualization
library(corrplot) # For correlation matrix
library(car)      # For regression diagnostics

# Set working directory (modify as needed)
# setwd("your_directory_path")

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

# Print Cramér's V value
print(paste("Cramér's V value:", round(cramer_value, 2)))

# Multiple Regression: Socioeconomic Factors → ART Usage
# Convert ART Usage to numeric (if applicable)
data$ART_Usage_Numeric <- as.numeric(data$ART_Usage) - 1

# Select socioeconomic predictor variables
socioeconomic_factors <- data %>% select(income, education, employment_status)

# Fit regression model
model <- lm(ART_Usage_Numeric ~ ., data = socioeconomic_factors)

# Summary of regression model
summary(model)

# Calculate variance explained (R-squared)
r_squared <- summary(model)$r.squared
print(paste("Variance Explained (R²):", round(r_squared * 100, 2), "%"))

# Correlation plot for socioeconomic variables
corr_matrix <- cor(socioeconomic_factors, use = "complete.obs")
corrplot(corr_matrix, method = "circle")

# Visualization: ART Usage vs. Income
ggplot(data, aes(x = income, y = ART_Usage_Numeric)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", color = "blue") +
  theme_minimal() +
  labs(title = "ART Usage vs. Income", x = "Income Level", y = "ART Usage")

