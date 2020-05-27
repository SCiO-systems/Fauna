rm(list=ls())
library(ncdf4)
library(abind)
library(s2dverification)
dir_raw<-'//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/Tanzania/'#2030/'
dir_bc<-'//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_bc/Tanzania/'#2030/nc/mnmean/'

mod<-c('BCC-CSM2-MR','EC-Earth3-Veg','GFDL-ESM4','IPSL-CM6A-LR','MIROC6','MRI-ESM2-0')
var<-c('tasmax','tasmin','rsds')
sc1<-c('ssp126','ssp245','ssp370','ssp585')
pd<-c('202101-204012','204101-206012')
tim<-c('2030','2050')
tim1<-c('2030','2060')

for (k in 1:2){ ## periods
for (j in 1:4){ ## scenarios
  var_raw1<-nc_open(paste0(dir_raw,tim1[k],'/pr_Amon_',mod[1],'_',sc1[j],'_r1i1p1f1_monmean_Tanz_',pd[k],'.nc'))
  var_raw2<-nc_open(paste0(dir_raw,tim1[k],'/pr_Amon_',mod[2],'_',sc1[j],'_r1i1p1f1_monmean_Tanz_',pd[k],'.nc'))
  var_raw3<-nc_open(paste0(dir_raw,tim1[k],'/pr_Amon_',mod[3],'_',sc1[j],'_r1i1p1f1_monmean_Tanz_',pd[k],'.nc'))
  var_raw4<-nc_open(paste0(dir_raw,tim1[k],'/pr_Amon_',mod[4],'_',sc1[j],'_r1i1p1f1_monmean_Tanz_',pd[k],'.nc'))
  var_raw5<-nc_open(paste0(dir_raw,tim1[k],'/pr_Amon_',mod[5],'_',sc1[j],'_r1i1p1f1_monmean_Tanz_',pd[k],'.nc'))
  var_raw6<-nc_open(paste0(dir_raw,tim1[k],'/pr_Amon_',mod[6],'_',sc1[j],'_r1i1p1f1_monmean_Tanz_',pd[k],'.nc'))
  
  lt1<-ncvar_get(var_raw1,'lat')
  ln1<-ncvar_get(var_raw1,'lon')
  
  lt2<-ncvar_get(var_raw2,'lat')
  ln2<-ncvar_get(var_raw2,'lon')
  
  lt3<-ncvar_get(var_raw3,'lat')
  ln3<-ncvar_get(var_raw3,'lon')
  
  lt4<-ncvar_get(var_raw4,'lat')
  ln4<-ncvar_get(var_raw4,'lon')
  
  lt5<-ncvar_get(var_raw5,'lat')
  ln5<-ncvar_get(var_raw5,'lon')
  
  lt6<-ncvar_get(var_raw6,'lat')
  ln6<-ncvar_get(var_raw6,'lon')
  
  var_raw1<-ncvar_get(var_raw1,'pr')*86400
  var_raw1<-var_raw1[1:10,2:10,]
  var_raw2<-ncvar_get(var_raw2,'pr')*86400
  var_raw2<-var_raw2[2:17,3:17, ]
  var_raw3<-ncvar_get(var_raw3,'pr')*86400
  var_raw3<-var_raw3[1:10,2:10,]
  var_raw4<-ncvar_get(var_raw4,'pr')*86400
  var_raw4<-var_raw4[,2:10, ]
  var_raw5<-ncvar_get(var_raw5,'pr')*86400
  var_raw5<-var_raw5[2:8,2:8,]
  var_raw6<-ncvar_get(var_raw6,'pr')*86400
  var_raw6<-var_raw6[1:10,2:10, ]
  
  if (k==1){
  var_bc1<-nc_open(paste0(dir_bc,tim[k],'/nc/mnmean/pr_Amon_',mod[1],'_',sc1[j],'_r1i1p1f1_Tanz_bc_',pd[k],'.mnmean.nc'))
  var_bc2<-nc_open(paste0(dir_bc,tim[k],'/nc/mnmean/pr_Amon_',mod[2],'_',sc1[j],'_r1i1p1f1_Tanz_bc_',pd[k],'.mnmean.nc'))
  var_bc3<-nc_open(paste0(dir_bc,tim[k],'/nc/mnmean/pr_Amon_',mod[3],'_',sc1[j],'_r1i1p1f1_Tanz_bc_',pd[k],'.mnmean.nc'))
  var_bc4<-nc_open(paste0(dir_bc,tim[k],'/nc/mnmean/pr_Amon_',mod[4],'_',sc1[j],'_r1i1p1f1_Tanz_bc_',pd[k],'.mnmean.nc'))
  var_bc5<-nc_open(paste0(dir_bc,tim[k],'/nc/mnmean/pr_Amon_',mod[5],'_',sc1[j],'_r1i1p1f1_Tanz_bc_',pd[k],'.mnmean.nc'))
  var_bc6<-nc_open(paste0(dir_bc,tim[k],'/nc/mnmean/pr_Amon_',mod[6],'_',sc1[j],'_r1i1p1f1_Tanz_bc_',pd[k],'.mnmean.nc'))
  } else {
  var_bc1<-nc_open(paste0(dir_bc,tim[k],'/nc/mnmean/aa/pr_Amon_',mod[1],'_',sc1[j],'_r1i1p1f1_Tanz_bc_',pd[k],'.mnmean.nc'))
  var_bc2<-nc_open(paste0(dir_bc,tim[k],'/nc/mnmean/aa/pr_Amon_',mod[2],'_',sc1[j],'_r1i1p1f1_Tanz_bc_',pd[k],'.mnmean.nc'))
  var_bc3<-nc_open(paste0(dir_bc,tim[k],'/nc/mnmean/aa/pr_Amon_',mod[3],'_',sc1[j],'_r1i1p1f1_Tanz_bc_',pd[k],'.mnmean.nc'))
  var_bc4<-nc_open(paste0(dir_bc,tim[k],'/nc/mnmean/aa/pr_Amon_',mod[4],'_',sc1[j],'_r1i1p1f1_Tanz_bc_',pd[k],'.mnmean.nc'))
  var_bc5<-nc_open(paste0(dir_bc,tim[k],'/nc/mnmean/aa/pr_Amon_',mod[5],'_',sc1[j],'_r1i1p1f1_Tanz_bc_',pd[k],'.mnmean.nc'))
  var_bc6<-nc_open(paste0(dir_bc,tim[k],'/nc/mnmean/aa/pr_Amon_',mod[6],'_',sc1[j],'_r1i1p1f1_Tanz_bc_',pd[k],'.mnmean.nc'))
  }
  
  lat1<-ncvar_get(var_bc1,'lat')
  lon1<-ncvar_get(var_bc1,'lon')
  
  lat2<-ncvar_get(var_bc2,'lat')
  lon2<-ncvar_get(var_bc2,'lon')
  
  lat3<-ncvar_get(var_bc3,'lat')
  lon3<-ncvar_get(var_bc3,'lon')
  
  lat4<-ncvar_get(var_bc4,'lat')
  lon4<-ncvar_get(var_bc4,'lon')
  
  lat5<-ncvar_get(var_bc5,'lat')
  lon5<-ncvar_get(var_bc5,'lon')
  
  lat6<-ncvar_get(var_bc6,'lat')
  lon6<-ncvar_get(var_bc6,'lon')
  
  var_bc1<-ncvar_get(var_bc1,'precip')
  var_bc2<-ncvar_get(var_bc2,'precip')
  
  var_bc3<-ncvar_get(var_bc3,'precip')
  
  var_bc4<-ncvar_get(var_bc4,'precip')
  
  var_bc5<-ncvar_get(var_bc5,'precip')
  
  var_bc6<-ncvar_get(var_bc6,'precip')
  
  dim1<-dim(var_bc1)
  var_bc1<-array(var_bc1,c(dim1[1],dim1[2],12,31))
  var_bc1_av<-apply(var_bc1,c(1,2,3),mean)
  
  dim1<-dim(var_bc2)
  var_bc2<-array(var_bc2,c(dim1[1],dim1[2],12,31))
  var_bc2_av<-apply(var_bc2,c(1,2,3),mean)
  
  dim1<-dim(var_bc3)
  var_bc3<-array(var_bc3,c(dim1[1],dim1[2],12,31))
  var_bc3_av<-apply(var_bc3,c(1,2,3),mean)
  
  dim1<-dim(var_bc4)
  var_bc4<-array(var_bc4,c(dim1[1],dim1[2],12,31))
  var_bc4_av<-apply(var_bc4,c(1,2,3),mean)
  
  dim1<-dim(var_bc5)
  var_bc5<-array(var_bc5,c(dim1[1],dim1[2],12,31))
  var_bc5_av<-apply(var_bc5,c(1,2,3),mean)
  
  dim1<-dim(var_bc6)
  var_bc6<-array(var_bc6,c(dim1[1],dim1[2],12,31))
  var_bc6_av<-apply(var_bc6,c(1,2,3),mean)
  
  source('//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/functions_bc/fit_new_dim.R')
  var_raw1_new<-fit_new_dim(mod=var_raw1,obs=var_bc1_av[ , ,1])
  var_raw2_new<-fit_new_dim(mod=var_raw2,obs=var_bc2_av[ , ,1])
  var_raw3_new<-fit_new_dim(mod=var_raw3,obs=var_bc3_av[ , ,1])
  var_raw4_new<-fit_new_dim(mod=var_raw4,obs=var_bc4_av[ , ,1])
  var_raw5_new<-fit_new_dim(mod=var_raw5,obs=var_bc5_av[ , ,1])
  var_raw6_new<-fit_new_dim(mod=var_raw6,obs=var_bc6_av[ , ,1])
  
  ## average annual
  var_raw1_an<-apply(var_raw1_new,c(1,2),mean)
  var_bc1_an<-apply(var_bc1_av,c(1,2),mean)
  
  var_raw2_an<-apply(var_raw2_new,c(1,2),mean)
  var_bc2_an<-apply(var_bc2_av,c(1,2),mean)
  
  var_raw3_an<-apply(var_raw3_new,c(1,2),mean)
  var_bc3_an<-apply(var_bc3_av,c(1,2),mean)
  
  var_raw4_an<-apply(var_raw4_new,c(1,2),mean)
  var_bc4_an<-apply(var_bc4_av,c(1,2),mean)
  
  var_raw5_an<-apply(var_raw5_new,c(1,2),mean)
  var_bc5_an<-apply(var_bc5_av,c(1,2),mean)
  
  var_raw6_an<-apply(var_raw6_new,c(1,2),mean)
  var_bc6_an<-apply(var_bc6_av,c(1,2),mean)
  
  ## to make lat/lon same for every model## select lat (-2.875:4.625) ,lon=30.125:34.625
  var_raw1_an<-var_raw1_an[26:206,16:196]
  var_bc1_an<-var_bc1_an[26:206,16:196]
  ch1_an<-var_bc1_an-var_raw1_an
  
  var_raw2_an<-var_raw2_an[16:196,16:196]
  var_bc2_an<-var_bc2_an[16:196,16:196]  
  ch2_an<-var_bc2_an-var_raw2_an
  
  var_raw3_an<-var_raw3_an[26:206,16:196]
  var_bc3_an<-var_bc3_an[26:206,16:196]
  ch3_an<- var_bc3_an-var_raw3_an
  
  var_raw4_an<-var_raw4_an[1:181,16:196]
  var_bc4_an<-var_bc4_an[1:181,16:196]
  ch4_an<-var_bc4_an-var_raw4_an
  
  var_raw5_an<-var_raw5_an[1:181,1:181]
  var_bc5_an<-var_bc5_an[1:181,1:181]
  ch5_an<-var_bc5_an-var_raw5_an
  
  var_raw6_an<-var_raw6_an[26:206,16:196]
  var_bc6_an<-var_bc6_an[26:206,16:196]
  ch6_an<-var_bc6_an-var_raw6_an
  
  #var_mod_all<-abind(var_raw1_an,var_bc1_an,var_raw2_an,var_bc2_an,var_raw3_an,var_bc3_an,var_raw4_an,var_bc4_an,var_raw5_an,var_bc5_an,var_raw6_an,var_bc6_an,
                     #along=3)
  
  #var_mod_all2<-aperm(var_mod_all,c(3,1,2))

ch_all<-abind(ch1_an,ch2_an,ch3_an,ch4_an,ch5_an,ch6_an,along=3)
ch_all2<-aperm(ch_all,c(3,1,2))

  lon=seq(from=30.1,to=39.1,by=0.05)
  lat=seq(from=-10.35,to=-1.35,by=0.05)
  
  ## for tmx
   #PlotLayout(PlotEquiMap, c('lat','lon'), var_mod_all2[1:12, , ],lon=lon, lat=lat, nrow=6, filled.continents=FALSE, units = "mm day-1",
             # toptitle=paste0('Tanzania precipitation annual average'," ",pd[k]," ",sc1[j]), row_titles = mod, col_titles = c('Raw', 'Bias corrected'),
              #bar_limits = c(0,8), width=8, height=20, cols=c('#f7fcfd','#e5f5f9','#ccece6','#99d8c9','#66c2a4','#41ae76','#238b45','#006d2c'),
             # col_sup='#00441b',  bar_scale=0.3, intylat = 1, intxlon = 1, colNA="white",
             # title_scale=0.6, extra_margin = c(1,2,1,2), fileout = paste0('//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/plots/precip/tanz_precip_raw_bc_',tim[k],'_',sc1[j],'.png'))
   

  PlotLayout(PlotEquiMap, c('lat','lon'), ch_all2[1:6, , ],lon=lon, lat=lat, nrow=6, filled.continents=FALSE, units = "mm day-1",
             toptitle=paste0('Tanzania difference between BC and Raw'," ",pd[k]," ",sc1[j]), row_titles = mod, 
             bar_limits = c(-6,6), width=8, height=30, cols=c('#bf812d','#dfc27d','#f6e8c3','#c7eae5','#80cdc1','#35978f','#01665e'),
             col_sup='#01665e', col_inf='#8c510a', bar_scale=0.2, intylat = 1, intxlon = 1, colNA="white",
             title_scale=0.6, extra_margin = c(1,2,1,2), fileout = paste0('//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/plots/diff_bc-raw/precip/tanz_ch_precip_bc_raw_',tim[k],'_',sc1[j],'.png'))
  
  }
}

q(save='no')

