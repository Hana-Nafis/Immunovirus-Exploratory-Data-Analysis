# Libraries
# include your libraries here
# use echo = FALSE if you do not want the Code button to appear
library(tidyverse)
library(dplyr)
library(ggplot2)
library(tidyr)
library(readr)
library(kableExtra)
library(patchwork)

theme_set(theme_minimal())

# Read in the data
library(readr)
immunovirus <- read_csv("immunovirus.csv")

# Summary Statistics
summary_table <- immunovirus %>%
  summary()
kable(summary_table, caption = "Summary Statistics for Immunovirus Dataset") %>%
  kable_styling(full_width = TRUE)

# Convert variables to informative categories
immuno <- immunovirus %>%
  mutate(
    Infected = factor(Infected, levels = c(0,1), labels = c("No", "Yes")),
    Treatment = factor(Treatment, levels = c(0,1,2,3), labels = c("A", "A + B", "A + C", "B")),
    Race = factor(Race, levels = c(0,1), labels=c("White", "Non-White")),
    Gender = factor(Gender, levels = c(0,1), labels=c("Female", "Male")),
    Haemophilia = factor(Haemophilia, levels = c(0,1), labels = c("No", "Yes")),
    Homosexual = factor(Homosexual, levels = c(0,1), labels = c("No", "Yes")),
    Drugs = factor(Drugs, levels = c(0,1), labels = c("No", "Yes"))
  )

# Count Missing Values
sum(is.na(immuno))
miss_tbl <- immuno %>% summarise_all(~sum(is.na(.))) %>%
  pivot_longer(everything(), names_to = "variable", values_to = "missing")
miss_tbl %>% kable() %>% kable_styling()

# Overall Counts
n_total <- nrow(immuno)
n_infected <- immuno %>% filter(Infected == "Yes") %>% nrow()
infected_pct <- scales::percent(n_infected / n_total)
cat("Total rows:", n_total, "\\nInfected:", n_infected, "(", infected_pct, ")\\n")

# Counts by categorical variables
p1 <- immuno %>% count(Infected) %>%
  ggplot(aes(x=Infected, y=n)) +
  geom_col(fill="steelblue") +
  geom_text(aes(label = n), vjust = -0.5, size = 4) +
  labs(title = "Counts by Infection Status", x="Infected", y = "Count")
p2 <- immuno %>% count(Treatment) %>%
  ggplot(aes(x=Treatment, y=n))+
  geom_col(fill="steelblue") +
  geom_text(aes(label = n), vjust = -0.5, size = 4) +
  labs(title = "Counts by Treatment",x = "Treatment",y="Count")
p3 <- immuno %>% count(Race) %>%
  ggplot(aes(x=Race, y=n)) +
  geom_col(fill="steelblue") +
  geom_text(aes(label = n), vjust = -0.5, size = 4) +
  labs(title = "Counts by Race", x="Race", y="Count")
p4 <- immuno %>% count(Gender) %>%
  ggplot(aes(x=Gender, y=n))+
  geom_col(fill="steelblue") +
  geom_text(aes(label = n), vjust = -0.5, size = 4) +
  labs(title = "Counts by Gender", x="Gender", y="Count")
p5 <- immuno %>% count(Drugs) %>%
  ggplot(aes(x = Drugs, y=n)) +
  geom_col(fill="steelblue") +
  geom_text(aes(label = n), vjust = -0.5, size = 4) +
  labs(title = "Counts by Drug Use", x = "Drug Use", y = "Count")
p6 <- immuno %>% count(Haemophilia) %>%
  ggplot(aes(x = Haemophilia, y = n)) +
  geom_col(fill="steelblue") +
  geom_text(aes(label = n), vjust = -0.5, size = 4) +
  labs(title = "Counts by Haemophilia", x = "Haemophilia", y = "Count")
p7 <- immuno %>% count(Homosexual) %>%
  ggplot(aes(x = Homosexual, y=n)) +
  geom_col(fill="steelblue") +
  geom_text(aes(label = n), vjust = -0.5, size = 4) +
  labs(title = "Counts by Homosexual Activity", x = "Homosexual Activity", y = "Count")

# Arrange plots
p1+p2+p3+p4+p5+p6+p7

# Numeric variables
nums <- immuno %>%
  select(Age, Biomarker, Biomarker6months, Time)
summary(nums)

# Numeric variable distributions
p_age <- immuno %>%
  ggplot(aes(x=Age))+
  geom_histogram(bins=30, fill="indianred", color="white")+
  labs(title="Age Distribution")
p_bio <- immuno %>%
  ggplot(aes(x=Biomarker))+
  geom_histogram(bins=30,fill="indianred", color="white")+
  labs(title="Biomarker Distribution (baseline)")
p_bio6 <- immuno %>%
  ggplot(aes(x=Biomarker6months))+
  geom_histogram(bins=30,fill="indianred", color="white")+
  labs(title="Biomarker at 6 months")
