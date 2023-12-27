library(tidyverse)
library(here)
here()
getwd()


#import AOCR Lista Oficial de Aves de Costa Rica 
aocr_list <- read_csv("AOCR_list/AOCR_2023.csv", na = character())


aocr_list_corrected <- aocr_list %>% 
  mutate(Ingles = case_when(
    Ingles == "White-browed Gnatcather" ~ "White-browed Gnatcatcher",
    Ingles == "Double-striped Thick-Knee" ~ "Double-striped Thick-knee",
    TRUE ~ Ingles
  ))


#import species previously recorded in CBCs
CRSR_list<- read_csv("CRSR/2023/CRSR_FieldForm.csv")


# correct species names in Audubon's database

# Great Blue Heron (Blue form)
# Cattle Egret
# Black-crowned Night-Heron
# Yellow-crowned Night-Heron
# Gray-necked Wood-Rail
# Double-striped Thick-knee
# Common Ground-Dove
# Plain-breasted Ground-Dove
# Ruddy Ground-Dove
# Blue Ground-Dove
# Steely-vented Hummingbird
# Guianan Trogon
# Blue-crowned Motmot (Lesson's)
# Amazonian Motmot
# Guianan Puffbird
# Northern Slaty-Antshrike
# Paltry Tyrannulet
# Yellow-olive Flycatcher
# Royal Flycatcher
# Tropical Pewee
# House Wren (Southern)
# Plain Wren
# Tropical Gnatcatcher
# Yellow-rumped Warbler (Myrtle)
# Rufous-capped Warbler
# White-collared Seedeater

CRSR_list_corrected <- CRSR_list %>%
  mutate(
    Species = case_when(
      Species == "Great Blue Heron (Blue form)" ~ "Great Blue Heron",
      Species == "Cattle Egret" ~ "Western Cattle Egret",
      Species == "Black-crowned Night-Heron" ~ "Black-crowned Night Heron",
      Species == "Yellow-crowned Night-Heron" ~ "Yellow-crowned Night Heron",
      Species == "Gray-necked Wood-Rail" ~ "Russet-naped Wood-Rail",
      Species == "Common Ground-Dove" ~ "Common Ground Dove",
      Species == "Plain-breasted Ground-Dove" ~ "Plain-breasted Ground Dove",
      Species == "Ruddy Ground-Dove" ~ "Ruddy Ground Dove",
      Species == "Blue Ground-Dove" ~ "Blue Ground Dove",
      Species == "Steely-vented Hummingbird" ~ "Blue-tailed Hummingbird",
      Species == "Blue-crowned Motmot (Lesson's)" ~ "Lesson’s Motmot",
      Species == "Northern Slaty-Antshrike" ~ "Black-crowned Antshrike",
      Species == "Paltry Tyrannulet" ~ "Mistletoe Tyrannulet",
      Species == "Yellow-olive Flycatcher" ~ "Yellow-olive Flatbill",
      Species == "Royal Flycatcher" ~ "Tropical Royal Flycatcher",
      Species == "Tropical Pewee" ~ "Northern Tropical Pewee",
      Species == "House Wren (Southern)" ~ "House Wren",
      Species == "Plain Wren" ~ "Cabanis’s Wren",
      Species == "Tropical Gnatcatcher" ~ "White-browed Gnatcatcher",
      Species == "Yellow-rumped Warbler (Myrtle)" ~ "Yellow-rumped Warbler",
      Species == "Rufous-capped Warbler" ~ "Chestnut-capped Warbler",
      Species == "White-collared Seedeater" ~ "Morelet's Seedeater",
      #Species to remove (don't change)
      #Species == "Guianan Trogon" ~ ,
      #Species == "Amazonian Motmot" ~ ,
      #Species == "Guianan Puffbird" ~ ,
      #
      #Don't fix here, fix in AOCR data frame
      #Species == "Double-striped Thick-knee"
      #Species == "White-browed Gnatcatcher"
      
      TRUE ~ Species
    )
  )


#duplicate common name name column and name "Ingles"
CRSR_list_corrected$Ingles <- CRSR_list_corrected$Species

#join two data frames by English common name (Ingles)
Full_CRSR_list <- full_join(aocr_list_corrected, CRSR_list_corrected, by = "Ingles", copy= false,suffix = c(".aocr", ".CRCA"))

#Remove species counts from Family column
Full_CRSR_list$Familia <- gsub(" .*","",Full_CRSR_list$Familia)

Full_CRSR_list <- Full_CRSR_list %>% 
  filter(Ingles != c("Guianan Trogon", "Amazonian Motmot", "Guianan Puffbird")) %>% 
  select(!Estatus) %>% 
  select(!c(US, HC, LC))


write_excel_csv(Full_CRSR_list, file = "CRSR/2023/CRSR_2023_updated_pre_cleaned.csv")
