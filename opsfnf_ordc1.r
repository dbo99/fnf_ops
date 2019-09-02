## old page


c_fnf1 <-  read_html("http://cdec.water.ca.gov/cgi-progs/reports.cur?s=fnf")
c_fnf1[3]

## java/css page

# current month fnf
c_fnf2 <-  readHTMLTable("http://cdec.water.ca.gov/reportapp/javareports?name=FNF", as.data.frame = TRUE)

c_fnf_toptable <- c_fnf2[[1]]
#c_fnf_bottable <- c_fnf[[2]]  #only need top table for oroville

ordc1_fnf <- c_fnf_toptable %>% transmute(V1, V5)
ordc1_fnf <- ordc1_fnf[-1,] %>% transmute(day = V1, ordc1_fnf = V5)
ordc1_fnf <- ordc1_fnf %>% mutate(day = as.numeric(as.character(day)))
ordc1_fnf <- na.omit(ordc1_fnf)
ordc1_fnf$ordc1_fnf <- gsub(",", "", ordc1_fnf$ordc1_fnf)
ordc1_fnf <- ordc1_fnf %>% mutate(ordc1_fnf = as.numeric(as.character(ordc1_fnf)))
ordc1_fnf <

# previous month
p_month <- as.yearmon( (Sys.Date())) - 1/12 
p_month <- p_month %>% format("%Y%m")
p_month

p_month_url <- paste0("http://cdec.water.ca.gov/reportapp/javareports?name=FNF.", p_month)
p_month_url

p_fnf <-  readHTMLTable(p_month_url, as.data.frame = TRUE)

p_fnf_toptable <- c_fnf[[1]]
#p_fnf_bottable <- c_fnf[[2]]  #only need top table for oroville
