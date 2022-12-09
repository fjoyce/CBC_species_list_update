library(tidyverse)
library(here)
getwd()

#import AOCR Lista Oficial de Aves de Costa Rica 
#need encoding =latin1 probably because of original Excel locale
aocr_list <- read_csv("AOCR_list/AOCR_2022.csv"
                      #, locale=locale(encoding="latin1")
                      , na = character()) 


#import species previously recorded in CBCs
CRCA_list<- read_csv("CRCA/2022/CBC_names.csv")

#duplicate common name name column and name "Ingles"
CRCA_list$Ingles <- CRCA_list$Species

#join two data frames by English common name (Ingles)
Full_CRCA_list <- full_join(aocr_list, CRCA_list, by= "Ingles", copy= false,suffix = c(".aocr", ".CRCA"))

#Remove species counts from Family column
Full_CRCA_list$Familia <- gsub(" .*","",Full_CRCA_list$Familia)
  
write_csv(Full_CRCA_list, file = "CRCA/2022/CRCA_2022_master_check.csv")

