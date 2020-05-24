rm(list = setdiff(ls(),  keepers))
{

source("libs.r")

## "today's report" ## 

page <- "https://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=0&report=SC7"
coe_text <- html_text(html_node(read_html(page),".h2 , pre")) #.h2 & pre Id'd by SelectorGadget

coe_text <- unlist(strsplit(coe_text,"\n"))
scrape_between <- "Mokelumne River Natural Flow @ Camanche \\(cfs\\)" #Escape the parenthesis in regex
cfs_row <- coe_text[str_detect(coe_text,scrape_between)] #Get the row which contains the above text
cfs_row

fnf_value <- gsub("^.*\\.(.*)$","\\1",cfs_row)# Get the value after the last elipses
fnf_value
fnf_value <- gsub(" ","", fnf_value) %>% trimws()
#fnf_value <- gsub("-","", fnf_value)
fnf_value <- gsub("-NR",NA, fnf_value)
fnf_value


scrape_end <- "Data Ending 2400 hours"
date_row <- coe_text[str_detect(coe_text,scrape_end)]
chps_date <- gsub("Data Ending 2400 hours","",date_row) %>% trimws()
chps_date <- dmy(chps_date) + 1
chps_date

moke_fnf_0 <- data.frame(chps_date, fnf_value) %>% 
  transmute(chps_date, moke_fnf = fnf_value)
moke_fnf_0

## yesterday's report" ## 

page <- "https://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=1&report=SC7"
coe_text <- html_text(html_node(read_html(page),".h2 , pre")) #.h2 & pre Id'd by SelectorGadget

coe_text <- unlist(strsplit(coe_text,"\n"))
scrape_between <- "Mokelumne River Natural Flow @ Camanche \\(cfs\\)" #Escape the parenthesis in regex
cfs_row <- coe_text[str_detect(coe_text,scrape_between)] #Get the row which contains the above text
cfs_row

fnf_value <- gsub("^.*\\.(.*)$","\\1",cfs_row)# Get the value after the last elipses
fnf_value
fnf_value <- gsub(" ","", fnf_value) %>% trimws()
#fnf_value <- gsub("-","", fnf_value)
fnf_value <- gsub("-NR",NA, fnf_value)
fnf_value


scrape_end <- "Data Ending 2400 hours"
date_row <- coe_text[str_detect(coe_text,scrape_end)]
chps_date <- gsub("Data Ending 2400 hours","",date_row) %>% trimws()
chps_date <- dmy(chps_date) + 1
chps_date

moke_fnf_1 <- data.frame(chps_date, fnf_value) %>% 
  transmute(chps_date, moke_fnf = fnf_value)
moke_fnf_1

## "two days ago report" ## 

page <- "https://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=2&report=SC7"
coe_text <- html_text(html_node(read_html(page),".h2 , pre")) #.h2 & pre Id'd by SelectorGadget

coe_text <- unlist(strsplit(coe_text,"\n"))
scrape_between <- "Mokelumne River Natural Flow @ Camanche \\(cfs\\)" #Escape the parenthesis in regex
cfs_row <- coe_text[str_detect(coe_text,scrape_between)] #Get the row which contains the above text
cfs_row

fnf_value <- gsub("^.*\\.(.*)$","\\1",cfs_row)# Get the value after the last elipses
fnf_value
fnf_value <- gsub(" ","", fnf_value) %>% trimws()
#fnf_value <- gsub("-","", fnf_value)
fnf_value <- gsub("-NR",NA, fnf_value)
fnf_value


scrape_end <- "Data Ending 2400 hours"
date_row <- coe_text[str_detect(coe_text,scrape_end)]
chps_date <- gsub("Data Ending 2400 hours","",date_row) %>% trimws()
chps_date <- dmy(chps_date) + 1
chps_date

moke_fnf_2 <- data.frame(chps_date, fnf_value) %>% 
  transmute(chps_date, moke_fnf = fnf_value)
moke_fnf_2

## "three days ago report" ## 

page <- "https://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=3&report=SC7"
coe_text <- html_text(html_node(read_html(page),".h2 , pre")) #.h2 & pre Id'd by SelectorGadget

coe_text <- unlist(strsplit(coe_text,"\n"))
scrape_between <- "Mokelumne River Natural Flow @ Camanche \\(cfs\\)" #Escape the parenthesis in regex
cfs_row <- coe_text[str_detect(coe_text,scrape_between)] #Get the row which contains the above text
cfs_row

fnf_value <- gsub("^.*\\.(.*)$","\\1",cfs_row)# Get the value after the last elipses
fnf_value
fnf_value <- gsub(" ","", fnf_value) %>% trimws()
#fnf_value <- gsub("-","", fnf_value)
fnf_value <- gsub("-NR",NA, fnf_value)
fnf_value


scrape_end <- "Data Ending 2400 hours"
date_row <- coe_text[str_detect(coe_text,scrape_end)]
chps_date <- gsub("Data Ending 2400 hours","",date_row) %>% trimws()
chps_date <- dmy(chps_date) + 1
chps_date

moke_fnf_3 <- data.frame(chps_date, fnf_value) %>% 
  transmute(chps_date, moke_fnf = fnf_value)
moke_fnf_3

## "four days ago report" ## 

page <- "https://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=4&report=SC7"
coe_text <- html_text(html_node(read_html(page),".h2 , pre")) #.h2 & pre Id'd by SelectorGadget

coe_text <- unlist(strsplit(coe_text,"\n"))
scrape_between <- "Mokelumne River Natural Flow @ Camanche \\(cfs\\)" #Escape the parenthesis in regex
cfs_row <- coe_text[str_detect(coe_text,scrape_between)] #Get the row which contains the above text
cfs_row

fnf_value <- gsub("^.*\\.(.*)$","\\1",cfs_row)# Get the value after the last elipses
fnf_value
fnf_value <- gsub(" ","", fnf_value) %>% trimws()
#fnf_value <- gsub("-","", fnf_value)
fnf_value <- gsub("-NR",NA, fnf_value)
fnf_value


scrape_end <- "Data Ending 2400 hours"
date_row <- coe_text[str_detect(coe_text,scrape_end)]
chps_date <- gsub("Data Ending 2400 hours","",date_row) %>% trimws()
chps_date <- dmy(chps_date) + 1
chps_date

moke_fnf_4 <- data.frame(chps_date, fnf_value) %>% 
  transmute(chps_date, moke_fnf = fnf_value)
moke_fnf_4

## "five days ago report" ## 

page <- "https://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=5&report=SC7"
coe_text <- html_text(html_node(read_html(page),".h2 , pre")) #.h2 & pre Id'd by SelectorGadget

coe_text <- unlist(strsplit(coe_text,"\n"))
scrape_between <- "Mokelumne River Natural Flow @ Camanche \\(cfs\\)" #Escape the parenthesis in regex
cfs_row <- coe_text[str_detect(coe_text,scrape_between)] #Get the row which contains the above text
cfs_row

fnf_value <- gsub("^.*\\.(.*)$","\\1",cfs_row)# Get the value after the last elipses
fnf_value
fnf_value <- gsub(" ","", fnf_value) %>% trimws()
#fnf_value <- gsub("-","", fnf_value)
fnf_value <- gsub("-NR",NA, fnf_value)
fnf_value


scrape_end <- "Data Ending 2400 hours"
date_row <- coe_text[str_detect(coe_text,scrape_end)]
chps_date <- gsub("Data Ending 2400 hours","",date_row) %>% trimws()
chps_date <- dmy(chps_date) + 1
chps_date

moke_fnf_5 <- data.frame(chps_date, fnf_value) %>% 
  transmute(chps_date, moke_fnf = fnf_value)
moke_fnf_5

## "six days ago report" ## 

page <- "https://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=6&report=SC7"
coe_text <- html_text(html_node(read_html(page),".h2 , pre")) #.h2 & pre Id'd by SelectorGadget

coe_text <- unlist(strsplit(coe_text,"\n"))
scrape_between <- "Mokelumne River Natural Flow @ Camanche \\(cfs\\)" #Escape the parenthesis in regex
cfs_row <- coe_text[str_detect(coe_text,scrape_between)] #Get the row which contains the above text
cfs_row

fnf_value <- gsub("^.*\\.(.*)$","\\1",cfs_row)# Get the value after the last elipses
fnf_value
fnf_value <- gsub(" ","", fnf_value) %>% trimws()
#fnf_value <- gsub("-","", fnf_value)
fnf_value <- gsub("-NR",NA, fnf_value)
fnf_value


scrape_end <- "Data Ending 2400 hours"
date_row <- coe_text[str_detect(coe_text,scrape_end)]
chps_date <- gsub("Data Ending 2400 hours","",date_row) %>% trimws()
chps_date <- dmy(chps_date) + 1
chps_date

moke_fnf_6 <- data.frame(chps_date, fnf_value) %>% 
  transmute(chps_date, moke_fnf = fnf_value)
moke_fnf_6

moke_fnf <- rbind(moke_fnf_0, moke_fnf_1, moke_fnf_2, moke_fnf_3,
                  moke_fnf_4, moke_fnf_5, moke_fnf_6)
rm(list = setdiff(ls(), keepers)) 
}
moke_fnf

