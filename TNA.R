library(tidyverse)
library(readxl)
library(devtools)
library(reshape)
library(zoo)


rm(list = ls())


main_list_tna <- read_excel("DataRefinitiv/TNA_Full.xlsx",sheet=1, skip=1, na="NULL") %>%  select(!c("Lipper RIC","Asset Name","Currency"))
head(main_list_tna)
dim(main_list_tna) #222 period

# TOTAL FUND TNA

plot_data <- main_list_tna %>% 
  pivot_longer(!Fund, names_to = "Date", values_to = "FundTNA") %>%  mutate(Date=as.yearmon(as.Date(as.numeric(Date), origin = "1899-12-30"))) %>% 
  mutate(FundTNA = as.numeric(FundTNA)) %>% group_by(Fund, Date) %>%  summarize_at("FundTNA", sum, na.rm=T) %>% 
  group_by(Date) %>%  summarize_at("FundTNA", sum, na.rm=T) 

figure_1 <- plot_data %>% 
  ggplot(aes(x=Date,y=FundTNA)) +
  geom_line()

figure_1

# Exclude many NA

plot_data <- main_list_tna %>% 
  mutate(count_na = rowSums(is.na(main_list_tna)))
plot_data$count_na

# Exclude zero

filter_fund <- main_list_tna %>% pivot_longer(!Fund, names_to = "Date", values_to = "FundTNA") %>%  mutate(Date=as.yearmon(as.Date(as.numeric(Date), origin = "1899-12-30"))) %>% 
  mutate(FundTNA = as.numeric(FundTNA)) %>% group_by(Fund, Date) %>%  summarize_at("FundTNA", sum, na.rm=T) %>% 
  filter(!FundTNA == 0) %>%  group_by(Fund) %>%  summarize_at("FundTNA", min) %>%  filter(FundTNA>=1000000000) %>% select (Fund)


filter_fund

plot_data <- main_list_tna %>% 
  pivot_longer(!Fund, names_to = "Date", values_to = "FundTNA") %>%  mutate(Date=as.yearmon(as.Date(as.numeric(Date), origin = "1899-12-30"))) %>% 
  mutate(FundTNA = as.numeric(FundTNA)) %>% group_by(Fund, Date) %>%  summarize_at("FundTNA", sum, na.rm=T) %>% 
  filter(Fund %in% filter_fund$Fund) 

plot_missing_data <- main_list_tna %>% filter(Fund %in% filter_fund$Fund) %>% 
  mutate(count_na = rowSums(is.na(plot_missing_data))) %>%  select(Fund,count_na) %>%  arrange(desc(count_na))

plot_missing_data

plot_data <- plot_data %>% 
  
plot_data$count_na
  

