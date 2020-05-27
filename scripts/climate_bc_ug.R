rm(list=ls())
library(ncdf4)
library(abind)
require(pacman)
pacman::p_load(raster, rgdal, rgeos, gtools, tidyverse)

dir_fut<-'//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_bc/'
dir_hist<-'//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/'
dir<-'//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/'

var<-c('tasmax','tasmin','rsds')
var1<-c('tmax','tmin','srad')
pd<-c('2030','2050')
pd1<-c('202101-204012','204101-206012')
mod<-c('BCC-CSM2-MR','EC-Earth3-Veg','GFDL-ESM4','IPSL-CM6A-LR','MRI-ESM2-0')
sc<-c("126","245","370","585")

for (p in 1:2){ ## periods
  for (v in 1:3){ ## var
    bc1<-array(numeric(),c(36,36,4))
    bc2<-array(numeric(),c(34,37,4))
    bc3<-array(numeric(),c(36,36,4))
    bc4<-array(numeric(),c(31,36,4))
       bc5<-array(numeric(),c(36,36,4))
    
    for (s in 1:4){ ## scen
      ## future
      var_bc1<-nc_open(paste0(dir_fut,'Uganda/',pd[p],'/nc/mnmean/',var[v],'_Amon_',mod[1],'_ssp',sc[s],'_r1i1p1f1_Ugan_bc_',pd1[p],'.climate.nc'))
      var_bc2<-nc_open(paste0(dir_fut,'Uganda/',pd[p],'/nc/mnmean/',var[v],'_Amon_',mod[2],'_ssp',sc[s],'_r1i1p1f1_Ugan_bc_',pd1[p],'.climate.nc'))
      var_bc3<-nc_open(paste0(dir_fut,'Uganda/',pd[p],'/nc/mnmean/',var[v],'_Amon_',mod[3],'_ssp',sc[s],'_r1i1p1f1_Ugan_bc_',pd1[p],'.climate.nc'))
      var_bc4<-nc_open(paste0(dir_fut,'Uganda/',pd[p],'/nc/mnmean/',var[v],'_Amon_',mod[4],'_ssp',sc[s],'_r1i1p1f1_Ugan_bc_',pd1[p],'.climate.nc'))
      var_bc5<-nc_open(paste0(dir_fut,'Uganda/',pd[p],'/nc/mnmean/',var[v],'_Amon_',mod[5],'_ssp',sc[s],'_r1i1p1f1_Ugan_bc_',pd1[p],'.climate.nc'))
     
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
     
      bc1[ , ,s]<-ncvar_get(var_bc1,'var1_1')
      bc2[ , ,s]<-ncvar_get(var_bc2,'var1_1')
      bc3[ , ,s]<-ncvar_get(var_bc3,'var1_1')
      bc4[ , ,s]<-ncvar_get(var_bc4,'var1_1')
      bc5[ , ,s]<-ncvar_get(var_bc5,'var1_1')
   }
    
    ## historical
    var_raw1<-nc_open(paste0(dir_hist,'Uganda/timmean/',var[v],'_Amon_',mod[1],'_historical_r1i1p1f1_Ugan_climate_199101-201012.nc'))
    var_raw2<-nc_open(paste0(dir_hist,'Uganda/timmean/',var[v],'_Amon_',mod[2],'_historical_r1i1p1f1_Ugan_climate_199101-201012.nc'))
    var_raw3<-nc_open(paste0(dir_hist,'Uganda/timmean/',var[v],'_Amon_',mod[3],'_historical_r1i1p1f1_Ugan_climate_199101-201012.nc'))
    var_raw4<-nc_open(paste0(dir_hist,'Uganda/timmean/',var[v],'_Amon_',mod[4],'_historical_r1i1p1f1_Ugan_climate_199101-201012.nc'))
    var_raw5<-nc_open(paste0(dir_hist,'Uganda/timmean/',var[v],'_Amon_',mod[5],'_historical_r1i1p1f1_Ugan_climate_199101-201012.nc'))
   
    lat1<-ncvar_get(var_raw1,'lat')
    lon1<-ncvar_get(var_raw1,'lon')
    
    lat2<-ncvar_get(var_raw2,'lat')
    lon2<-ncvar_get(var_raw2,'lon')
    
    lat3<-ncvar_get(var_raw3,'lat')
    lon3<-ncvar_get(var_raw3,'lon')
    
    lat4<-ncvar_get(var_raw4,'lat')
    lon4<-ncvar_get(var_raw4,'lon')
    
    lat5<-ncvar_get(var_raw5,'lat')
    lon5<-ncvar_get(var_raw5,'lon')
    
    
    raw1<-ncvar_get(var_raw1,var[v])
    raw1<-raw1[ ,1:8]
    raw2<-ncvar_get(var_raw2,var[v])
    raw2<-raw2[1:12,1:13]
    raw3<-ncvar_get(var_raw3,var[v])
    raw3<-raw3[ ,1:8]
    raw4<-ncvar_get(var_raw4,var[v])
    raw4<-raw4[,1:8]
    raw5<-ncvar_get(var_raw5,var[v])
    raw5<-raw5[,1:8]
    
    source('//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/functions_bc/fit_new_dim2.R')
    raw1_new<-fit_new_dim(mod=raw1,obs=bc1[,,1])
    raw2_new<-fit_new_dim(mod=raw2,obs=bc2[,,1])
    raw3_new<-fit_new_dim(mod=raw3,obs=bc3[,,1])
    raw4_new<-fit_new_dim(mod=raw4,obs=bc4[,,1])
    raw5_new<-fit_new_dim(mod=raw5,obs=bc5[,,1])
    
    ## to aind all, take the min long and lat of IPSL (28.625:35.125,-2.875:4.625)
    fbc1<-bc1[5:31,4:34,];fbc2<-bc2[4:30,4:34,];fbc3<-bc3[5:31,4:34,];fbc4<-bc4[5:31,4:34,]; fbc5<-bc5[5:31,4:34,]
    fraw1_new<-raw1_new[5:31,4:34];fraw2_new<-raw2_new[4:30,4:34]; fraw3_new<-raw3_new[5:31,4:34]; fraw4_new<-raw4_new[5:31,4:34]
     fraw5_new<-raw5_new[5:31,4:34]
    ## bind raw
    fraw<-abind(fraw1_new,fraw2_new,fraw3_new,fraw4_new,fraw5_new,along=3)
    ## convert to appropriate units
    if (v==4){
      fraw<-fraw*86400 ## to convert to mm/day
    } else if(v==1|v==2){
      fraw<-fraw-273 ## convert to deg c from Kelvin
    } else {
      fraw<-fraw*0.0864 ## convert w/m2 to MJ/m2/day
    }
    
    ### 1. obs ref
    var_obs<-nc_open(paste0(dir,'observed_baseline/agmerra/',var1[v],'_daily_ts_agmerra_1991_2010_ugan_inv_climate.nc'))
    var_obs1<-ncvar_get(var_obs, var1[v])
    obs_lt<-ncvar_get(var_obs,"latitude")
    obs_ln<-ncvar_get(var_obs,"longitude")
    ## to make bc consistent with obs data
    var_obs2<-var_obs1[5:31,5:35]
    
    ## combine history and future
    df<-abind(fraw[ , ,1],var_obs2,fbc1,fraw[ , ,2],var_obs2,fbc2,fraw[, ,3],var_obs2,fbc3,
              fraw[, ,4],var_obs2,fbc4,fraw[ , ,5],var_obs2,fbc5,along=3)
    
    ## since brick starts stacking from last column to first column, we need to reverse column order
    df2=df
    for (n in 1:dim(df2)[3]){
      df2[, ,n]=df[,order(ncol(df[,,n]):1),n]
    }
    
    data<-brick(df2, xmn=28.6, xmx=35.125, ymn=-2.875, ymx=4.625, 
                crs=NA, transpose=TRUE)
    
    mps <- shapefile('C:/Users/pjha/Desktop/UGA_adm/UGA_adm0.shp')
    
    name<-c("BCC-CSM2-MR-HIST","AgMERRA1","BCC-CSM2-MR-SSP126","BCC-CSM2-MR-SSP245","BCC-CSM2-MR-SSP370","BCC-CSM2-MR-SSP585",
            "EC-Earth3-Veg-HIST","AgMERRA2", "EC-Earth3-Veg-SSP126","EC-Earth3-Veg-SSP245","EC-Earth3-Veg-SSP370","EC-Earth3-Veg-SSP585",
            "GFDL-ESM4-HIST","AgMERRA3", "GFDL-ESM4-SSP126","GFDL-ESM4-SSP245","GFDL-ESM4-SSP370","GFDL-ESM4-SSP585",
            "IPSL-CM6A-LR-HIST","AgMERRA4", "IPSL-CM6A-LR-SSP126","IPSL-CM6A-LR-SSP245","IPSL-CM6A-LR-SSP370","IPSL-CM6A-LR-SSP585", 
                        "MRI-ESM2-0-HIST","AgMERRA6", "MRI-ESM2-0-SSP126","MRI-ESM2-0-SSP245","MRI-ESM2-0-SSP370","MRI-ESM2-0-SSP585") 
    ## lable for models
    lbl <- data.frame(mdl_name = name, mdl = as.integer(1:30))
    
    # Selecting only Valle del Cauca ------------------------------------------
    vll <- aggregate(mps, 'ID_0')
    
    ## mask uganda region
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
      cols=c('#ffffcc','#ffeda0','#fed976','#feb24c','#fd8d3c','#fc4e2a','#e31a1c','#bd0026')
      l<-c(20,52)
      b<-seq(22,52,4)
      tit=paste0('Uganda Tmax in'," ",pd1[p])
      unit="0C"
    } else if(v==2){
      cols=c('#ffffcc','#ffeda0','#fed976','#feb24c','#fd8d3c','#fc4e2a','#e31a1c','#bd0026')
      l<-c(10,34)
      b<-seq(10,34,3)
      tit=paste0('Uganda Tmin in'," ",pd1[p]) 
      unit="0C"
    } else {
      cols=c('#ffffcc','#ffeda0','#fed976','#feb24c','#fd8d3c','#fc4e2a','#e31a1c','#bd0026')
      l<-c(12,28)
      b<-seq(12,28,2)
      tit=paste0('Uganda Srad in'," ",pd1[p]) 
      unit="MJm-2"
    }
    
    xbrk=c(30,31,32,33,34,35)
    ybrk=seq(-1,4,by=1)
    xlm=c(29.8,35)
    ylm=c(-1, 4)
    
    gg <- ggplot(vls)  +
      geom_tile(aes(x = x, y =  y, fill = value)) +
      facet_wrap(~ mdl_name, nrow=5, ncol=6) +
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
           filename = paste0('//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/plots/climate/bias_cor/ugan_',var[v],'_climate_',pd1[p],'.png'), 
           width = 8, height = 11.5, units = 'in', dpi = 300) 
  }
}
q(save='no')



