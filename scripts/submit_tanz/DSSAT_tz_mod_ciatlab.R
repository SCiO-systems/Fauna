rm(list=ls())
library(DSSAT)
library(Dasst)
library(dplyr)
library(anytime)
library(lubridate)
library(stringr)
library(readr)
library(tidyr)
args <-commandArgs(TRUE)


cntry<-'tanzania'
dir<-'/home/jovyan/work/'
functions_to_run <- list.files('~/work/dssat_input/functions_tz/', full.names = T)
purrr::map(.x = functions_to_run, .f = source)

sc<-c('126','245','370','585')
year<-c('2030','2050')
period<-c('202101-204012','204101-206012')

co2<-read.csv('~/work/dssat_input/co2.csv') ## carbon dioxide for scenarios and periods
co2<- co2[,2:5] ## Remove s.n.

## Lat and lon for each model
## 1. Models
mod<-c('BCC-CSM2-MR','EC-Earth3-Veg','GFDL-ESM4','IPSL-CM6A-LR','MRI-ESM2-0')

##dimension of domain
lon<-seq(from=29.125,to=40.125,by=0.05)
lat<-seq(from=-11.975, to=-0.975,by=0.05)
len=length(lon)*length(lat)

#### Define output variables before loop starts
ET<-vector('list', len)
ET_phot<-ET; Evaluate<-ET; INFO<-ET; Mulch<-ET; OVERVIEW<-ET; PlantC<-ET; PlantGro<-ET
RunList<-ET; SoilOrg<-ET; SoilTemp<-ET
SoilWat<-ET; SoilWatBal<-ET; Summary<-ET;  Warning<-ET

k <-as.integer(args[1])
p <-as.integer(args[2])
n <-as.integer(args[3])

