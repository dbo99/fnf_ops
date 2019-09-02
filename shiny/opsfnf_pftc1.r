rm(list=setdiff(ls(), keepers))
{

source("libs.r")

 ## "today's report" ## 

coe_text <- "http://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=0&report=COE"
coe_text <- html_text(html_node(read_html(coe_text),".h2 , pre"))
value <- "Pine Flat Natural Flow (.*?) Below N. F. nr Trimmer"
value <- regmatches(coe_text,regexec(value, coe_text))
value <- value[[1]][2]
value <- gsub("cfs):", "", value)
value <- gsub("\n", "", value)
value <- gsub("\\(", "", value ) %>% trimws() %>% as.numeric() %>% round(0)
coe_text
rprt_gen_date <- "Report Generated (.*?) @"
rprt_gen_date <- regmatches(coe_text,regexec(rprt_gen_date, coe_text)) 
rprt_gen_date <- rprt_gen_date[[1]][2] 
rprt_gen_date <- dmy(rprt_gen_date) %>% as.Date()   #gets report date

rprt_dataend_date <- "2400 hours(.*?)\n Report Generated"
rprt_dataend_date <- regmatches(coe_text,regexec(rprt_dataend_date, coe_text)) 
rprt_dataend_date
rprt_dataend_date <- str_sub(rprt_dataend_date, start= -14)
rprt_dataend_date
rprt_dataend_date <- dmy(rprt_dataend_date)
rprt_dataend_date

chps_date <-  rprt_dataend_date + 1 # chps_fnf = their latest value   
chps_date     
pineflat_fnf_0 <- data.frame(chps_date, value) %>% 
                  transmute(chps_date, pnft_fnf = value)

head(pineflat_fnf_0)
 
## "yesterday's report" ##  

coe_text <- "http://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=1&report=COE"
coe_text <- html_text(html_node(read_html(coe_text),".h2 , pre"))
value <- "Pine Flat Natural Flow (.*?) Below N. F. nr Trimmer"
value <- regmatches(coe_text,regexec(value, coe_text))
value <- value[[1]][2]
value <- gsub("cfs):", "", value)
value <- gsub("\n", "", value)
value <- gsub("\\(", "", value ) %>% trimws() %>% as.numeric() %>% round(0)

rprt_dataend_date <- "2400 hours(.*?)\n Report Generated"
rprt_dataend_date <- regmatches(coe_text,regexec(rprt_dataend_date, coe_text)) 
rprt_dataend_date
rprt_dataend_date <- str_sub(rprt_dataend_date, start= -14)
rprt_dataend_date
rprt_dataend_date <- dmy(rprt_dataend_date)
rprt_dataend_date 

chps_date <-  rprt_dataend_date + 1 # chps_fnf = their latest value  

pineflat_fnf_1 <- data.frame(chps_date, value) %>% 
  transmute(chps_date, pnft_fnf = value)

head(pineflat_fnf_1)

## 2 days' ago report" ##  

coe_text <- "http://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=2&report=COE"
coe_text <- html_text(html_node(read_html(coe_text),".h2 , pre"))
value <- "Pine Flat Natural Flow (.*?) Below N. F. nr Trimmer"
value <- regmatches(coe_text,regexec(value, coe_text))
value <- value[[1]][2]
value <- gsub("cfs):", "", value)
value <- gsub("\n", "", value)
value <- gsub("\\(", "", value ) %>% trimws() %>% as.numeric() %>% round(0)

rprt_dataend_date <- "2400 hours(.*?)\n Report Generated"
rprt_dataend_date <- regmatches(coe_text,regexec(rprt_dataend_date, coe_text)) 
rprt_dataend_date
rprt_dataend_date <- str_sub(rprt_dataend_date, start= -14)
rprt_dataend_date
rprt_dataend_date <- dmy(rprt_dataend_date)
rprt_dataend_date 

chps_date <-  rprt_dataend_date + 1 # chps_fnf = their latest value   

pineflat_fnf_2 <- data.frame(chps_date, value) %>% 
  transmute(chps_date, pnft_fnf = value)

head(pineflat_fnf_2)

## 3 days' ago report" ##  

coe_text <- "http://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=3&report=COE"
coe_text <- html_text(html_node(read_html(coe_text),".h2 , pre"))
value <- "Pine Flat Natural Flow (.*?) Below N. F. nr Trimmer"
value <- regmatches(coe_text,regexec(value, coe_text))
value <- value[[1]][2]
value <- gsub("cfs):", "", value)
value <- gsub("\n", "", value)
value <- gsub("\\(", "", value ) %>% trimws() %>% as.numeric() %>% round(0)

rprt_dataend_date <- "2400 hours(.*?)\n Report Generated"
rprt_dataend_date <- regmatches(coe_text,regexec(rprt_dataend_date, coe_text)) 
rprt_dataend_date
rprt_dataend_date <- str_sub(rprt_dataend_date, start= -14)
rprt_dataend_date
rprt_dataend_date <- dmy(rprt_dataend_date)
rprt_dataend_date 

chps_date <-  rprt_dataend_date + 1 # chps_fnf = their latest value     

pineflat_fnf_3 <- data.frame(chps_date, value) %>% 
  transmute(chps_date, pnft_fnf = value)

head(pineflat_fnf_3)

## 4 days' ago report" ##  

coe_text <- "http://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=4&report=COE"
coe_text <- html_text(html_node(read_html(coe_text),".h2 , pre"))
value <- "Pine Flat Natural Flow (.*?) Below N. F. nr Trimmer"
value <- regmatches(coe_text,regexec(value, coe_text))
value <- value[[1]][2]
value <- gsub("cfs):", "", value)
value <- gsub("\n", "", value)
value <- gsub("\\(", "", value ) %>% trimws() %>% as.numeric() %>% round(0)

rprt_dataend_date <- "2400 hours(.*?)\n Report Generated"
rprt_dataend_date <- regmatches(coe_text,regexec(rprt_dataend_date, coe_text)) 
rprt_dataend_date
rprt_dataend_date <- str_sub(rprt_dataend_date, start= -14)
rprt_dataend_date
rprt_dataend_date <- dmy(rprt_dataend_date)
rprt_dataend_date 

chps_date <-  rprt_dataend_date + 1 # chps_fnf = their latest value    

pineflat_fnf_4 <- data.frame(chps_date, value) %>% 
  transmute(chps_date, pnft_fnf = value)

head(pineflat_fnf_4)

## 5 days' ago report" ##  

coe_text <- "http://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=5&report=COE"
coe_text <- html_text(html_node(read_html(coe_text),".h2 , pre"))
value <- "Pine Flat Natural Flow (.*?) Below N. F. nr Trimmer"
value <- regmatches(coe_text,regexec(value, coe_text))
value <- value[[1]][2]
value <- gsub("cfs):", "", value)
value <- gsub("\n", "", value)
value <- gsub("\\(", "", value ) %>% trimws() %>% as.numeric() %>% round(0)

rprt_dataend_date <- "2400 hours(.*?)\n Report Generated"
rprt_dataend_date <- regmatches(coe_text,regexec(rprt_dataend_date, coe_text)) 
rprt_dataend_date
rprt_dataend_date <- str_sub(rprt_dataend_date, start= -14)
rprt_dataend_date
rprt_dataend_date <- dmy(rprt_dataend_date)
rprt_dataend_date 

chps_date <-  rprt_dataend_date + 1 # chps_fnf = their latest value   

pineflat_fnf_5 <- data.frame(chps_date, value) %>% 
  transmute(chps_date, pnft_fnf = value)

head(pineflat_fnf_5)

## 6 days' ago report" ##  

coe_text <- "http://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=6&report=COE"
coe_text <- html_text(html_node(read_html(coe_text),".h2 , pre"))
value <- "Pine Flat Natural Flow (.*?) Below N. F. nr Trimmer"
value <- regmatches(coe_text,regexec(value, coe_text))
value <- value[[1]][2]
value <- gsub("cfs):", "", value)
value <- gsub("\n", "", value)
value <- gsub("\\(", "", value ) %>% trimws() %>% as.numeric() %>% round(0)

rprt_dataend_date <- "2400 hours(.*?)\n Report Generated"
rprt_dataend_date <- regmatches(coe_text,regexec(rprt_dataend_date, coe_text)) 
rprt_dataend_date
rprt_dataend_date <- str_sub(rprt_dataend_date, start= -14)
rprt_dataend_date
rprt_dataend_date <- dmy(rprt_dataend_date)
rprt_dataend_date 

chps_date <-  rprt_dataend_date + 1 # chps_fnf = their latest value     

pineflat_fnf_6 <- data.frame(chps_date, value) %>% 
  transmute(chps_date, pnft_fnf = value)

head(pineflat_fnf_6)

pnft_fnf <- rbind(pineflat_fnf_0, pineflat_fnf_1, pineflat_fnf_2, pineflat_fnf_3,
                      pineflat_fnf_4, pineflat_fnf_5, pineflat_fnf_6)
rm(list=setdiff(ls(), keepers)) 

pnft_fnf
}
