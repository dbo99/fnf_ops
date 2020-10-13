rm(list=setdiff(ls(), keepers))






## old page


c_monyr <- read_html('https://cdec.water.ca.gov/cgi-progs/reports.cur?s=fnf') %>%
  html_nodes("h1") %>% html_text()
c_monyr <- gsub("Daily Full Natural Flows for ", "", c_monyr)
c_monyr <- as.yearmon(c_monyr)
c_mon <- month(c_monyr)
c_yr <- year(c_monyr)
c_yr


## java/css page

# current month fnf
#url <-  getURL("https://cdec.water.ca.gov/reportapp/javareports?name=FNF")
url <-  getURL("http://cdec.water.ca.gov/reportapp/javareports?name=FNF")
c_fnf <-  readHTMLTable(url, as.data.frame = TRUE)
#c_fnf <-  read_html("https://cdec.water.ca.gov/reportapp/javareports?name=FNF", as.data.frame = TRUE)

#c_fnf_toptable <- c_fnf[[1]]
c_fnf_bottable <- c_fnf[[2]]  #only need bott table for nm

c_nmsc1_fnf <- c_fnf_bottable %>% transmute(V1, V2)
c_nmsc1_fnf <- c_nmsc1_fnf[-1,] %>% transmute(day = V1, c_nmsc1_fnf = V2)
c_nmsc1_fnf <- c_nmsc1_fnf %>% mutate(day = as.numeric(as.character(day)))
c_nmsc1_fnf <- na.omit(c_nmsc1_fnf)
c_nmsc1_fnf$c_nmsc1_fnf <- gsub(",", "", c_nmsc1_fnf$c_nmsc1_fnf)
c_nmsc1_fnf <- c_nmsc1_fnf %>% transmute(day, nmsc1_fnf = as.numeric(as.character(c_nmsc1_fnf)))
c_nmsc1_fnf <- c_nmsc1_fnf %>% transmute(chps_date = paste0(c_yr,"-", c_mon, "-", day), 
                                         chps_date = ymd(chps_date) + 1, nmsc1_fnf)

c_nmsc1_fnf


# previous month

# previous published month
#p_monyr <- as.yearmon(c_monyr) - 1/12
#p_mon <- month(p_monyr)
#p_mon
#p_yr <- year(p_monyr)
#p_yr
#p_monyr <- p_monyr %>% format("%Y%m")
#p_monyr
##p_month_url <- paste0("http://cdec.water.ca.gov/reportapp/javareports?name=FNF.", p_monyr)
#p_month_url <- "http://cdec.water.ca.gov/reportapp/javareports?name=FNF.201906"
#p_month_url
#
#p_fnf <-  readHTMLTable(p_month_url, as.data.frame = TRUE)
#
##p_fnf_toptable <- p_fnf[[1]]
#p_fnf_bottable <- p_fnf[[2]]  #only need bott table for nm
#
#p_nmsc1_fnf <- p_fnf_toptable %>% transmute(V1, V2)
#p_nmsc1_fnf <- p_nmsc1_fnf[-1,] %>% transmute(day = V1, p_nmsc1_fnf = V2)
#p_nmsc1_fnf <- p_nmsc1_fnf %>% mutate(day = as.numeric(as.character(day)))
#p_nmsc1_fnf <- na.omit(p_nmsc1_fnf)
#p_nmsc1_fnf$p_nmsc1_fnf <- gsub(",", "", p_nmsc1_fnf$p_nmsc1_fnf)
#p_nmsc1_fnf <- p_nmsc1_fnf %>% transmute(day, nmsc1_fnf = as.numeric(as.character(p_nmsc1_fnf)))
#p_nmsc1_fnf <- p_nmsc1_fnf %>% transmute(chps_date = paste0(p_yr,"-", p_mon, "-", day), 
#                                         chps_date = ymd(chps_date) + 1, nmsc1_fnf)
#p_nmsc1_fnf
#
#
#
#orov_fnf <- rbind(c_nmsc1_fnf, if(exists("p_nmsc1_fnf")) p_nmsc1_fnf)

nmel_fnf <- c_nmsc1_fnf
rm(list=setdiff(ls(), keepers))


  