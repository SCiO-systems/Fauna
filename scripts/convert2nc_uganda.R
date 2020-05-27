rm(list=ls())
library(ncdf4)
library(easyNCDF)
dir<-'//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/'
mod<-c('BCC-CSM2-MR','EC-Earth3-Veg','GFDL-ESM4','IPSL-CM6A-LR','MIROC6','MRI-ESM2-0')
var<-c('tasmax','tasmin','rsds')
sc<-c('126','245','370','585')
pd<-c('2030','2050')
trange<-c('202101-204012','204101-206012')

var_obs<-nc_open(paste0(dir,'observed_baseline/agmerra/tmax_daily_ts_agmerra_1991_2010_ugan_inv.nc'))
obs_lt<-ncvar_get(var_obs,"latitude")
obs_ln<-ncvar_get(var_obs,"longitude")

for (p in 1:2){ ## time
  for (m in 1:6){ #model
    for (i in 1:3){ ## var
      for (j in 1:4){ ## scenario
        
        vari<-readRDS(paste0(dir,'cc_bc/Uganda/',pd[p],'/',var[i],'_Amon_',mod[m],'_ssp',sc[j],'_r1i1p1f1_Ugan_bc_',trange[p],'.RDS'))
        dimn<-dim(vari)
        ## save to netcdf
        if(i==1 | i==2){
          metadata <- list( var = list(units = '0C'))
        } else {
          metadata <- list( var = list(units = 'MJm-2'))
        }
        attr(var, 'variables') <- metadata
        names(dim(vari))<-c('longitude', 'latitude','time')
        
        ## to make lat, lon consistent with that of model
        if(m==2){
          lon<-obs_ln[2:35]; lat<-obs_lt[2:38]
        } else if(m==4){
          lon<-obs_ln[1:31]; lat<-obs_lt[2:37]
        } else if(m==5){
          lon<-obs_ln[5:35]; lat<-obs_lt[5:35]
        } else {
          lon<-obs_ln[1:36]; lat<-obs_lt[2:37]
        }
        attr(lon, 'variables') <- list(lon = list(units = 'degrees_east'))
        names(dim(lon)) <- 'longitude'
        
        attr(lat, 'variables') <- list(lat = list(units = 'degrees_north'))
        names(dim(lat)) <- 'latitude'
        
        time<-seq(1,dimn[3],by=1)
        time<-array(as.integer(unlist(lat)), dim=c(dimn[3]))
        attr(time, 'variables') <- list(time = list(units = '"days since 1991-01-01 00:00:00"'))
        names(dim(time)) <- 'time'
        
        ArrayToNc(list(vari, lon,lat), paste0(dir,'cc_bc/Uganda/',pd[p],'/nc/',var[i],'_Amon_',mod[m],'_ssp',sc[j],'_r1i1p1f1_Ugan_bc_',trange[p],'.nc'))                                
        
      }
    }
  }
}

q(save = 'no')
