rm(list=ls())
library(ncdf4)
library(abind)
require(pacman)
pacman::p_load(raster, rgdal, rgeos, gtools, tidyverse)

dir<-'//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/'

var<-c('tasmax','tasmin','rsds')
var1<-c('tmax','tmin','srad')
cn<-c('Ethiopia','Ethiopia','Uganda')
cn1<-c('ethi','Tanz','ugan')
pd<-c('2030','2050')
pd1<-c('202101-204012','204101-206012')
mod<-c('BCC-CSM2-MR','EC-Earth3-Veg','GFDL-ESM4','IPSL-CM6A-LR','MRI-ESM2-0')
sc<-c("126","245","370","585")

for (p in 1:2){ ## periods
  for (v in 1:3){ ## var
  bc1<-array(numeric(),c(61,51,4))
  bc2<-array(numeric(),c(64,52,4))
  bc3<-array(numeric(),c(61,51,4))
  bc4<-array(numeric(),c(61,51,4))
  bc5<-array(numeric(),c(61,51,4))
  
  for (s in 1:4){ ## scen
    ## future
    var_bc1<-nc_open(paste0(dir,'cc_bc/Ethiopia/',pd[p],'/nc/mnmean/',var[v],'_Amon_',mod[1],'_ssp',sc[s],'_r1i1p1f1_ethi_bc_',pd1[p],'.climate.nc'))
    var_bc2<-nc_open(paste0(dir,'cc_bc/Ethiopia/',pd[p],'/nc/mnmean/',var[v],'_Amon_',mod[2],'_ssp',sc[s],'_r1i1p1f1_ethi_bc_',pd1[p],'.climate.nc'))
    var_bc3<-nc_open(paste0(dir,'cc_bc/Ethiopia/',pd[p],'/nc/mnmean/',var[v],'_Amon_',mod[3],'_ssp',sc[s],'_r1i1p1f1_ethi_bc_',pd1[p],'.climate.nc'))
    var_bc4<-nc_open(paste0(dir,'cc_bc/Ethiopia/',pd[p],'/nc/mnmean/',var[v],'_Amon_',mod[4],'_ssp',sc[s],'_r1i1p1f1_ethi_bc_',pd1[p],'.climate.nc'))
    var_bc5<-nc_open(paste0(dir,'cc_bc/Ethiopia/',pd[p],'/nc/mnmean/',var[v],'_Amon_',mod[5],'_ssp',sc[s],'_r1i1p1f1_ethi_bc_',pd1[p],'.climate.nc'))
    
    lt1<-ncvar_get(var_bc1,'lat')
    ln1<-ncvar_get(var_bc1,'lon')
    
    lt2<-ncvar_get(var_bc2,'lat')
    ln2<-ncvar_get(var_bc2,'lon')
    
    lt3<-ncvar_get(var_bc3,'lat')
    ln3<-ncvar_get(var_bc3,'lon')
    
    lt4<-ncvar_get(var_bc4,'lat')
    ln4<-ncvar_get(var_bc4,'lon')
  
    lt5<-ncvar_get(var_bc5,'lat')
    ln5<-ncvar_get(var_bc5,'lon')
    
    bc1[ , ,s]<-ncvar_get(var_bc1,'var')
    bc2[ , ,s]<-ncvar_get(var_bc2,'var')
    bc3[ , ,s]<-ncvar_get(var_bc3,'var')
    bc4[ , ,s]<-ncvar_get(var_bc4,'var')
    bc5[ , ,s]<-ncvar_get(var_bc5,'var')
  }
  
  ## to aind all, take the min long and lat of IPSL (33.125:45.125,3.125:15.125)
  fbc1<-bc1[3:51,3:51,];fbc2<-bc2[4:52,4:52,];fbc3<-bc3[3:51,3:51,];fbc4<-bc4[3:51,3:51,]; fbc5<-bc5[3:51,3:51,]
  bc_all<-abind(fbc1,fbc2,fbc3,fbc4,fbc5,along=4)
  
  ### 1. obs ref
  var_obs<-nc_open(paste0(dir,'observed_baseline/agmerra/',var1[v],'_daily_ts_agmerra_1991_2010_eth_inv_climate.nc'))
  var_obs1<-ncvar_get(var_obs, var1[v])
  obs_lt<-ncvar_get(var_obs,"latitude")
  obs_ln<-ncvar_get(var_obs,"longitude")
  
  ## to make bc consistent with obs data
  var_obs2<-var_obs1[6:54,8:56]
  
  ## calculate change
  ch_all<-bc_all
  for (o in 1:4){ ## scena
    for (q in 1:5){ ## model
      ch_all[ , ,o,q]<-bc_all[ , ,o,q]-var_obs2
    }
    
  }
  
  ## rearrange dim to make lon,lat,data
  dimn<-dim(ch_all)
  ch_all1<-array(ch_all,c(dimn[1],dimn[2],dimn[3]*dimn[4]))
  
  ## since brick starts stacking from last column to first column, we need to reverse column order
  df2=ch_all1
  for (n in 1:dim(df2)[3]){
    df2[, ,n]=ch_all1[,order(ncol(ch_all1[,,n]):1),n]
  }
  
  data<-brick(df2, xmn=32.625, xmx=47.625, ymn=1.625, ymx=15.125, 
              crs=NA, transpose=TRUE)
  
  mps <- shapefile('C:/Users/pjha/Desktop/ETH_adm/ETH_adm0.shp')
  
  name<-c("BCC-CSM2-MR-SSP126","BCC-CSM2-MR-SSP245","BCC-CSM2-MR-SSP370","BCC-CSM2-MR-SSP585",
          "EC-Earth3-Veg-SSP126","EC-Earth3-Veg-SSP245","EC-Earth3-Veg-SSP370","EC-Earth3-Veg-SSP585",
          "GFDL-ESM4-SSP126","GFDL-ESM4-SSP245","GFDL-ESM4-SSP370","GFDL-ESM4-SSP585",
          "IPSL-CM6A-LR-SSP126","IPSL-CM6A-LR-SSP245","IPSL-CM6A-LR-SSP370","IPSL-CM6A-LR-SSP585", 
                    "MRI-ESM2-0-SSP126","MRI-ESM2-0-SSP245","MRI-ESM2-0-SSP370","MRI-ESM2-0-SSP585") 
  ## lable for models
  lbl <- data.frame(mdl_name = name, mdl = as.integer(1:20))
  
  # Selecting only Valle del Cauca ------------------------------------------
  vll <- aggregate(mps, 'ID_0')
  
  ## mask Ethiopia region
  data1 <- raster::crop(data, vll) %>% 
    raster::mask(., vll)
  
  # Making the map ----------------------------------------------------------
  vls <- rasterToPoints(data1) %>% 
    as_tibble() %>% 
    gather(var, value, -x, -y) %>% 
    mutate(mdl = as.integer(sub("^\\D*(\\d+).*$", "\\1", var))) %>% 
    inner_join(., lbl, by = 'mdl') %>% 
    dplyr::select(x, y, mdl_name, value) %>% 
    mutate(mdl_name = factor(mdl_name, levels = name))
  
  vls %>% filter(mdl_name=='BCC-tmx') 
  summary(vls$value)
  
  if(v==1){
    cols=c('#d0d1e6','#ffeda0','#feb24c','#fc4e2a','#bd0026','#800026')
    l<-c(-1,5)
    b<-seq(-1,5,1)
    tit=paste0('Ethiopia change in Tmax in'," ",pd1[p])
    unit="0C"
  } else if(v==2){
   cols=c('#d0d1e6','#ffeda0','#feb24c','#fc4e2a','#bd0026','#800026')
    l<-c(-1,5)
    b<-seq(-1,5,1)
    tit=paste0('Ethiopia change in Tmin in'," ",pd1[p]) 
    unit="0C"
  } else {
    cols=rev(c('#d73027','#fc8d59','#fee090','#e0f3f8','#91bfdb','#4575b4'))
    l<-c(-1.5,1.5)
    b<-seq(-1.5,1.5,0.75)
    tit=paste0('Ethiopia change in Srad in'," ",pd1[p]) 
    unit="MJm-2"
  } 
  
  xbrk=seq(35,48,by=2)
  ybrk=seq(3,15,by=3)
  xlm=c(35,48)
  ylm=c(3, 15)
  
  gg <- ggplot(vls)  +
    geom_tile(aes(x = x, y =  y, fill = value)) +
    facet_wrap(~ mdl_name, nrow=5, ncol=4) +
    scale_fill_gradientn(colours = cols, guide = "colourbar",
                         na.value = 'white', limits = l, breaks =b ) +
    geom_polygon(data = mps, aes(x=long, y = lat, group = group),color = 'white', fill='NA') +
    theme_bw() +
    #xmn=28.6, xmx=36.1, ymn=-2.875, ymx=6.125
    scale_x_continuous(breaks = xbrk) + 
    scale_y_continuous(breaks=ybrk) +
    coord_equal(xlim = xlm, ylim = ylm) +
    labs(title = tit, fill = unit, x = 'Longitude', y = 'Latitude') +  
    theme(legend.position = 'bottom', 
          plot.title = element_text(hjust = 0.5),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          legend.text = element_text(size = 8),
          legend.title = element_text(size=9),
          legend.key.width = unit(5, 'line'))
  
  
  ggsave(plot = gg, 
         filename = paste0(dir,'plots/climate_change/bias_cor/ethi_',var[v],'_climate_',pd1[p],'.png'), 
         width = 8, height = 11.5, units = 'in', dpi = 300) 
}
}
q(save='no')



