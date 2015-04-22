library(readr)
library(stringr)
library(plyr)
#####################
#' https://en.wikipedia.org/wiki/New_York_Supreme_Court,_Appellate_Division
#' 
#' 
#' 
#' 
#####################

data.NYS <- readr::read_csv("/srv/shiny-server/SemesterProject/Data/NYS_Attorney_Registrations.csv",
                            col_types = list("Zip" = col_character(), "Zip Plus Four" = col_character(), "Suffix" = col_skip(), "Middle Name" = col_skip()))


data.NYS[data.NYS == ""] <- NA

# names(data.NYS)
# problems(data.NYS)
# summary(data.NYS)

colnames(data.NYS) <- c("ID", "F.Name", "L.Name", "Comp.Name", "Street_1", "Street_2", "City", "State", "Zip", "Zip_2", "Country", "County",  "Phone", "Email", "Year_Adm", "JDoA", "Law_School", "Status", "Next_Reg")

data.NYS <- dplyr::rename(data.NYS, "Registration Number" = "ID")



