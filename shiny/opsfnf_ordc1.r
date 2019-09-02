rm(list=setdiff(ls(), keepers))






## old page


c_monyr <- read_html('http://cdec.water.ca.gov/cgi-progs/reports.cur?s=fnf') %>%
  html_nodes("h1") %>% html_text()
c_monyr <- gsub("Daily Full Natural Flows for ", "", c_monyr)
c_monyr <- as.yearmon(c_monyr)
c_mon <- month(c_monyr)
c_yr <- year(c_monyr)
c_yr


## java/css page

# current month fnf
c_fnf <-  readHTMLTable("http://cdec.water.ca.gov/reportapp/javareports?name=FNF", as.data.frame = TRUE)

c_fnf_toptable <- c_fnf[[1]]
#c_fnf_bottable <- c_fnf[[2]]  #only need top table for oroville

c_ordc1_fnf <- c_fnf_toptable %>% transmute(V1, V5)
c_ordc1_fnf <- c_ordc1_fnf[-1,] %>% transmute(day = V1, c_ordc1_fnf = V5)
c_ordc1_fnf <- c_ordc1_fnf %>% mutate(day = as.numeric(as.character(day)))
c_ordc1_fnf <- na.omit(c_ordc1_fnf)
c_ordc1_fnf$c_ordc1_fnf <- gsub(",", "", c_ordc1_fnf$c_ordc1_fnf)
c_ordc1_fnf <- c_ordc1_fnf %>% transmute(day, ordc1_fnf = as.numeric(as.character(c_ordc1_fnf)))
c_ordc1_fnf <- c_ordc1_fnf %>% transmute(chps_date = paste0(c_yr,"-", c_mon, "-", day), 
                                         chps_date = ymd(chps_date) + 1, ordc1_fnf)

c_ordc1_fnf


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
#p_fnf_toptable <- p_fnf[[1]]
##p_fnf_bottable <- p_fnf[[2]]  #only need top table for oroville
#
#p_ordc1_fnf <- p_fnf_toptable %>% transmute(V1, V5)
#p_ordc1_fnf <- p_ordc1_fnf[-1,] %>% transmute(day = V1, p_ordc1_fnf = V5)
#p_ordc1_fnf <- p_ordc1_fnf %>% mutate(day = as.numeric(as.character(day)))
#p_ordc1_fnf <- na.omit(p_ordc1_fnf)
#p_ordc1_fnf$p_ordc1_fnf <- gsub(",", "", p_ordc1_fnf$p_ordc1_fnf)
#p_ordc1_fnf <- p_ordc1_fnf %>% transmute(day, ordc1_fnf = as.numeric(as.character(p_ordc1_fnf)))
#p_ordc1_fnf <- p_ordc1_fnf %>% transmute(chps_date = paste0(p_yr,"-", p_mon, "-", day), 
#                                         chps_date = ymd(chps_date) + 1, ordc1_fnf)
#p_ordc1_fnf
#
#
#
#orov_fnf <- rbind(c_ordc1_fnf, if(exists("p_ordc1_fnf")) p_ordc1_fnf)

orov_fnf <- c_ordc1_fnf
rm(list=setdiff(ls(), keepers))


  