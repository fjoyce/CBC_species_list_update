library(tidyverse)
getwd()

#import AOCR Lista Oficial de Aves de Costa Rica 
aocr_list <- read_csv("AOCR_2019.csv", na = character()) 

read_csv
#import species previously recorded in CBCs
CRCA_list<- read_csv("CBC_names.csv")

#duplicate common name name column and name "Ingles"
CRCA_list$Ingles <- CRCA_list$Species

#join two data frames by English common name (Ingles)
Full_CRCA_list <- full_join(aocr_list, CRCA_list, by= "Ingles", copy= false,suffix = c(".aocr", ".CRCA"))

#Remove species counts from Family column
Full_CRCA_list$Familia <- gsub(" .*","",Full_CRCA_list$Familia)
  
write_csv(Full_CRCA_list, path = "CRCA_2019_master_check.csv")

