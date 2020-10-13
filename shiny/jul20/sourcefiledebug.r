rm(list = ls()) 

#{
source("libs.r")
source("cntrl.r")
source("opsfnf_cegc1_v2.r")
source("opsfnf_whsc1.r")
source("opsfnf_shdc1.r")
source("opsfnf_pftc1.r")
source("opsfnf_cmpc1.r")
source("opsfnf_ordc1.r") #cdec
source("opsfnf_nmsc1.r") #cdec
source("opsfnf_ndpc1.r") #cdec
source("opsfnf_frac1.r")


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
df <- left_join(df,  nmel_fnf)
df <- left_join(df,  nwdp_fnf)
df
df <- df %>% transmute(chps_date, cegc1 = trin_fnf, whsc1 = whi_fnf, shdc1 = shst_fnf,
                       frac1 = mill_fnf, pftc1 = pnft_fnf, cmpc1 = moke_fnf, ordc1 = ordc1_fnf,
                       nmsc1 = nmsc1_fnf, ndpc1 = ndpc1_fnf)
df
df <- df %>% mutate_if(is.factor, as.character)
df$cegc1 <- gsub(",", "", df$cegc1)
df$shdc1 <- gsub(",", "", df$shdc1)
df$frac1 <- gsub(",", "", df$frac1)
df$pftc1 <- gsub(",", "", df$pftc1)
df$cmpc1 <- gsub(",", "", df$cmpc1)
df$whsc1 <- gsub(",", "", df$whsc1)
df$ordc1 <- gsub(",", "", df$ordc1)
df$nmsc1 <- gsub(",", "", df$nmsc1)
df$ndpc1 <- gsub(",", "", df$ndpc1)

df
df <- df %>% mutate_if(is.character, as.numeric)
df <- df %>% transmute(chps_date, cegc1, whsc1, shdc1, ordc1, cmpc1, 
                       nmsc1, ndpc1, frac1, pftc1)

df
#df <- df %>% mutate(chps_date = ymd(chps_date))
#}
as_tibble(df)