p_time <- immuno %>%
  ggplot(aes(x=Time))+
  geom_histogram(bins=30,fill="indianred", color="white")+
  labs(title="Time to liver disease(days)")

(p_age+p_bio)/(p_bio6+p_time)

# Infection rates by categorical variables
by_treat <- immuno %>%
  group_by(Treatment)%>%
  summarize(n = n(), infected_rate = mean(as.numeric(Infected == "Yes")))
by_race <- immuno %>%
  group_by(Race)%>%
  summarize(n = n(), infected_rate = mean(as.numeric(Infected == "Yes")))
by_gender <- immuno %>%
  group_by(Gender) %>%
  summarize(n = n(), infected_rate = mean(as.numeric(Infected == "Yes")))
by_haemo <- immuno %>%
  group_by(Haemophilia) %>%
  summarize(n = n(), infected_rate = mean(as.numeric(Infected == "Yes")))
by_homo <- immuno %>%
  group_by(Homosexual) %>%
  summarize(n = n(), infected_rate = mean(as.numeric(Infected == "Yes")))
by_drugs <- immuno %>%
  group_by(Drugs) %>%
  summarize(n = n(), infected_rate = mean(as.numeric(Infected == "Yes")))

by_treat %>% kable() %>% kable_styling()
by_race %>% kable() %>% kable_styling()
by_gender %>% kable() %>% kable_styling()
by_haemo %>% kable() %>% kable_styling()
by_homo %>% kable() %>% kable_styling()
by_drugs %>% kable() %>% kable_styling()

# Continuous variables vs infection status
p_age_box <- immuno %>%
  ggplot(aes(x = Infected, y = Age)) +
  geom_boxplot(fill="seagreen") +
  labs(title = "Age by infection status")
p_bio_box <- immuno %>%
  ggplot(aes(x = Infected, y = Biomarker)) +
  geom_boxplot(fill="seagreen") +
  labs(title = "Biomarker (baseline) by infection status")
p_bio6_box <- immuno %>%
  ggplot(aes(x = Infected, y = Biomarker6months)) +
  geom_boxplot(fill="seagreen") +
  labs(title = "Biomarker (6 months) by infection status")
p_time_box <- immuno %>%
  ggplot(aes(x = Infected, y = Time)) +
  geom_boxplot(fill="seagreen") +
  labs(title = "Time to liver disease by infection status")

(p_age_box | p_bio_box) / (p_bio6_box | p_time_box) &
  theme(panel.spacing = unit(2, "cm"))

# Time to liver disease summary statistics
time_summary <- immuno %>%
  summarize(
    n = n(),
    mean_time = mean(Time, na.rm = TRUE),
    median_time = median(Time, na.rm = TRUE),
    min_time = min(Time, na.rm = TRUE),
    max_time = max(Time, na.rm = TRUE),
    sd_time = sd(Time, na.rm = TRUE)
  )

time_summary %>%
  kable(caption = "Summary Statistics for Time to Liver Disease") %>%
  kable_styling(full_width = FALSE)

# Time to liver disease by categorical variables
p_treatment <- immuno %>%
  ggplot(aes(x = Treatment, y = Time)) +
  geom_boxplot(fill="rosybrown") +
  labs(title = "Time to Liver Disease by Treatment")

p_infected <- immuno %>%
  ggplot(aes(x = Infected, y = Time)) +
  geom_boxplot(fill="rosybrown") +
  labs(title = "Time to Liver Disease by Infection Status")

p_drugs <- immuno %>%
  ggplot(aes(x = Drugs, y = Time)) +
  geom_boxplot(fill="rosybrown") +
  labs(title = "Time to Liver Disease by Drug Usage")

p_treatment + p_infected + p_drugs

# Biomarker relationships
immuno %>%
  ggplot(aes(x = Biomarker, y = Biomarker6months, color = Infected)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Baseline vs 6-month biomarker", x="Baseline Biomarker", y="Biomarker at 6 months")

# Correlation matrix and heatmap
corr_mat <- immuno %>%
  select(Age, Biomarker, Biomarker6months, Time) %>%
  cor(use = "pairwise.complete.obs") %>%
  round(2)
corr_mat %>%
  kable(caption = "Correlation Matrix") %>%
  kable_styling(full_width = FALSE)

corr_long <- corr_mat %>%
  as.data.frame() %>%
  mutate(RowVariables = rownames(.)) %>%
  pivot_longer(-RowVariables, names_to = "ColumnVariables", values_to = "value")

ggplot(corr_long, aes(RowVariables, ColumnVariables, fill = value)) +
  geom_tile() +
  geom_text(aes(label = value)) +
  scale_fill_gradient2(low="blue", high="red", mid="white", midpoint=0) +
  theme_minimal() +
  labs(title="Correlation Heatmap")
