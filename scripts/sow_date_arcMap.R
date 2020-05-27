rm(list=ls())
library(raster)
library(tidyr)
library(zoo)
library(dplyr)
mps <- shapefile('C:/Users/pjha/Desktop/UGA_adm/UGA_adm1.shp')
# Selecting only Valle del Cauca ------------------------------------------
aa<-cbind(coordinates(mps), as.data.frame(mps)) %>%
  as.data.frame()

aa1<-aa[ ,c(1,2,12)] %>%
 spread(1,sow_date) #%>%
   # na.locf(,na.rm=F) #%>% 
  #na.locf(., fromLast = F)
aa1<-aa1[c(seq(58,1,-1)),]
write.csv(aa1,'//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/try2.csv')  

