library(tidyverse)
library(readxl)
library(devtools)
library(reshape)
library(zoo)
library(xlsx)

rm(list = ls())


main <- read_excel("DataRefinitiv/Port_Template.xlsx",sheet=1) %>%  select(!"Updated at 19:51:18")
rownames(main) <- NULL
head(main)

main_split <- split(main, factor(sort(rank(row.names(main))%%11)))

# can improve by performing loop 
write.csv(main_split$`0`, "76Funds_1.xlsx", row.names=F)
write.csv(main_split$`1`, "76Funds_2.xlsx", row.names=F)
write.csv(main_split$`2`, "76Funds_3.xlsx", row.names=F)
write.csv(main_split$`3`, "76Funds_4.xlsx", row.names=F)
write.csv(main_split$`4`, "76Funds_5.xlsx", row.names=F)
write.csv(main_split$`5`, "76Funds_6.xlsx", row.names=F)
write.csv(main_split$`6`, "76Funds_7.csv", row.names=F)
write.csv(main_split$`7`, "76Funds_8.xlsx", row.names=F)
write.csv(main_split$`8`, "76Funds_9.xlsx", row.names=F)
write.csv(main_split$`9`, "76Funds_10.xlsx", row.names=F)
write.csv(main_split$`10`, "76Funds_11.xlsx", row.names=F)

