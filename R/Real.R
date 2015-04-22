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
problems(data.NYS)
summary(data.NYS)

# cols <- c("premium","change","newprice")
# colnames(data.NYS) <- cols

data.NYS2 <- plyr::rename(data.NYS, replace = c("Registration Number" = "ID", "First Name" = "F.Name", "Last Name" = "L.Name", "Company Name" = "Comp.Name", "Street 1" = "Street_1", "Street 2" = "Street_2", "Zip Plus Four" = "Zip_2", "Phone Number" = "Phone", "Email Address" = "Email", "Year Admitted" = "Year_Adm", "Judicial Department of Admission" = "JDoA", "Law School" = "Law_School", "Next Registration" = "Next_Reg"))


data.NYS <- dplyr::rename(data.NYS, "Registration Number" = "ID")



