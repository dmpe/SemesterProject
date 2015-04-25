library(readr)
library(stringr)
library(stringi)
library(plyr)
library(ggplot2)
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
# summary(data.NY)


splitted.email <- stri_split_fixed(data.NYS$Email, "@", 2, omit_empty = NA, simplify = TRUE) 
splitted.email <- data.frame(na.omit(splitted.email))
colnames(splitted.email) <- c("NickName", "Organisation")

splitted.email.2 <- data.frame(table(tolower(splitted.email$Organisation)))
splitted.email.2 <- plyr::arrange(splitted.email.2, desc(splitted.email.2$Freq))

law_school <- data.frame(table(tolower(data.NYS$Law_School)))
law_school <- plyr::arrange(law_school, desc(law_school$Freq))

count(law_school[grep("harvard", law_school$Var1, ignore.case=T),])

newyork <- law_school[grep("new york", law_school$Var1, ignore.case=T),]
count(newyork)

brooklyn <- law_school[grep("brooklyn", law_school$Var1, ignore.case=T),]
count(brooklyn)

johns <- law_school[grep("johns|john's", law_school$Var1, ignore.case=T),]
count(johns)

data.NYS$Comp.Name <- str_replace_all(tolower(data.NYS$Comp.Name), "[&,]", "")
com_name <- data.frame(table(data.NYS$Comp.Name))
com_name <- plyr::arrange(com_name, desc(com_name$Freq))

com_name.plot <- ggplot(data=com_name[1:20,], aes(x=reorder(Var1, Freq), y=Freq)) 
com_name.plot <- com_name.plot + geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size = 14))
com_name.plot <- com_name.plot+ coord_flip()
com_name.plot


tbl()
filter(data.NYS, data.NYS$Email == str_detect(data.NYS$Email, "bloomberg"))


