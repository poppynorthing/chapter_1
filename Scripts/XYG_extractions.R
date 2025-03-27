# Working out monica's old extractions
# Poppy C. Northing
# Last edited: 18MAR2025

library(tidyverse)

concs <- read.csv("Data/XYG_extraction_concentrations.csv", header = T)

# See how many individuals from each pop can be sequenced with standard & low input library preps

concs <- concs %>% filter(Library.Type == "Standard" | Library.Type == "low_input")

conc_summary <- concs %>% group_by(Library.Type, Population) %>% summarise(number_individuals = n())

conc_summary2 <- concs %>% group_by(Population) %>% summarize(number_individuals = n())

write.csv(conc_summary, file = "prep_summary.csv", row.names = F)
write.csv(conc_summary2, file = "pop_summary.csv", row.names = F)

# Visualize Concentrations of low-input samples

p <- concs %>% filter(Library.Type == "low_input") %>% ggplot(aes(x = Approx..Total.DNA..ng.)) + geom_histogram() + theme_classic(); p
