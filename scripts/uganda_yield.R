rm(list=ls())
library(Dasst)
library(s2dverification)
require(pacman)
pacman::p_load(raster, rgdal, rgeos, gtools, tidyverse)

dir<-'//dapadfs/workspace_cluster_12/AVISA/dssat_outputs/uganda/'

## model 
x1<-array(numeric(),c(20, 13431))

for (i in 1:13431){
  if(!file.exists(paste0(dir,'dssat_runs_uganda_BCC-CSM2-MR_ssp_585_2050/',i,'/Evaluate.OUT'))) {
    x1[ ,i]<-NA
  } else {
    x<-read.dssat(paste0(dir,'dssat_runs_uganda_BCC-CSM2-MR_ssp_585_2050/',i,'/Evaluate.OUT'))
    x1[ ,i]<-x[[1]][,14]
    rm(x)
  }
}

## obs
x2<-array(numeric(),c(20,13431))
for (i in 1:13431){
  if(!file.exists(paste0(dir,'agMeChrips_ugan_1991_2010/',i,'/Evaluate.OUT'))) {
    x2[ ,i]<-NA
  } else {
    x<-read.dssat(paste0(dir,'agMeChrips_ugan_1991_2010/',i,'/Evaluate.OUT'))
    x2[ ,i]<-x[[1]][,14]
    rm(x)
  }
}

mod_av<-apply(x1,c(2),mean)
mod_sd<-apply(x1,c(2),sd)

obs_av<-apply(x2,c(2),mean)
obs_sd<-apply(x2,c(2),sd)

lon<-seq(from=29.525,to=35.025,by=0.05)
lat<-seq(from=-1.525, to=4.475,by=0.05)


mod_av<-array(mod_av,c(111,121))
obs_av<-array(obs_av,c(111,121))
saveRDS(mod_av, paste0(dir,'yield_uganda_BCC-CSM2-MR_ssp_585_2050.RDS'))
saveRDS(obs_av,paste0(dir,'yield_agMeChrips_ugan_1991_2010.RDS')) 

q(save='no')