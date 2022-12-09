library(tidyverse)
getwd()

#import AOCR Lista Oficial de Aves de Costa Rica 
aocr_list <- read_csv("AOCR_2019.csv", na = character()) 

#import species previously recorded in CBCs
CRSR_list<- read_csv("CRSR_list.csv")

#duplicate common name name column and name "Ingles"
CRSR_list$Ingles <- CRSR_list$Species

#join two data frames by English common name (Ingles)
Full_CRSR_list <- full_join(aocr_list, CRSR_list, by= "Ingles", copy= false,suffix = c(".aocr", ".CRCA"))

#Remove species counts from Family column
Full_CRSR_list$Familia <- gsub(" .*","",Full_CRSR_list$Familia)

write_csv(Full_CRSR_list, path = "CRSR_2019_master_check.csv")