#for (k in 1:2){
  #for (p in 1:5){ ## model
    #for (n in 1:4){ ## scenario
      x<-readRDS(paste0('~/work/dssat_input/',cntry,'/',year[k],'/',mod[p],'_ssp',sc[n],'_r1i1p1f1_',period[k],'.RDS'))
      #x<-readRDS('~/work/dssat_input/test.RDS')
          ## condition to skip columns with NA values such as for planting date
      x <- x %>% drop_na()

      ## condition to skip when all climate is NA
      x <- x %>%
        dplyr::mutate(Verify = 1:nrow(x) %>%
                        purrr::map(.f = function(i){
                          x$climate[[i]] %>%
                            complete.cases() %>% sum()}) %>%
                        unlist())

      x <- x %>%
        dplyr::filter(Verify !=0)

      for (i in 1:length(x$Code)){
        dir.create(file.path(paste0('~/work/dssat_output/tanzania/dssat_runs_tanzania_',mod[p],'_ssp_',sc[n],'_',year[k],'/'),x$Code[i]), recursive =T, showWarnings = F)
        out_dir<-paste0('~/work/dssat_output/tanzania/dssat_runs_tanzania_',mod[p],'_ssp_',sc[n],'_',year[k],'/',x$Code[i],'/')
        setwd(out_dir)

        ## 1. weather
        make_wth(data = x$climate[[i]], lat = x$lat[[i]], out_dir = out_dir, lon = x$lon[[i]],  co2 = co2[k,n], name_xfile_climate = 'UGAND001')

        ## 2. Soil
        write_soil(x$SOIL.SOL[[i]], out_dir)

        ## copy files needed to run  
        file.copy(paste0('~/work/dssat_input/original_files_tz/BNGRO047.CUL'), out_dir)
        file.copy(paste0('~/work/dssat_input/original_files_tz/BNGRO047.SPE'), out_dir)
        file.copy(paste0('~/work/dssat_input/original_files_tz/BNGRO047.ECO'), out_dir)
		
		if(x$jday_end_avg[i] == 0) {
                 file.copy(paste0('~/work/dssat_input/original_files_tz/TANZ9105.BNX'), out_dir)
                 } else {
                 file.copy(paste0('~/work/dssat_input/original_files_tz/CCPA9105.BNX'), out_dir)
                 }

        ## change soil code in experimental file
        all_Prfl<-read_sol(paste0(out_dir,'/SOIL.SOL'))

                if (x$jday_end_avg[i] == 0) {
                file_x<-read_filex(paste0(out_dir,'/TANZ9105.BNX'))
                } else {
                file_x<-read_filex(paste0(out_dir,'/CCPA9105.BNX'))
                }

        file_x$FIELDS[1,12]=all_Prfl[1,1]
        file_x$FIELDS[1,3]='UGAND001'

        ## change cultivar
        file_x$`CULTIVARS`[1,3]='IB2013'
        file_x$`CULTIVARS`[1,4]='Calima'

        ## change the planting date according to the given value of the grid.
        ## since DSSAT takes pdate as.POIXct, i.e. in yyyy-mm-dd. convert doy to that.
        ## the origin is from weather file. -1 is needed coz the first day needs to be counted.
                ## If the grid has both first and 2nd season sow date, then 8 dates, else 4 dates.
                ## Date starts from x$jday_init_avg[i] for 1st season and from x$jday_end_avg[i] for 2nd season
                ## Date increase by a week for each 1st and 2nd season for 4 weeks.

        pl<-x$jday_init_avg[i]; pl_end<-x$jday_end_avg[i]
                sow_dates<-c(pl+3, pl+10, pl+17, pl+24, pl_end+3,pl_end+10,pl_end+17,pl_end+24)
                sow_date_1seas_only<-c(pl+3, pl+10, pl+17, pl+24)
				 if (x$jday_end_avg[i] == 0){
                 file_x$`PLANTING DETAILS`[ ,2]=as.POSIXct(as.Date(sow_date_1seas_only,origin=x$climate[[i]][1,1]))
                 } else {
                                 file_x$`PLANTING DETAILS`[ ,2]=as.POSIXct(as.Date(sow_dates,origin=x$climate[[i]][1,1]))
             }

                ## plant density
        file_x$`PLANTING DETAILS`[1,4]=15
        file_x$`PLANTING DETAILS`[1,5]=15

        ## simulation start date
        file_x$`SIMULATION CONTROLS`[1,6]=as.POSIXct(x$climate[[i]][1,1])

        ## number of years to simulate
        dimn<-dim(x$climate[[i]])
        st<-x$climate[[i]][1,2]; ed<-x$climate[[i]][dimn[1],2]
        yr<-(ed-st)+1

        file_x$`SIMULATION CONTROLS`[1,3]=yr

        ## Simulation control: Read CO2 from weather file
        file_x$`SIMULATION CONTROLS`[1,19]='W'

        ## write experimental file
                if (x$jday_end_avg[i] == 0) {
                write_filex(file_x, 'TANZ9105.BNX')
                } else {
        write_filex(file_x, 'CCPA9105.BNX')
        }
        ## Run
                if (x$jday_end_avg[i] == 0) {
                CSMbatch(crop="BEAN", name = "TANZ9105.BNX", paste0(out_dir, filename = "DSSBatch.v47"))
                } else {
        CSMbatch(crop="BEAN", name = "CCPA9105.BNX", paste0(out_dir, filename = "DSSBatch.v47"))
        }

        files_dssat(paste0(dir, 'dssat_input/Data/'), out_dir)
		
		 # print(out_dir)
        setwd(out_dir)
        system(paste0("./dscsm047 B DSSBatch.v47"), ignore.stdout = T)

                ## make .RDS file from output files
  ## 1. for data frame type of files
  rds_dir<-paste0('~/work/dssat_output/',cntry,'/dssat_runs_',cntry,'_',mod[p],'_ssp_',sc[n],'_',year[k],'/')

  ## Read
  ET[[x$Code[i]]]<-read.dssat('ET.OUT'); ET_phot[[x$Code[i]]]<-read.dssat('ETPhot.OUT'); Evaluate[[x$Code[i]]]<-read.dssat('Evaluate.OUT')
  INFO[[x$Code[i]]]<-scan('INFO.OUT', what="", sep="\n"); Mulch[[x$Code[i]]]<-read.dssat('Mulch.OUT')
  OVERVIEW[[x$Code[i]]]<-scan('OVERVIEW.OUT', what="", sep="\n"); PlantC[[x$Code[i]]]<-read.dssat('PlantC.OUT'); PlantGro[[x$Code[i]]]<-read.dssat('PlantGro.OUT')
  RunList[[x$Code[i]]]<-scan('RunList.OUT',what="", sep="\n")
  SoilOrg[[x$Code[i]]]<-read.dssat('SoilOrg.OUT'); SoilTemp[[x$Code[i]]]<-read.dssat('SoilTemp.OUT'); SoilWat[[x$Code[i]]]<-read.dssat('SoilWat.OUT')
  SoilWatBal[[x$Code[i]]]<-scan('SoilWatBal.OUT',what="", sep="\n"); Summary[[x$Code[i]]]<-read.dssat('Summary.OUT')
  Warning[[x$Code[i]]]<-scan('WARNING.OUT',what="", sep="\n")

  ## Make lists
  ## For all variables
  lis<-list(ET,ET_phot,Evaluate,INFO,Mulch,OVERVIEW,PlantC,PlantGro,RunList,SoilOrg,SoilTemp,SoilWat,SoilWatBal,Summary,Warning)

  ## make characater vector
  lis1<-c('ET','ET_phot','Evaluate','INFO','Mulch','OVERVIEW','PlantC','PlantGro','RunList','SoilOrg','SoilTemp','SoilWat','SoilWatBal','Summary','Warning')

  ## Save
  setwd(rds_dir)

  for (l in 1:length(lis)){
  saveRDS(lis[[l]],paste0(lis1[l],'_',cntry,'_',mod[p],'_ssp_',sc[n],'_',year[k],'.RDS'))
  }

  ## write last grid number to track if simulation broke in the middle
  last<-x$Code[i]
  
   write.csv(last, 'last.csv')

  ## to extract ET for 1st year: ## head(ET[[2]][[1]]); 20th year: head(ET[[2]][[20]])
  ## to extract for scanned variables such as INFO.out: INFO[[1]]

  # delete the grid directory 
  unlink(out_dir, recursive = TRUE)

      }
    #}
  #}
#}

q(save='no')