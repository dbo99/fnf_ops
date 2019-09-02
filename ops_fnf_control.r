


rm(list = ls())

{
 
keepers <- c("mill_fnf", "trin_fnf", "whis_fnf", "shst_fnf", 
               "pnft_fnf", "moke_fnf", "orov_fnf", "keepers", "daysback", "df")
rm(list=setdiff(ls(), keepers))
rstudioapi::getActiveDocumentContext
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

daysback <- 14
}

{
source("opsfnf_cegc1.r")
source("opsfnf_whsc1.r")
source("opsfnf_shdc1.r")
source("opsfnf_frac1.r")
source("opsfnf_pftc1.r")
source("opsfnf_cmpc1.r")
#source("opsfnf_ordc1.r")
}

#### oroville special case (their last month report not always available!)


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
p_monyr <- as.yearmon(c_monyr) - 1/12
p_mon <- month(p_monyr)
p_mon
p_yr <- year(p_monyr)
p_yr
p_monyr <- p_monyr %>% format("%Y%m")
p_monyr
p_month_url <- paste0("http://cdec.water.ca.gov/reportapp/javareports?name=FNF.", p_monyr)
#p_month_url <- "http://cdec.water.ca.gov/reportapp/javareports?name=FNF.201906" for testing when prev month not published online
p_month_url

p_fnf <-  readHTMLTable(p_month_url, as.data.frame = TRUE)

p_fnf_toptable <- p_fnf[[1]]
#p_fnf_bottable <- p_fnf[[2]]  #only need top table for oroville

p_ordc1_fnf <- p_fnf_toptable %>% transmute(V1, V5)
p_ordc1_fnf <- p_ordc1_fnf[-1,] %>% transmute(day = V1, p_ordc1_fnf = V5)
p_ordc1_fnf <- p_ordc1_fnf %>% mutate(day = as.numeric(as.character(day)))
p_ordc1_fnf <- na.omit(p_ordc1_fnf)
p_ordc1_fnf$p_ordc1_fnf <- gsub(",", "", p_ordc1_fnf$p_ordc1_fnf)
p_ordc1_fnf <- p_ordc1_fnf %>% transmute(day, ordc1_fnf = as.numeric(as.character(p_ordc1_fnf)))
p_ordc1_fnf <- p_ordc1_fnf %>% transmute(chps_date = paste0(p_yr,"-", p_mon, "-", day), 
                                         chps_date = ymd(chps_date) + 1, ordc1_fnf)
p_ordc1_fnf



orov_fnf <- rbind(c_ordc1_fnf, if(exists("p_ordc1_fnf")) p_ordc1_fnf)
orov_fnf

today <- Sys.Date()
chps_date <- seq(today, by = "-1 day", length.out = daysback) 
chps_date <- data.frame(chps_date)
chps_date


df <- left_join(chps_date, trin_fnf)
df <- left_join(df,  whis_fnf)
df <- left_join(df,  shst_fnf)
df <- left_join(df,  mill_fnf)
df <- left_join(df,  pnft_fnf)
df <- left_join(df,  moke_fnf)
df <- left_join(df,  orov_fnf)
df
df <- df %>% transmute(chps_date, cegc1 = trin_fnf, whsc1 = whi_fnf, shdc1 = shst_fnf,
                       frac1 = mill_fnf, pftc1 = pnft_fnf, cmpc1 = moke_fnf, ordc1 = ordc1_fnf)
df
df <- df %>% mutate_if(is.factor, as.character)
df$cegc1 <- gsub(",", "", df$cegc1)
df$shdc1 <- gsub(",", "", df$shdc1)
df$frac1 <- gsub(",", "", df$frac1)
df$pftc1 <- gsub(",", "", df$pftc1)
df$cmpc1 <- gsub(",", "", df$cmpc1)
df$whsc1 <- gsub(",", "", df$whsc1)
df$ordc1 <- gsub(",", "", df$ordc1)

df
df <- df %>% mutate_if(is.character, as.numeric)
df <- df %>% transmute(chps_date, cegc1, whsc1, shdc1, ordc1, cmpc1, frac1, pftc1)

df
rm(list=setdiff(ls(), keepers))
