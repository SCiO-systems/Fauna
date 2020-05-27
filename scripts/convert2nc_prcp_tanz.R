rm(list=ls())
library(ncdf4)
library(easyNCDF)
dir<-'//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/'
mod<-c('BCC-CSM2-MR','EC-Earth3-Veg','GFDL-ESM4','IPSL-CM6A-LR','MIROC6','MRI-ESM2-0')
var<-c('tasmax','tasmin','rsds')
sc<-c('126','245','370','585')
pd<-c('2030','2050')
trange<-c('202101-204012','204101-206012')

file<-nc_open(paste0(dir,'observed_baseline/chirps/nc/proc/chirps-v2.0.1991_2010.days_p05.tanz.nc'))
obs_lt<-ncvar_get(file, 'latitude')
obs_ln<-ncvar_get(file, 'longitude') 

for (p in 1:2){ ## time
  for (m in 1:6){ #model
    for (j in 1:4){ ## scenario
      vari<-readRDS(paste0(dir,'cc_bc/Tanzania/all/',pd[p],'/all_Tanz/precip/pr_Amon_',mod[m],'_ssp',sc[j],'_r1i1p1f1_Tanz_bc_all_',trange[p],'.RDS'))
      dimn<-dim(vari)
      ## save to netcdf
      metadata <- list( vari = list(units = 'mm', name = 'precip'))
      
      attr(vari, 'variables') <- metadata
      names(dim(vari))<-c('longitude', 'latitude','time')
      
      ## to make lat, lon consistent with that of model
      if(m==1 | m==3 | m==6){
        lon<-obs_ln[17:292]; lat<-obs_lt[33:308]
      } else if (m==2){
        lon<-obs_ln[22:292]; lat<-obs_lt[28:313]
      } else if (m==4){
        lon<-obs_ln[17:267]; lat<-obs_lt[33:308]
      } else {
        lon<-obs_ln[7:307]; lat<-obs_lt[43:313]
      }
      
      lon<-as.array(lon)
      lat<-as.array(lat)
      
      attr(lon, 'variables') <- list(lon = list(units = 'degrees_east'))
      names(dim(lon)) <- 'longitude'
      
      attr(lat, 'variables') <- list(lat = list(units = 'degrees_north'))
      names(dim(lat)) <- 'latitude'
      
      time<-seq(1,dimn[3],by=1)
      time<-array(as.integer(unlist(lat)), dim=c(dimn[3]))
      attr(time, 'variables') <- list(time = list(units = '"days since 1991-01-01 00:00:00"'))
      names(dim(time)) <- 'time'
      
      ArrayToNc(list(vari, lon,lat), paste0(dir,'cc_bc/Tanzania/',pd[p],'/nc/pr_Amon_',mod[m],'_ssp',sc[j],'_r1i1p1f1_Tanz_bc_',trange[p],'.nc'))
    }
  }
}

q(save='no')

