rm(list=ls())

# source of data
# http://greenhousegases.science.unimelb.edu.au/#!/ghg?mode=downloads&scenarioid=9

library(ncdf4)
dir<-'//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/ssp_CO2/remind_magpie/future/CMIP6GHGConcentrationProjections_1_2_1/'

## 126
aa<-nc_open(paste0(dir,'IMAGE-ssp126-1-2-1_gn-15x360deg_201501-250012.nc')) ## 126
aa1<-ncvar_get(aa, 'mole_fraction_of_carbon_dioxide_in_air')
aa2<-apply(aa1,c(2),mean) ## mean across lat
aa3<-aa2[75:314] ## select from Jan 2021 to 2040 Dec
aa4<-aa2[315:554] ## select from Jan 2041 to 2060 Dec
b1<-round(mean(aa3),0); b2<-round(mean(aa4),0)

## 245
aa<-nc_open(paste0(dir,'MESSAGE-GLOBIOM-ssp245-1-2-1_gn-15x360deg_201501-250012.nc'))
aa1<-ncvar_get(aa, 'mole_fraction_of_carbon_dioxide_in_air')
aa2<-apply(aa1,c(2),mean) ## mean across lat
aa3<-aa2[75:314] ## select from Jan 2021 to 2040 Dec
aa4<-aa2[315:554] ## select from Jan 2041 to 2060 Dec
c1<-round(mean(aa3),0); c2<-round(mean(aa4),0)


## 370
aa<-nc_open(paste0(dir,'AIM-ssp370-1-2-1_gn-15x360deg_201501-250012.nc')) ## 370
aa1<-ncvar_get(aa, 'mole_fraction_of_carbon_dioxide_in_air')
lat<-ncvar_get(aa,'lat_bnds')
time<-ncvar_get(aa, 'time_bnds')
aa2<-apply(aa1,c(2),mean) ## mean across lat
aa3<-aa2[75:314] ## select from Jan 2021 to 2040 Dec
aa4<-aa2[315:554] ## select from Jan 2041 to 2060 Dec
d1<-round(mean(aa3),0); d2<-round(mean(aa4),0)

## 585
aa<-nc_open(paste0(dir,'REMIND-MAGPIE-ssp585-1-2-1_gn-15x360deg_201501-250012.nc'))
aa1<-ncvar_get(aa, 'mole_fraction_of_carbon_dioxide_in_air')
aa2<-apply(aa1,c(2),mean) ## mean across lat
aa3<-aa2[75:314] ## select from Jan 2021 to 2040 Dec
aa4<-aa2[315:554] ## select from Jan 2041 to 2060 Dec
e1<-round(mean(aa3),0); e2<-round(mean(aa4),0)

co2<-rbind(c(b1,c1,d1,e1),c(b2,c2,d2,e2))
write.csv(co2,'//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/scripts/co2.csv')


