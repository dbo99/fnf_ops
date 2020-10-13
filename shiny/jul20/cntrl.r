keepers <- c("mill_fnf", "trin_fnf", "whis_fnf", "shst_fnf", 
             "pnft_fnf", "moke_fnf", "orov_fnf", "nmel_fnf", 
             "nwdp_fnf",   "keepers", "daysback", "df", "c_trin_url", "cliptrintable", "cliptrintable2")
#rm(list=setdiff(ls(), keepers))


daysback <- 14
cliptrintable <- function(rawtext, start, end) {
  read.table(text = substring(rawtext, regexpr(start, rawtext), 
                              regexpr(end, rawtext))) }

cliptrintable2 <- possibly(cliptrintable, otherwise = NA)