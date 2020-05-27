## Part 1: Load Input data
rm(list=ls())
library(ncdf4)
## Input directory
dir<-'//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/'

## 1.2. Model future. since Uganda has smaller area, coarser resolution models like CanESM5
## has only 2 points and thus avoided. 
mod<-c('BCC-CSM2-MR','EC-Earth3-Veg','GFDL-ESM4','IPSL-CM6A-LR','MIROC6','MRI-ESM2-0')
ti<-c('2030','2050')
inp<-c('2030','2060')
prd<-c('202101-204012', '204101-206012')
sc<-c("126","245","370","585")

## Loops for each variables
for (n in 1:6){ ## models
  for (k in 1:2){ ## 2030 or 2050?
    for (j in 1:4){ ## scenario
      
      ### 1. obs ref
      var_obs<-nc_open(paste0(dir,'observed_baseline/agmerra/srad_daily_ts_agmerra_1991_2010_eth_inv.nc'))
      var_obs1<-ncvar_get(var_obs, 'srad')
      obs_lt<-ncvar_get(var_obs,"latitude")
      obs_ln<-ncvar_get(var_obs,"longitude")
      
      ## to make lat, lon consistent with that of model
      if(n==5){
        var_obs2<-var_obs1[6:56,8:56, ]
      } else if (n==2) {
        var_obs2<-var_obs1[3:66,5:56, ]
      } else {
        var_obs2<-var_obs1[4:64,6:56, ]
      }
      
      ## future
      ## 2. raw mean
      ## since the script starts with canESM5 deduct 1 from each n
      var_f<-nc_open(paste0(dir,'cc_raw/regrid/future/Ethiopia/',inp[k],'/monmean/rsds_Amon_',mod[n],'_ssp',sc[j],'_',
                            'r1i1p1f1_monmean_Ethi_',prd[k],'.nc'))
      
      #############################  
      var_f1<-ncvar_get(var_f,'rsds')*0.0864 ## convert w/m2 to MJ/m2/day
      mod_lt<-ncvar_get(var_f,"lat")
      mod_ln<-ncvar_get(var_f, "lon")
      
      ln1<-which.min(abs(mod_ln - 32.625))
      ln2<-which.min(abs(mod_ln - 48))
      lt1<-which.min(abs(mod_lt - 2.625))
      lt2<-which.min(abs(mod_lt - 15.125))
      
      var_f2<-var_f1[ln1:ln2,lt1:lt2, ] #to make lon consistent with the model
      
      ## History
      ## 4. historical mean
      var_h<-nc_open(paste0(dir,'cc_raw/regrid/historical/Ethiopia/monmean/rsds_Amon_',mod[n],'_historical_r1i1p1f1_Ethi_monmean_199101-201012.nc'))
      var_h1<-ncvar_get(var_h, 'rsds')*0.0864
      var_h2<-var_h1[ln1:ln2,lt1:lt2, ] #to make lon consistent with the model
      rm(var_h1)
      
      ##########################
      ### part 2: Set threhold and calculate change (delta)
      ## for each month extract the marginal change in srad (change/pres)         
      ## set srad less than 0.1 ==0 in both present and future climate
      var_f2[var_f2<=0]=1
      var_h2[var_h2<=0]=1
      
      change<-array(numeric(),dim=c(length(ln1:ln2),length(lt1:lt2),12))
      
      for (i in 1:12){
        change[ , ,i]<-(var_f2[ , ,i]-var_h2[ , ,i])/var_h2[ , ,i]
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
      bc_rad<-array(numeric(), dim=dim(var_obs2))
      dimn<-dim(var_obs2)
      for (i in 1:dimn[3]){ ## from 1991 to 2010 daily
        bc_rad[ , ,i]<-var_obs2[ , ,i]*(1+change2[ , ,i]) 
      }      
      
      ## save file
      ## directory create
      dir.create(file.path(paste0(dir,'cc_bc/Ethiopia/'),ti[k]), showWarnings = FALSE)
      
      saveRDS(bc_rad, paste0(dir,'cc_bc/Ethiopia/',ti[k],'/rsds_Amon_',mod[n],'_ssp',sc[j],'_',
                             'r1i1p1f1_Ethi_bc_',prd[k],'.RDS'))
      rm(bc_rad)      
    }
  }
}
q(save="no")   
