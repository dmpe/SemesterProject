library(readr)
library(stringi)
library(stringr)
library(plyr)
library(ggplot2)
library(dplyr)
library(rvest)
#####################
#' https://en.wikipedia.org/wiki/New_York_Supreme_Court,_Appellate_Division
#' https://stackoverflow.com/questions/26659198/detect-multiple-strings-with-dplyr-and-stringr
#' https://stackoverflow.com/questions/1236620/global-variables-in-r
#####################

data.NYS <- readr::read_csv("/srv/shiny-server/SemesterProject/Data/NYS_Attorney_Registrations.csv",
                            col_types = list("Zip" = col_character(), "Zip Plus Four" = col_character(), "Suffix" = col_skip(), "Middle Name" = col_skip()))

data.NYS[data.NYS == ""] <- NA
colnames(data.NYS) <- c("ID", "F.Name", "L.Name", "Comp.Name", "Street_1", "Street_2", "City", "State", "Zip", "Zip_2", "Country", "County",  "Phone", "Email", "Year_Adm", "JDoA", "Law_School", "Status", "Next_Reg")
data.NYS <- colwise(function(x){stri_trim_both(x)})(data.NYS)
# data.NYS <- tbl_df(data.NYS)
# names(data.NYS)
# problems(data.NYS)
# summary(data.NY)

# 
# splitted.email <- stri_split_fixed(data.NYS$Email, "@", 2, omit_empty = NA, simplify = TRUE) 
# splitted.email <- data.frame(na.omit(splitted.email))
# colnames(splitted.email) <- c("NickName", "Organisation")
# splitted.email.2 <- data.frame(table(tolower(splitted.email$Organisation)))
# splitted.email.2 <- plyr::arrange(splitted.email.2, desc(splitted.email.2$Freq))
# 
# law_school <- data.frame(table(tolower(data.NYS$Law_School)))
# law_school <- plyr::arrange(law_school, desc(law_school$Freq))

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

data.NYS$Comp.Name <- tolower(data.NYS$Comp.Name)
testingString <- as.character(na.omit(data.NYS$Comp.Name))

stringsToCheck <- c("corporation.", "corporation", "corp", "corp.", "group", "gmbh", "company", "pllc", "llp", "llc", "l.l.c.", "l.l.p.",
                    "ltd.","inc.", "inc", "plc", "p.c.", "pc", "p.a.", "l.p.", "lp", "co.", "l.p")
patTTT <- paste(stringsToCheck, collapse = '|')


# # zatim nefung "[&,]"
# checkAndCleanFormatting <- function(x) {
#   x <- stri_trim_both(x)  
#   # print(length(x))
#   for(i in 1:length(x)) {
#     if(stri_detect_regex(x[i],patTTT) == TRUE) {
#       # print("yes, the string does contain some of them")
#       x[i] <- str_replace(x[i], patTTT, "")
#     }
#   }
#   x <- stri_trim_both(x)
# }

# testingString <- checkAndCleanFormatting(testingString)
# testingStringSmall <- testingString[1:100000]
for(i in 1:2) {
  data.NYS$Comp.Name <- sapply(as.character(data.NYS$Comp.Name), function(x) {
    if ( is.na(x) == T) {
      x <- NA
    } else {
      x <- stri_replace_first_fixed(x, "&", "and")
      x <- stri_replace_last_fixed(x, "and", "")
      x <- stri_replace_last_regex(x, ",", "") 
      if(stri_detect_regex(x, patTTT) == TRUE) {
        x <- str_replace(x, patTTT, "") 
      }
      x <- stri_trim_both(x)
    }
  })
}

# saddawda <- data.frame(testingString)



# sapply(testingString, function(x) sapply(stringsToCheck, str_extract, string = x))
# sapply(testingString[1:20], function(x) {
#   any(sapply(stringsToCheck, str_detect, string = x))
# }) 

# data.NYS$Comp.Name <- str_replace_all(data.NYS$Comp.Name, "[&,]", "")

com_name <- data.frame(table(str_trim(data.NYS$Comp.Name)))
com_name <- plyr::arrange(com_name, desc(com_name$Freq))
com_name$Var1 <- as.character(com_name$Var1)

# com_name.plot <- ggplot(data=com_name[1:20,], aes(x=reorder(Var1, Freq), y=Freq)) + coord_flip(ylim= c(400,830))
# com_name.plot <- com_name.plot + geom_bar(stat = "identity") + theme(axis.text.y = element_text(size = 14), axis.text.x = element_text(size = 14)) # angle = 90, vjust = 0.5, hjust=1, 
# com_name.plot <- com_name.plot + ylab("How many registered lawyers do companies have in NYC ?") + xlab("Companies")
# com_name.plot <- com_name.plot + scale_y_continuous(breaks = seq(400, 830, 50))
# com_name.plot



f500 <- html("http://www.zyxware.com/articles/4344/list-of-fortune-500-companies-and-their-websites") %>%
  html_node(".data-table") %>%
  html_table(header = TRUE)
# f500 <- f500[1:100, ]

f500.com <- data.frame(Names = tolower(f500$Company))
# f500.com$Names <- str_replace_all(f500.com$Names, "inc", "")
# f500.com$Names <- str_replace_all(f500.com$Names, "inc.", "")
# f500.com$Names <- stri_replace_last_fixed(f500.com$Names, "l.p.", "")
# f500.com$Names <- str_replace_all(f500.com$Names, "[.,]", "")
# f500.com$Names <- str_replace_all(f500.com$Names, "&", "and")


# for(i in 1:2) {
f500.com$Names <- sapply(as.character(f500.com$Names), function(x) {
  if ( is.na(x) == T) {
    x <- NA
  } else {
    x <- stri_replace_first_fixed(x, "&", "and")
    x <- stri_replace_last_fixed(x, "and", "")
    if(stri_detect_regex(x, patTTT) == TRUE) {
      x <- stri_replace_last_regex(x, patTTT, "") 
    }
    x <- stri_replace_last_fixed(x, ",", "")
    x <- stri_replace_last_fixed(x, ".", "")
    x <- stri_trim_both(x)
  }
})
# }

right.join <- right_join(com_name, f500.com, by = c("Var1" = "Names"))
right.join <- plyr::arrange(right.join, desc(right.join$Freq))


