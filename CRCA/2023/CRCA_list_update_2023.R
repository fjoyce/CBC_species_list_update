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
CRCA_list<- read_csv("CRCA/2023/CRCA_FieldForm.csv") %>% 
  select(Species)


# correct species names in Audubon's database

CRCA_list_corrected <- CRCA_list %>%
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
      Species == "Vermiculated Screech-Owl" ~ "Middle American Screech-Owl",
      Species == "Crowned Woodnymph (Violet-crowned Woodnymph)" ~ "Crowned Woodnymph",
      Species == "Steely-vented Hummingbird" ~ "Blue-tailed Hummingbird",
      Species ==  "Black-throated Trogon" ~ "Northern Black-throated Trogon",
      Species == "Orange-bellied Trogon" ~ "Collared Trogon",
      Species == "Blue-crowned Motmot (Lesson's)" ~ "Lesson’s Motmot",
      Species == "White-fronted Nunbird (Costa Rican)" ~ "White-fronted Nunbird",
      Species == "Emerald Toucanet" ~ "Northern Emerald-Toucanet",
      Species == "Yellow-throated Toucan (Black-mandibled)" ~ "Yellow-throated Toucan",
      Species == "Checker-throated Antwren" ~ "Checker-throated Stipplethroat",
      Species == "Northern Slaty-Antshrike" ~ "Black-crowned Antshrike",
      Species == "Olive-striped Flycatcher" ~ "Olive-streaked Flycatcher",
      Species == "Paltry Tyrannulet" ~ "Mistletoe Tyrannulet",
      Species == "Yellow-olive Flycatcher" ~ "Yellow-olive Flatbill",
      Species == "Yellow-margined Flycatcher" ~ "Yellow-winged Flatbill",
      Species == "Royal Flycatcher" ~ "Tropical Royal Flycatcher",
      Species == "Tropical Pewee" ~ "Northern Tropical Pewee",
      Species == "Brown-winged Schiffornis" ~ "Northern Schiffornis",
      Species == "House Wren (Southern)" ~ "House Wren",
      Species == "Plain Wren" ~ "Cabanis’s Wren",
      Species == "Tropical Gnatcatcher" ~ "White-browed Gnatcatcher",
      Species == "Yellow-rumped Warbler (Myrtle)" ~ "Yellow-rumped Warbler",
      Species == "Rufous-capped Warbler" ~ "Chestnut-capped Warbler",
      Species == "Three-striped Warbler" ~ "Costa Rican Warbler",
      Species == "Passerini's Tanager" ~ "Scarlet-rumped Tanager",
      Species == "White-collared Seedeater" ~ "Morelet's Seedeater",
      Species == "Grayish Saltator" ~ "Cinnamon-bellied Saltator",
      #Species to remove (don't change)
      #Species == "Guianan Trogon" ~ ,
      #Species == "Amazonian Motmot" ~ ,
      #Species == "Guianan Puffbird" ~ ,
      #White-cheeked Antbird 
      #Streaked Flycatcher (Streaked)
      #Wing-barred Seedeater (already have Variable Seedeater)
      
      # Vermiculated Screech-Owl (Vermiculated)
      
      #Don't fix here, fix in AOCR data frame
      #Species == "Double-striped Thick-knee"
      #Species == "White-browed Gnatcatcher"
      
      TRUE ~ Species
    )
  )


#duplicate common name name column and name "Ingles"
CRCA_list_corrected$Ingles <- CRCA_list_corrected$Species

#join two data frames by English common name (Ingles)
Full_CRCA_list <- full_join(aocr_list_corrected, CRCA_list_corrected, by = "Ingles", copy= false, suffix = c(".aocr", ".CRCA"))

#Remove species counts from Family column
Full_CRCA_list$Familia <- gsub(" .*","",Full_CRCA_list$Familia)

Full_CRCA_list <- Full_CRCA_list %>% 
  filter(Ingles != c("Vermiculated Screech-Owl (Vermiculated)", 
                     "Blue-crowned Motmot", 
                     "Amazonian Motmot", 
                     "Yellow-throated Toucan (Chestnut-mandibled)", 
                     "White-cheeked Antbird",
                     "Royal Flycatcher (Northern)", 
                     "Streaked Flycatcher (Streaked)", 
                     "Wing-barred Seedeater")) %>% 
  select(!Estatus)


write_excel_csv(Full_CRCA_list, file = "CRCA/2023/CRCA_2023_updated_pre_cleaned.csv")
