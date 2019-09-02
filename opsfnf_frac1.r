
{
rm(list=setdiff(ls(), keepers))
rstudioapi::getActiveDocumentContext
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source("libs.r")

## current ("c_") cvo reports
{
c_mil_url <- "https://www.usbr.gov/mp/cvo/vungvari/milfln.pdf"
c_rawtext  <- pdf_text(c_mil_url)
c_mil_mon_yr  <- str_match(c_rawtext, "CALIFORNIA\r\n(.*?)FULL")  #https://stackoverflow.com/questions/39086400/extracting-a-string-between-other-two-strings-in-r
c_mil_mon_yr <- c_mil_mon_yr[,2] %>% trimws() %>% as.yearmon() 
c_mil_mon_yr_mmyy <- c_mil_mon_yr  %>%  format( "%m%y")
c_mil_mon  <- c_mil_mon_yr  %>%  format( "%m")
c_mil_yr <- c_mil_mon_yr  %>%  format( "%y")

## previous ("p_") cvo report url (to look back last month at beginning of new month)
p_mil_mon_yr <- c_mil_mon_yr - 1/12
p_mil_mon_yr_mmyy <- p_mil_mon_yr %>% format( "%m%y")
p_mil_urlbase <- "https://www.usbr.gov/mp/cvo/vungvari/milfln" #0719.pdf
p_mil_url <- paste0(p_mil_urlbase, p_mil_mon_yr_mmyy, ".pdf")
p_rawtext  <- pdf_text(p_mil_url)
p_mil_mon  <- p_mil_mon_yr  %>%  format( "%m")
p_mil_yr <- p_mil_mon_yr  %>%  format( "%y")

### scrape current report ###
start <- "\n    1"
end <- "\n  TOTALS"
c_mill_fnf <- read.table(text = substring(c_rawtext, regexpr(start, c_rawtext), regexpr(end, c_rawtext)))
rm(start, end, c_rawtext)
}

{
# rename current report columns #
c_mill_fnf  <- c_mill_fnf %>% rename("monthday" = !!names(.[1]),
                                                           "Edison" = !!names(.[2]),
                                                           "Florence" = !!names(.[3]),
                                                           "Huntington" = !!names(.[4]),
                                                           "Shaver" = !!names(.[5]),
                                                           "MammothPool" = !!names(.[6]) ,
                                                           "Redinger" = !!names(.[7]),
                                                           "CraneValley" = !!names(.[8]),
                                                           "Kerckhoff" = !!names(.[9]),
                                                           "Millerton_upstream_stor" = !!names(.[10])  ,                                          
                                                           "Millerton_upstream_dlystorchange" = !!names(.[11]),
                                                           "Millerton_observedinflowchange_meandaily" = !!names(.[12]),
                                                           "Millerton_observedinflow_meandaily" = !!names(.[13]),
                                                           "mill_fnf" = !!names(.[14]),
                                                           "Millerton_natriver_wyaccum" = !!names(.[15])) 
c_mill_fnf <- c_mill_fnf %>% transmute(monthday, mill_fnf)
  
  }
head(c_mill_fnf)

c_mill_fnf <- c_mill_fnf %>% mutate(date = paste0(c_mil_mon,"/", monthday,"/", c_mil_yr)) %>%
                           transmute(chps_date = mdy(date) + 1, mill_fnf)
head(c_mill_fnf)

### scrape previous report ###
start <- "\n    1"
end <- "\n  TOTALS"
p_mill_fnf <- read.table(text = substring(p_rawtext, regexpr(start, p_rawtext), regexpr(end, p_rawtext)))
rm(start, end, p_rawtext)


{

# rename previous report columns #
p_mill_fnf  <- p_mill_fnf %>% rename("monthday" = !!names(.[1]),
                                     "Edison" = !!names(.[2]),
                                     "Florence" = !!names(.[3]),
                                     "Huntington" = !!names(.[4]),
                                     "Shaver" = !!names(.[5]),
                                     "MammothPool" = !!names(.[6]) ,
                                     "Redinger" = !!names(.[7]),
                                     "CraneValley" = !!names(.[8]),
                                     "Kerckhoff" = !!names(.[9]),
                                     "Millerton_upstream_stor" = !!names(.[10])  ,                                          
                                     "Millerton_upstream_dlystorchange" = !!names(.[11]),
                                     "Millerton_observedinflowchange_meandaily" = !!names(.[12]),
                                     "Millerton_observedinflow_meandaily" = !!names(.[13]),
                                     "mill_fnf" = !!names(.[14]),
                                     "Millerton_natriver_wyaccum" = !!names(.[15])) 
  p_mill_fnf <- p_mill_fnf %>% transmute(monthday, mill_fnf)
  
}
head(p_mill_fnf)

p_mill_fnf <- p_mill_fnf %>% mutate(date = paste0(p_mil_mon,"/", monthday,"/", p_mil_yr)) %>%
  transmute(chps_date = mdy(date) + 1, mill_fnf)
head(p_mill_fnf)

mill_fnf <- rbind(c_mill_fnf, p_mill_fnf) %>% arrange(desc(chps_date))
mill_fnf <- head(mill_fnf, daysback)
mill_fnf

rm(list=setdiff(ls(), keepers))
}
