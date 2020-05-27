## combine obs (prec, tmx, tmin and rsds).
## prec is from chirps and other variables are from AgMeera.
## Part 1: Load Input data
library(ncdf4)
library(abind)
library(dplyr)
## Input directory
dir<-'//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/'

## 1.1. precip
file<-nc_open(paste0(dir,'observed_baseline/chirps/nc/proc/chirps-v2.0.1991_2010.days_p05.ethi.nc')) 
obs<-ncvar_get(file, 'precip') 
obs<-obs[3:363,3:278, ]
dimns<-dim(obs)
obs<-ifelse(obs==-9999,NA,obs) 
obs_lt<-ncvar_get(file, 'latitude')
obs_ln<-ncvar_get(file, 'longitude') 


## 1.2 other variables
var1<-c('tmax','tmin','srad')

## Load other variables and change dim to that of prec
source('//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/functions_bc/fit_new_dim1.R')
others<-array(numeric(),c(dimns[1],dimns[2],dimns[3],3))

for (i in 1:3){
  var_obs<-nc_open(paste0(dir,'observed_baseline/agmerra/',var1[i],'_daily_ts_agmerra_1991_2010_eth_inv.nc'))
  var_obs1<-ncvar_get(var_obs, var1[i])
  others_lt<-ncvar_get(var_obs,"latitude")
  others_ln<-ncvar_get(var_obs,"longitude")
  others[ , , ,i]<-fit_new_dim1(mod=var_obs1, obs=obs)
}

## part 2: Combine preci and other variables
all<-abind(obs,others,along=4)
saveRDS(all,paste0(dir,'cc_bc/Ethiopia/obs/pr_tmx_tmin_rad_ethi_1991_2010.RDS'))
q(save='no')                

