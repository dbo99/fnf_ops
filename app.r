

#options(rsconnect.check.certificate = FALSE)
#{
  source("libs.r")
  source("cntrl.r")
  source("opsfnf_cegc1_v2.r")
  source("opsfnf_whsc1.r")
  source("opsfnf_shdc1.r")
  source("opsfnf_pftc1.r")
  source("opsfnf_cmpc1.r")
  source("opsfnf_ordc1.r")
  source("opsfnf_nmsc1.r")
  source("opsfnf_ndpc1.r")
  source("opsfnf_frac1.r")
#}

#today_pst <- Sys.time()
#today_pst <- attr(today_pst,"tzone") <- "GMT"
#Sys.setenv(TZ="America/Los_Angeles")
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

## debugging the data tables param 4, row 14 error
##  -------------
##  DataTables warning: table id=DataTables_Table_0 - Requested unknown parameter '4' for row 14. 
##  For more information about this error, please see http://datatables.net/tn/4
##  --------------
#df$chps_date <-  ymd(df$chps_date)
#df[2:10] <- lapply(df[2:10], as.integer)
#df <- as.data.frame(df)
#df <- df[-c(14),]

## fix - add `DT::` in two spots - 
## https://stackoverflow.com/questions/58995381/shiny-datatable-error-datatables-warning-table-id-datatables-table-0-request

shinyApp(
 # ,
 # a("bmm's pdf", target = "_blank", href = "dailyFNF.pdf")
  
  
  ui = fluidPage(
    fluidRow( column(12, DT::dataTableOutput('table'),  HTML("<a target='_blank' href = 'https://www.usbr.gov/mp/cvo/vungvari/trndop.pdf'> cegc1 </a> 
                                                          <a target='_blank' href='https://www.usbr.gov/mp/cvo/vungvari/whidop.pdf'>whsc1</a>
                                                          <a target='_blank' href='https://www.usbr.gov/mp/cvo/vungvari/shafln.pdf'>shdc1 </a>
                                                          <a target='_blank' href='https://www.usbr.gov/mp/cvo/vungvari/milfln.pdf'>frac1</a> 
                                                           <a target='_blank' href='https://www.usbr.gov/mp/cvo/current.html'>usbr_curr  </a> 
                                                          <a target='_blank' href='https://www.usbr.gov/mp/cvo/reports.html'>usbr_prev  </a> <br>
                                                          <a target='_blank' href='https://cdec.water.ca.gov/reportapp/javareports?name=FNF'>ordc1/nmsc1/ndpc1(cdec_curr)</a> 
                                                          #<a target='_blank' href='https://cdec.water.ca.gov/reportapp/javareports?name=FNF.201907'> cdec_prev  </a>  <br>
                                                         <a target='_blank' href='https://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=0&report=SC7'>cmpc1_0 </a>
                                                         <a target='_blank' href='https://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=1&report=SC7'>cmpc1_1 </a>
                                                         <a target='_blank' href='https://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=2&report=SC7'>cmpc1_2 </a>
                                                         <a target='_blank' href='https://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=3&report=SC7'>cmpc1_3  </a>
                                                        <a target='_blank' href='https://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=4&report=SC7'>cmpc1_4  </a>
                                                        <a target='_blank' href='https://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=5&report=SC7'>cmpc1_5  </a>
                                                        <a target='_blank' href='https://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=6&report=SC7'>cmpc1_6  </a> 


                                                         <a target='_blank' href='https://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=0&report=COE'>pftc1_0 </a>
                                                         <a target='_blank' href='https://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=1&report=COE'>pftc1_1 </a>
                                                         <a target='_blank' href='https://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=2&report=COE'>pftc1_2 </a>
                                                         <a target='_blank' href='https://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=3&report=COE'>pftc1_3  </a>
                                                         <a target='_blank' href='https://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=4&report=COE'>pftc1_4  </a>
                                                         <a target='_blank' href='https://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=5&report=COE'>pftc1_5  </a>
                                                         <a target='_blank' href='https://www.spk-wc.usace.army.mil/fcgi-bin/midnight.py?days=6&report=COE'>pftc1_6  </a> 


                                                        <a target='_blank' href='http://www.spk-wc.usace.army.mil/reports/midnight.html'>usace_12am  </a> 
                                                         <a target='_blank' href='http://www.spk-wc.usace.army.mil/reports/monthly.html'>usace_mon  </a> <br> 
                                                         <a target='_blank' href='dailyFNF.pdf'>bmm's pdf  </a> <br> ")
                                                                   
                                                         
                                                         
                                                        
                     
                     
                     )
            
                )
            ),
  
  
server = function(input, output) {
    output$table <- DT::renderDataTable(df,  
          options = list(searching = FALSE,
        paging = FALSE, 
      lengthChange = FALSE,
      rownames = FALSE))
  }
)
