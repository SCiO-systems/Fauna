## What it is? :This function bias correct CMIP6 model precipitation using (Navarro et al. 2020).
## Purpose: It correct bias for each variable (var, tmin and srad)
## Input: For each variable inputs are:
##        observed daily data, past and future model monthly average
## It has following steps:
## 1. Open Input data and coincide the spatial domain of both model and obs.
## 2. Set threhold and calculate change (delta)
### 3. change model dim to obs dim
### 4. Now make mon average to daily by repeating same values within that month.
### 5. multiply delta (change) with obs daily values using Navarro et al. (2020)
#########################################################################
## Part 1: Load Input data
rm(list=ls())
library(ncdf4)
library(dplyr)
## Input directory
dir<-'//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/'

## 1.1. Obs
file<-nc_open(paste0(dir,'observed_baseline/chirps/nc/proc/chirps-v2.0.1991_2010.days_p05.ugan.nc')) 
obs<-ncvar_get(file, 'precip')
obs<-ifelse(obs==-9999,NA,obs)
obs_lt<-ncvar_get(file, 'latitude')
obs_ln<-ncvar_get(file, 'longitude')    

## 1.2. Model future. since Uganda has smaller area, coarser resolution models like CanESM5
## has only 2 points and thus avoided. 
mod<-c('BCC-CSM2-MR','EC-Earth3-Veg','GFDL-ESM4','IPSL-CM6A-LR','MIROC6','MRI-ESM2-0')
ti<-c('2030','2050')
inp<-c('2030','2060')
prd<-c('202101-204012', '204101-206012')
sc<-c("126","245","370","585")

## Loops for each variables
for (n in 1:6){ ## models
  for (k in 1:2){ ## 2030 or 2060?
    for (j in 1:4){ ## scenario
      ## future
      ## 2. raw mean
      ## since the script starts with canESM5 deduct 1 from each n
      var_f<-nc_open(paste0(dir,'cc_raw/regrid/future/Uganda/',inp[k],'/monmean/pr_Amon_',mod[n],'_ssp',sc[j],'_',
                            'r1i1p1f1_monmean_Ugan_',prd[k],'.nc'))
      
      ###########################  
      var_f1<-ncvar_get(var_f,"pr")*86400 ## convert kg/m2/s to mm/day 
      mod_lt<-ncvar_get(var_f,"lat")
      mod_ln<-ncvar_get(var_f, "lon")
      
      if (n==1 | n == 3 | n ==6){
        var_obs2<-obs[4:179,33:183, ]
      } else if (n==4){
        var_obs2<-obs[4:154,33:183, ]
      } else if(n==5){
        var_obs2<-obs[24:174,23:173, ]
      } else {         ## 2 and 5
        var_obs2<-obs[9:174,38:188, ]
      }
      
      ln1<-which.min(abs(mod_ln - 27.625))
      ln2<-which.min(abs(mod_ln - 36.375))
      lt1<-which.min(abs(mod_lt - -2.375))
      lt2<-which.min(abs(mod_lt - 5.125))
      
      var_f2<-var_f1[ln1:ln2,lt1:lt2, ] #to make lon consistent with the model
      rm(var_f1)
      
      ## History
      ## 1.3. Model historical
      var_h<-nc_open(paste0(dir,'cc_raw/regrid/historical/Uganda/monmean/',"pr",'_Amon_',mod[n],'_historical_r1i1p1f1_Ugan_monmean_199101-201012.nc'))
      var_h1<-ncvar_get(var_h, "pr")*86400
      
      var_h2<-var_h1[ln1:ln2,lt1:lt2, ] #to make lon consistent with the model
      rm(var_h1)
      
      ##########################
      ### part 2: Set threhold and calculate change (delta)
      ## for each month extract the marginal change in precip (change/pres)         
      ## set precip less than 0.1 ==0 in both present and future climate
      var_f2[var_f2<0.1]=0
      var_h2[var_h2<0.1]=0
      
      change<-array(numeric(),dim=c(length(ln1:ln2),length(lt1:lt2),12))
      dim2<-dim(var_h2)
      
      for (a in 1:dim2[1]){
        for(b in 1:dim2[2]) {
          for (c in 1:dim2[3]){
            if(var_h2[a,b,c] == 0){
              change[a,b,c]=0
            } else {
              change[a,b,c]<-(var_f2[a,b,c]-var_h2[a,b,c])/var_h2[a,b,c]
            }
          }
        }
      }
      
      
      ## part 3: change model dim to obs dim
      source('//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/functions_bc/fit_new_dim.R')
      change1<-fit_new_dim(mod=change, obs=var_obs2[ , ,1])
      rm(change)      
      
      ## part 4. Now make mon average to daily by repeating same values within that month. 
      source('//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/functions_bc/mon_to_day1.R')
      change2<-mon_to_day1(var=change1,var_obs=var_obs2)
      rm(change1)
      
      ## part 5: multiply change with each daily values using Navarro et al. (2020)
      bc_prec<-array(numeric(), dim=dim(var_obs2))
      dimn<-dim(var_obs2)
      for (i in 1:dimn[3]){ ## from 1981 to 2010 daily
        bc_prec[ , ,i]<-var_obs2[ , ,i]*(1+change2[ , ,i]) 
      }
      ## save file
      ## save file
      ## directory create
      dir.create(file.path(paste0(dir,'cc_bc/Uganda/',ti[k]), showWarnings = FALSE))
      
      saveRDS(bc_prec, paste0(dir,'cc_bc/Uganda/',ti[k],'/pr_Amon_',mod[n],'_ssp',sc[j],'_',
                              'r1i1p1f1_Ugan_bc_',prd[k],'.RDS'))
      rm(bc_prec)
    }
  }
}


q(save="no")