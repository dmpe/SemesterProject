library(readr)
library(stringr)
library(plyr)
library(dplyr)
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
colnames(data.NYS) <- c("ID", "F.Name", "L.Name", "Comp.Name", "Street_1", "Street_2", "City", "State", "Zip", "Zip_2", "Country", "County",  "Phone", "Email", "Year_Adm", "JDoA", "Law_School", "Status", "Next_Reg")

data.NYS <- tbl_df(data.NYS)
# names(data.NYS)
# problems(data.NYS)
# summary(data.NYS)


asdf <- str_split_fixed(data.NYS$Email, "@", 2) 

tbl()
filter(data.NYS, data.NYS$Email == str_detect(data.NYS$Email, "bloomberg"))


