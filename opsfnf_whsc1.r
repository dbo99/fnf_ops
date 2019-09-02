rm(list=setdiff(ls(), keepers))
#{
rstudioapi::getActiveDocumentContext
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
source("libs.r")

## current ("c_") cvo reports
{
c_whis_url <- "https://www.usbr.gov/mp/cvo/vungvari/whidop.pdf"
c_rawtext  <- pdf_text(c_whis_url)
c_whis_mon_yr  <- str_match(c_rawtext, "CALIFORNIA\r\n(.*?)WHISKEYTOWN")  #https://stackoverflow.com/questions/39086400/extracting-a-string-between-other-two-strings-in-r
c_whis_mon_yr <- c_whis_mon_yr[,2] %>% trimws() %>% as.yearmon() 
c_whis_mon_yr_mmyy <- c_whis_mon_yr  %>%  format( "%m%y")
c_whis_mon  <- c_whis_mon_yr  %>%  format( "%m")
c_whis_yr <- c_whis_mon_yr  %>%  format( "%y")

## previous ("p_") cvo report url (to look back last month at beginning of new month)
p_whis_mon_yr <- c_whis_mon_yr - 1/12
p_whis_mon_yr_mmyy <- p_whis_mon_yr %>% format( "%m%y")
p_whis_urlbase <- "https://www.usbr.gov/mp/cvo/vungvari/whidop" #0719.pdf
p_whis_url <- paste0(p_whis_urlbase, p_whis_mon_yr_mmyy, ".pdf")
p_rawtext  <- pdf_text(p_whis_url)
p_whis_mon  <- p_whis_mon_yr  %>%  format( "%m")
p_whis_yr   <- p_whis_mon_yr  %>%  format( "%y")

### scrape current report ###
start <- "\n     1" #beware lengths vary between usbr pages, eg "\n  1"
end <- "\n  TOTALS"
c_whis_fnf <- read.table(text = substring(c_rawtext, regexpr(start, c_rawtext), regexpr(end, c_rawtext)))
c_whis_fnf
rm(c_rawtext)
}

{
# rename current report columns #
  c_whis_fnf  <- c_whis_fnf %>% rename("monthday" = !!names(.[1]),
                                       "whis_elev_ft" = !!names(.[2]),
                                       "whis_stor_af" = !!names(.[3]),
                                       "whis_stor_dlychnge_af" = !!names(.[4]),
                                       "whis_compinfl_cfs" = !!names(.[5]),
                                       "franciscarr_cfs" = !!names(.[6]) ,
                                       "clearck_fnf" = !!names(.[7]),
                                       "whis_outletrel_cfs" = !!names(.[8]),
                                       "whis_spill_rel_cfs" = !!names(.[9]),
                                       "whis_tosprckpp_cfs" = !!names(.[10]),                                       
                                       "whis_evaprel_cfs" = !!names(.[11])  ,    
                                       "whis_evaprel_in" = !!names(.[12])  , 
                                       "whis_prcpdly_in" = !!names(.[13]))
  
c_whis_fnf <- c_whis_fnf %>% transmute(monthday, clearck_fnf)
  
  }
head(c_whis_fnf)

c_whis_fnf <- c_whis_fnf %>% mutate(date = paste0(c_whis_mon,"/", monthday,"/", c_whis_yr)) %>%
                           transmute(chps_date = mdy(date) + 1, whi_fnf = clearck_fnf) #at least in chps, whsc1's fnf is clear creeks
head(c_whis_fnf)

### scrape previous report ###

p_whis_fnf <- read.table(text = substring(p_rawtext, regexpr(start, p_rawtext), regexpr(end, p_rawtext)))



{

# rename previous report columns #
  p_whis_fnf  <- p_whis_fnf %>% rename("monthday" = !!names(.[1]),
                                       "whis_elev_ft" = !!names(.[2]),
                                       "whis_stor_af" = !!names(.[3]),
                                       "whis_stor_dlychnge_af" = !!names(.[4]),
                                       "whis_compinfl_cfs" = !!names(.[5]),
                                       "franciscarr_cfs" = !!names(.[6]) ,
                                       "clearck_fnf" = !!names(.[7]),
                                       "whis_outletrel_cfs" = !!names(.[8]),
                                       "whis_spill_rel_cfs" = !!names(.[9]),
                                       "whis_tosprckpp_cfs" = !!names(.[10]),                                       
                                       "whis_evaprel_cfs" = !!names(.[11])  ,    
                                       "whis_evaprel_in" = !!names(.[12])  , 
                                       "whis_prcpdly_in" = !!names(.[13]))
  
  p_whis_fnf <- p_whis_fnf %>% transmute(monthday, clearck_fnf)
  
}
head(p_whis_fnf)

p_whis_fnf <- p_whis_fnf %>% mutate(date = paste0(p_whis_mon,"/", monthday,"/", p_whis_yr)) %>%
  transmute(chps_date = mdy(date) + 1, whi_fnf = clearck_fnf) #at least in chps, whsc1's fnf is clear creeks
head(p_whis_fnf)

whis_fnf <- rbind(c_whis_fnf, p_whis_fnf) %>% arrange(desc(chps_date))
whis_fnf <- head(whis_fnf, daysback)
whis_fnf

rm(list=setdiff(ls(), keepers))
#}
