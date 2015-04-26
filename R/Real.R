library(readr)
library(stringr)
library(stringi)
library(plyr)
library(ggplot2)
library(dplyr)
#####################
#' https://en.wikipedia.org/wiki/New_York_Supreme_Court,_Appellate_Division
#' 
#####################

data.NYS <- readr::read_csv("/srv/shiny-server/SemesterProject/Data/NYS_Attorney_Registrations.csv",
                            col_types = list("Zip" = col_character(), "Zip Plus Four" = col_character(), "Suffix" = col_skip(), "Middle Name" = col_skip()))


data.NYS[data.NYS == ""] <- NA
colnames(data.NYS) <- c("ID", "F.Name", "L.Name", "Comp.Name", "Street_1", "Street_2", "City", "State", "Zip", "Zip_2", "Country", "County",  "Phone", "Email", "Year_Adm", "JDoA", "Law_School", "Status", "Next_Reg")

data.NYS <- colwise(function(x){str_trim(x)})(data.NYS)
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

# count(law_school[grep("harvard", law_school$Var1, ignore.case=T),])
# 
# newyork <- law_school[grep("new york", law_school$Var1, ignore.case=T),]
# count(newyork)
# 
# brooklyn <- law_school[grep("brooklyn", law_school$Var1, ignore.case=T),]
# count(brooklyn)
# 
# johns <- law_school[grep("johns|john's", law_school$Var1, ignore.case=T),]
# count(johns)

data.NYS$Comp.Name <- str_replace_all(tolower(data.NYS$Comp.Name), "[&,]", "")
data.NYS$Comp.Name <- str_replace_all(tolower(data.NYS$Comp.Name), "llp", "")
data.NYS$Comp.Name <- str_replace_all(tolower(data.NYS$Comp.Name), "llc", "")
data.NYS$Comp.Name <- str_replace_all(tolower(data.NYS$Comp.Name), "l.l.c.", "")
data.NYS$Comp.Name <- str_replace_all(tolower(data.NYS$Comp.Name), "ltd.", "")
data.NYS$Comp.Name <- str_replace_all(tolower(data.NYS$Comp.Name), "l.l.p.", "")
data.NYS$Comp.Name <- str_replace_all(tolower(data.NYS$Comp.Name), "us", "")
data.NYS$Comp.Name <- str_replace_all(tolower(data.NYS$Comp.Name), "inc.", "")
data.NYS$Comp.Name <- str_replace_all(tolower(data.NYS$Comp.Name), "inc", "")
data.NYS$Comp.Name <- str_replace_all(tolower(data.NYS$Comp.Name), "p.c.", "")
data.NYS$Comp.Name <- str_replace_all(tolower(data.NYS$Comp.Name), "plc", "")
data.NYS$Comp.Name <- str_replace_all(tolower(data.NYS$Comp.Name), "l.p.", "")
data.NYS$Comp.Name <- str_replace_all(tolower(data.NYS$Comp.Name), "()", "")
data.NYS$Comp.Name <- str_replace_all(tolower(data.NYS$Comp.Name), "p.a.", "")

# data.NYS$Comp.Name <- str_replace_all(tolower(data.NYS$Comp.Name), c("p.a.","()","l.p.", "plc", "p.c.", "inc", "inc.", 
#                                                                      "us", "l.l.p.", "ltd.", "l.l.c.", "llc", "llp", "[&,]") , "")
# data.NYS <- with(data.NYS, data.NYS[!(Comp.Name == "" | is.na(Comp.Name)), ]), 

com_name <- data.frame(table(str_trim(data.NYS$Comp.Name)))
com_name <- plyr::arrange(com_name, desc(com_name$Freq))

com_name.plot <- ggplot(data=com_name[1:20,], aes(x=reorder(Var1, Freq), y=Freq)) + coord_flip(ylim= c(400,830))
com_name.plot <- com_name.plot + geom_bar(stat = "identity") + theme(axis.text.y = element_text(size = 14), axis.text.x = element_text(size = 14)) # angle = 90, vjust = 0.5, hjust=1, 
com_name.plot <- com_name.plot + ylab("How many registered lawyers do companies have in NYC ?") + xlab("Companies")
com_name.plot <- com_name.plot + scale_y_continuous(breaks = seq(400, 830, 50))
com_name.plot



f500 <- html("http://www.zyxware.com/articles/4344/list-of-fortune-500-companies-and-their-websites") %>%
  html_node(".data-table") %>%
  html_table(header = TRUE)
f500 <- f500[1:100, ]

f500.com <- data.frame(Names = tolower(f500$Company))

f500.com$Names <- str_replace_all(f500.com$Names, "inc", "")
f500.com$Names <- str_replace_all(f500.com$Names, "inc.", "")
f500.com$Names <- str_replace_all(f500.com$Names, "l.p.", "")
f500.com$Names <- str_replace_all(f500.com$Names, "[.,]", "")



rightj <- right_join(com_name, f500.com, by = c("Var1" = "Names"))




tbl()
filter(data.NYS, data.NYS$Email == str_detect(data.NYS$Email, "bloomberg"))


