2019-12-16
Francis Joyce

Instructions for updating the speies ACG CBC species lists

(1) Download "Blank Field Form" from http://netapp.audubon.org/CBC/Compiler/ and delete content not related to species list

Save as "CBC_names.csv"

(2) Download AOCR lista de especies from https://listaoficialavesdecostarica.wordpress.com/lista-oficial/

(3) Adapt R script with appropriate file names, directories, etc.

(4) Run R script

(5) Open CRCA_YEAR_master.csv

(6) Filter by non-species rows (e.g. Ingles = Blank) and delete Species values that are NA (Clear Contents)

(7) Delete rows with Species = NA (i.e. species that have never been observed in the CRCA count)

(8) Delete Orders/families with no species represented

(9) Save as new csv file (so it doesn't get overwritten if you re-run the R script)




