rm(list=setdiff(ls(), keepers))
#{

#source("libs.r")

## current ("c_") cvo reports
#{
c_shst_url <- "https://www.usbr.gov/mp/cvo/vungvari/shafln.pdf"
c_rawtext  <- pdf_text(c_shst_url)
c_shst_mon_yr  <- str_match(c_rawtext, "CALIFORNIA\r\n(.*?)FULL")  #https://stackoverflow.com/questions/39086400/extracting-a-string-between-other-two-strings-in-r
if (anyNA(c_shst_mon_yr)) {c_shst_mon_yr  <- str_match(c_rawtext, "CALIFORNIA\n(.*?)FULL") } #PCs have 
c_shst_mon_yr <- c_shst_mon_yr[,2] %>% trimws() %>% as.yearmon() 
c_shst_mon_yr_mmyy <- c_shst_mon_yr  %>%  format( "%m%y")
c_shst_mon  <- c_shst_mon_yr  %>%  format( "%m")
c_shst_yr <- c_shst_mon_yr  %>%  format( "%y")

## previous ("p_") cvo report url (to look back last month at beginning of new month)
p_shst_mon_yr <- c_shst_mon_yr - 1/12
p_shst_mon_yr_mmyy <- p_shst_mon_yr %>% format( "%m%y")
p_shst_urlbase <- "https://www.usbr.gov/mp/cvo/vungvari/shafln" #0719.pdf
p_shst_url <- paste0(p_shst_urlbase, p_shst_mon_yr_mmyy, ".pdf")
p_rawtext  <- pdf_text(p_shst_url)
p_shst_mon  <- p_shst_mon_yr  %>%  format( "%m")
p_shst_yr   <- p_shst_mon_yr  %>%  format( "%y")

### scrape current report ###
start1 <- "\n  1 "  #trinity tables can start with either
start2 <- "\n   1 " #trinity tables can start with either
start3 <- "\n    1 "
start4 <- "\n     1 "

end1 <- "\n  TOTALS"
end2 <- "\n TOTALS"       

c_shst_fnf <- cliptrintable2(c_rawtext, start1, end)  
c_shst_fnf
if (is.na(c_shst_fnf)) {c_shst_fnf <- cliptrintable2(c_rawtext, start2, end1) }
c_shst_fnf
if (is.na(c_shst_fnf)) {c_shst_fnf <- cliptrintable2(c_rawtext, start3, end1) }
c_shst_fnf
if (is.na(c_shst_fnf)) {c_shst_fnf <- cliptrintable2(c_rawtext, start4, end1) }
c_shst_fnf
if (is.na(c_shst_fnf)) {c_shst_fnf <- cliptrintable2(c_rawtext, start1, end2) }
c_shst_fnf
if (is.na(c_shst_fnf)) {c_shst_fnf <- cliptrintable2(c_rawtext, start2, end2) }
c_shst_fnf
if (is.na(c_shst_fnf)) {c_shst_fnf <- cliptrintable2(c_rawtext, start3, end2) }
c_shst_fnf
if (is.na(c_shst_fnf)) {c_shst_fnf <- cliptrintable2(c_rawtext, start4, end2) }
c_shst_fnf

rm(c_rawtext)
#}

{
# rename current report columns #
  c_shst_fnf  <- c_shst_fnf %>% rename("monthday" = !!names(.[1]),
                                                             "Britton" = !!names(.[2]),
                                                             "McCloudDivRes" = !!names(.[3]),
                                                             "IronCanyon" = !!names(.[4]),
                                                             "Pit6" = !!names(.[5]),
                                                             "Pit7" = !!names(.[6]) ,
                                                             "Shasta_upstream_stor" = !!names(.[7]),
                                                             "Shasta_upstream_dlystorchange" = !!names(.[8]),
                                                             "Shasta_observedinflowchange_meandaily" = !!names(.[9]),
                                                             "Shasta_observedinflow_meandaily" = !!names(.[10]),
                                                             "Shasta_natriver_fnf" = !!names(.[11]),
                                                             "Shasta_natriver_WYaccum" = !!names(.[12]))
  
c_shst_fnf <- c_shst_fnf %>% transmute(monthday, Shasta_natriver_fnf)
  
  }
head(c_shst_fnf)

c_shst_fnf <- c_shst_fnf %>% mutate(date = paste0(c_shst_mon,"/", monthday,"/", c_shst_yr)) %>%
                           transmute(chps_date = mdy(date) + 1, shst_fnf = Shasta_natriver_fnf) 
head(c_shst_fnf)

### scrape previous report ###
#end1 <- "\n TOTALS" #one less space than above
p_shst_fnf <- cliptrintable2(p_rawtext, start1, end1)  
p_shst_fnf
if (is.na(p_shst_fnf)) {p_shst_fnf <- cliptrintable2(p_rawtext, start2, end1) }
p_shst_fnf
if (is.na(p_shst_fnf)) {p_shst_fnf <- cliptrintable2(p_rawtext, start3, end1) }
p_shst_fnf
if (is.na(p_shst_fnf)) {p_shst_fnf <- cliptrintable2(p_rawtext, start4, end1) }
p_shst_fnf
if (is.na(p_shst_fnf)) {p_shst_fnf <- cliptrintable2(p_rawtext, start1, end2) }
c_shst_fnf
if (is.na(p_shst_fnf)) {p_shst_fnf <- cliptrintable2(p_rawtext, start2, end2) }
c_shst_fnf
if (is.na(p_shst_fnf)) {p_shst_fnf <- cliptrintable2(p_rawtext, start3, end2) }
c_shst_fnf
if (is.na(p_shst_fnf)) {p_shst_fnf <- cliptrintable2(p_rawtext, start4, end2) }
c_shst_fnf

{

# rename previous report columns #
  p_shst_fnf  <- p_shst_fnf %>% rename("monthday" = !!names(.[1]),
                                       "Britton" = !!names(.[2]),
                                       "McCloudDivRes" = !!names(.[3]),
                                       "IronCanyon" = !!names(.[4]),
                                       "Pit6" = !!names(.[5]),
                                       "Pit7" = !!names(.[6]) ,
                                       "Shasta_upstream_stor" = !!names(.[7]),
                                       "Shasta_upstream_dlystorchange" = !!names(.[8]),
                                       "Shasta_observedinflowchange_meandaily" = !!names(.[9]),
                                       "Shasta_observedinflow_meandaily" = !!names(.[10]),
                                       "Shasta_natriver_fnf" = !!names(.[11]),
                                       "Shasta_natriver_WYaccum" = !!names(.[12]))
  
  p_shst_fnf <- p_shst_fnf %>% transmute(monthday, Shasta_natriver_fnf)
  
}
head(p_shst_fnf)

p_shst_fnf <- p_shst_fnf %>% mutate(date = paste0(p_shst_mon,"/", monthday,"/", p_shst_yr)) %>%
  transmute(chps_date = mdy(date) + 1, shst_fnf = Shasta_natriver_fnf) 
head(p_shst_fnf)

shst_fnf <- rbind(c_shst_fnf, p_shst_fnf) %>% arrange(desc(chps_date))
shst_fnf <- head(shst_fnf, daysback)
shst_fnf
shst_fnf$shst_fnf <- gsub(",", "", shst_fnf$shst_fnf)
shst_fnf <- shst_fnf %>% mutate(shst_fnf = as.integer(shst_fnf))
rm(list=setdiff(ls(), keepers))
#}
