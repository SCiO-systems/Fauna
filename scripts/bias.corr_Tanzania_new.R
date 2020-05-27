## What it is? :This function bias correct CMIP6 model data using change factor approch (Hawkins et al. 2013).
## Purpose: It correct bias for each variable (var, tmin and srad)
## Input: For each variable inputs are:
##        observed daily data, past and future model monthly average and stdev.

## It has following steps:
## 1. Open Input data and coincide the spatial domain of both model and obs.
## 2. Regrid model data so that model and obs has same spatial resolution.
### 3. Make the monthly model data to daily since obs are daily. 
### 4. Bias correction
#########################################################################
## Part 1: Input data
rm(list=ls())
library(ncdf4)

## Input directory
dir<-'//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/'

## Input variables
mod<-c('BCC-CSM2-MR','EC-Earth3-Veg','GFDL-ESM4','IPSL-CM6A-LR','MIROC6','MRI-ESM2-0')

ti<-c('2030','2050')
inp<-c('2030','2060')
prd<-c('202101-204012', '204101-206012')
sc<-c("126","245","370","585")
var<-c('tasmax','tasmin')
var1<-c('tmax','tmin')

## Loops for each variables

for (n in 1:6){ ## models
  for (k in 1:2){ ## 2030 or 2060?
    for (j in 1:4){ ## scenario
      for (i in 1:2){ ### variables tmx, tmin and srad 
        
        ### 1. obs ref
        var_obs<-nc_open(paste0(dir,'observed_baseline/agmerra/',var1[i],'_daily_ts_agmerra_1991_2010_tanz_inv.nc'))
        var_obs1<-ncvar_get(var_obs, var1[i])
        obs_lt<-ncvar_get(var_obs,"latitude")
        obs_ln<-ncvar_get(var_obs,"longitude")
        
        ## to make lat, lon consistent with that of model
        if(n==2){
          var_obs2<-var_obs1[5:59,6:63, ]
        } else if(n==4){
          var_obs2<-var_obs1[4:54,7:62, ]
        } else if(n==5){
          var_obs2<-var_obs1[2:62,9:63, ]
        } else {
          var_obs2<-var_obs1[4:59,7:62, ] 
        }
        
        ## future
        ## 2. raw mean
        var_f<-nc_open(paste0(dir,'cc_raw/regrid/future/Tanzania/',inp[k],'/monmean/',var[i],'_Amon_',mod[n],'_ssp',sc[j],'_','r1i1p1f1_monmean_Tanz_',prd[k],'.nc'))
        var_f1<-ncvar_get(var_f,var[i])-273 ## convert kelvin to 0C.                     
        
        mod_lt<-ncvar_get(var_f,"lat")
        mod_ln<-ncvar_get(var_f, "lon")
        
        ln1<-which.min(abs(mod_ln - 27.625))
        ln2<-which.min(abs(mod_ln - 41.375))
        lt1<-which.min(abs(mod_lt - -12.375))
        lt2<-which.min(abs(mod_lt - 1.375))
        
        var_f2<-var_f1[ln1:ln2,lt1:lt2, ] #to make lon consistent with the model
        
        ## 3. std raw
        var_std_f<-nc_open(paste0(dir, 'cc_raw/regrid/future/Tanzania/',inp[k],'/monstd/',var[i],'_Amon_',mod[n],'_ssp',sc[j],'_r1i1p1f1_monstd_Tanz_',prd[k],'.nc'))
        var_std_f1<-ncvar_get(var_std_f, var[i])
        var_std_f2<-var_std_f1[ln1:ln2,lt1:lt2, ] #to make lon consistent with the model
        
        ## History
        ## 4. historical mean
        var_h<-nc_open(paste0(dir,'cc_raw/regrid/historical/Tanzania/monmean/',var[i],'_Amon_',mod[n],'_historical_r1i1p1f1_Tanz_monmean_199101-201012.nc'))
        var_h1<-ncvar_get(var_h, var[i])-273
        var_h2<-var_h1[ln1:ln2,lt1:lt2, ] #to make lon consistent with the model
        
        ## 5. std histo
        var_std_h<-nc_open(paste0(dir,'cc_raw/regrid/historical/Tanzania/monstd/',var[i],'_Amon_',mod[n],'_historical_r1i1p1f1_Tanz_monstd_199101-201012.nc'))
        var_std_h1<-ncvar_get(var_std_h, var[i])
        var_std_h2<-var_std_h1[ln1:ln2,lt1:lt2, ] #to make lon consistent with the model
        
        ##########################
        ### part 2: Bias corrct using built functions
        source(paste0(dir,'cc_raw/functions_bc/bias_cor_CF_main.R'))
        
        bias_cor_var<-bias_cor_CF_main(var_fut_av=var_f2, var_fut_std=var_std_f2, var_hist_av=var_h2, 
                                       var_hist_std=var_std_h2, var_obs=var_obs2)
        ## save file
        ## directory create
        dir.create(file.path(paste0(dir,'cc_bc/Tanzania/'),ti[k]), showWarnings = FALSE)
        
        saveRDS(bias_cor_var, paste0(dir,'cc_bc/Tanzania/',ti[k],'/',var[i],'_Amon_',mod[n],'_ssp',sc[j],'_',
                                     'r1i1p1f1_Tanz_bc_',prd[k],'.RDS'))
      }
    }
  }
}

q(save="no")