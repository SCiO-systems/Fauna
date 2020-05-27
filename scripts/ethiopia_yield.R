rm(list=ls())
library(Dasst)
dir<-'//dapadfs/workspace_cluster_12/AVISA/dssat_outputs/ethiopia/'

## obs 
grids<-39106:40401
x1<-array(numeric(),c(20, length(grids)))

for (i in 1:length(grids)){
  if(!file.exists(paste0(dir,'agMeChrips_ethi_lat4.6_8.9_1991_2010_last/',grids[i],'/Evaluate.OUT'))) {
    x1[ ,i]<-NA
  } else {
    x<-read.dssat(paste0(dir,'agMeChrips_ethi_lat4.6_8.9_1991_2010_last/',grids[i],'/Evaluate.OUT'))
    x1[ ,i]<-x[[1]][,14]
    rm(x)
  }
}

mod1_av<-apply(x1,c(2),mean)
saveRDS(mod1_av, paste0(dir,'yield_ethiopia_39106_40401_agMeChrips.RDS'))

## model1
grids<-22031:29999
x1<-array(numeric(),c(20, length(grids)))

for (i in 1:length(grids)){
  if(!file.exists(paste0(dir,'dssat_runs_ethiopia_BCC-CSM2-MR_ssp_585_2050_2230/',grids[i],'/Evaluate.OUT'))) {
    x1[ ,i]<-NA
  } else {
    x<-read.dssat(paste0(dir,'dssat_runs_ethiopia_BCC-CSM2-MR_ssp_585_2050_2230/',grids[i],'/Evaluate.OUT'))
    x1[ ,i]<-x[[1]][,14]
    rm(x)
  }
}

mod1_av<-apply(x1,c(2),mean)
saveRDS(mod1_av, paste0(dir,'yield_ethiopia_22031_29999_BCC_CSM2.RDS'))

## model2
grids<-32139:40401
x1<-array(numeric(),c(20, length(grids)))

for (i in 1:length(grids)){
  if(!file.exists(paste0(dir,'dssat_runs_ethiopia_BCC-CSM2-MR_ssp_585_2050_last/',grids[i],'/Evaluate.OUT'))) {
    x1[ ,i]<-NA
  } else {
    x<-read.dssat(paste0(dir,'dssat_runs_ethiopia_BCC-CSM2-MR_ssp_585_2050_last/',grids[i],'/Evaluate.OUT'))
    x1[ ,i]<-x[[1]][,14]
    rm(x)
  }
}

mod1_av<-apply(x1,c(2),mean)
saveRDS(mod1_av, paste0(dir,'yield_ethiopia_32139_40401_BCC_CSM2.RDS'))

q(save='no')

