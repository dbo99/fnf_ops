#rm(list = ls()) 


#{
#rm(list=setdiff(ls(), keepers))

source("libs.r")

## current ("c_") cvo reports
#{
c_trin_url <- "https://www.usbr.gov/mp/cvo/vungvari/trndop.pdf"
c_rawtext  <- pdf_text(c_trin_url)
c_rawtext
c_trin_mon_yr  <- str_match(c_rawtext, "CALIFORNIA\r\n(.*?)TRINITY")  #https://stackoverflow.com/questions/39086400/extracting-a-string-between-other-two-strings-in-r
if (anyNA(c_trin_mon_yr)) {c_trin_mon_yr  <- str_match(c_rawtext, "CALIFORNIA\n(.*?)TRINITY") } #PCs have \r\n, macs/linux just \n!!!!
c_trin_mon_yr <- c_trin_mon_yr[,2] %>% trimws() %>% as.yearmon() 
c_trin_mon_yr 
c_trin_mon_yr_mmyy <- c_trin_mon_yr  %>%  format( "%m%y")
c_trin_mon  <- c_trin_mon_yr  %>%  format( "%m")
c_trin_yr <- c_trin_mon_yr  %>%  format( "%y")

## previous ("p_") cvo report url (to look back last month at beginning of new month)
p_trin_mon_yr <- c_trin_mon_yr - 1/12
p_trin_mon_yr_mmyy <- p_trin_mon_yr %>% format( "%m%y")
p_trin_urlbase <- "https://www.usbr.gov/mp/cvo/vungvari/trndop" #0719.pdf
p_trin_url <- paste0(p_trin_urlbase, p_trin_mon_yr_mmyy, ".pdf")
p_rawtext  <- pdf_text(p_trin_url)
p_trin_mon  <- p_trin_mon_yr  %>%  format( "%m")
p_trin_yr <- p_trin_mon_yr  %>%  format( "%y")
#p_trin_url



cliptrintable <- function(rawtext, start, end) {
  read.table(text = substring(rawtext, regexpr(start, rawtext), 
                              regexpr(end, rawtext))) }
  
cliptrintable2 <- possibly(cliptrintable, otherwise = NA)
### scrape current report ###

end <- "\nTOTALS"
#c_trin_fnf <- read.table(text = substring(c_rawtext, regexpr(start, c_rawtext), 
#                                          regexpr(end, c_rawtext)))


start1 <- "\n  1"  #trinity tables can start with either
start2 <- "\n   1" #trinity tables can start with either
c_trin_fnf <- cliptrintable2(c_rawtext, start1, end)  
if (is.na(c_trin_fnf)) {c_trin_fnf <- cliptrintable2(c_rawtext, start2, end) }
  
  


c_trin_fnf
#rm(c_rawtext)
#}


# rename current report columns #
c_trin_fnf  <- c_trin_fnf %>% rename("monthday" = !!names(.[1]),
                                                           "trin_elev_ft" = !!names(.[2]),
                                                           "trin_stor_af" = !!names(.[3]),
                                                           "trin_stor_dlychnge_af" = !!names(.[4]),
                                                           "trin_fnf_cfs" = !!names(.[5]),
                                                           "power_rel_cfs" = !!names(.[6]) ,
                                                           "spill_rel_cfs" = !!names(.[7]),
                                                           "outlet_rel_cfs" = !!names(.[8]),
                                                           "evap_rel_cfs" = !!names(.[9]),
                                                           "evap_rel_in" = !!names(.[10])  ,                                          
                                                           "prcp_dly_in" = !!names(.[11]))
c_trin_fnf
c_trin_fnf <- c_trin_fnf %>% transmute(monthday, trin_fnf = trin_fnf_cfs)

head(c_trin_fnf)

c_trin_fnf <- c_trin_fnf %>% mutate(date = paste0(c_trin_mon,"/", monthday,"/", c_trin_yr)) %>%
                           transmute(chps_date = mdy(date) + 1, trin_fnf)
head(c_trin_fnf)

### scrape previous report ###
p_trin_fnf <- cliptrintable2(p_rawtext, start1, end)  
if (is.na(p_trin_fnf)) {p_trin_fnf <- cliptrintable2(p_rawtext, start2, end) }




# rename current report columns #
p_trin_fnf  <- p_trin_fnf %>% rename("monthday" = !!names(.[1]),
                                     "trin_elev_ft" = !!names(.[2]),
                                     "trin_stor_af" = !!names(.[3]),
                                     "trin_stor_dlychnge_af" = !!names(.[4]),
                                     "trin_fnf_cfs" = !!names(.[5]),
                                     "trin_power_rel_cfs" = !!names(.[6]) ,
                                     "trin_spill_rel_cfs" = !!names(.[7]),
                                     "trin_outlet_rel_cfs" = !!names(.[8]),
                                     "trin_evap_rel_cfs" = !!names(.[9]),
                                     "trin_evap_rel_in" = !!names(.[10])  ,                                          
                                     "trin_prcp_dly_in" = !!names(.[11]))
p_trin_fnf
p_trin_fnf <- p_trin_fnf %>% transmute(monthday, trin_fnf = trin_fnf_cfs)

head(p_trin_fnf)

p_trin_fnf <- p_trin_fnf %>% mutate(date = paste0(p_trin_mon,"/", monthday,"/", p_trin_yr)) %>%
  transmute(chps_date = mdy(date) + 1, trin_fnf)
head(p_trin_fnf)

trin_fnf <- rbind(c_trin_fnf, p_trin_fnf) %>% arrange(desc(chps_date))
trin_fnf <- head(trin_fnf, daysback)
trin_fnf

#rm(list=setdiff(ls(), keepers))
#}
