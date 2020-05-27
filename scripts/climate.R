rm(list=ls())
library(ncdf4)
library(abind)
require(pacman)
pacman::p_load(raster, rgdal, rgeos, gtools, tidyverse)

dir_fut<-'//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/'
dir_hist<-'//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/'

var<-c('pr','tasmax','tasmin','rsds')
cn<-c('Uganda','Tanzania','Ethiopia')
cn1<-c('Ugan','Tanz','Ethi')
pd<-c('2030','2060')
pd1<-c('202101-204012','204101-206012')
mod<-c('BCC-CSM2-MR','EC-Earth3-Veg','GFDL-ESM4','MIROC6','MRI-ESM2-0')
sc<-c("126","245","370","585")

for (c in 1:3){ ## country
for (p in 1:2){ ## period
  #for (v in 1:4){ ## var
  v=4
    if (c==1){
    dt_fut<-array(numeric(), c(6,7,length(mod),length(sc)))
    df_his<-array(numeric(), c(6,7,length(mod)))
    } else if(c==2){
      dt_fut<-array(numeric(), c(10,10,length(mod),length(sc)))
      df_his<-array(numeric(), c(10,10,length(mod)))
    } else {
      dt_fut<-array(numeric(), c(11,10,length(mod),length(sc)))
      df_his<-array(numeric(), c(11,10,length(mod)))
    }
    for (m in 1:5){ ## model
      for (s in 1:4){ ## sceanarrio
        aa<-nc_open(paste0(dir_fut,cn[c],'/',pd[p],'/timmean/interpolated/',var[v],'_Amon_',mod[m],'_ssp',sc[s],'_r1i1p1f1_climate_',cn1[c],'_',pd1[p],'.nc'))
        aa_his<-nc_open(paste0(dir_hist,cn[c],'/timmean/interpolated/',var[v],'_Amon_',mod[m],'_historical_r1i1p1f1_',cn1[c],'_climate_199101-201012.nc'))
        dt_fut[ , ,m,s]<-ncvar_get(aa,var[v])
        df_his[ , ,m]<-ncvar_get(aa_his,var[v])
        
        if(v==1){
          dt_fut[ , ,m,s]<-dt_fut[ , ,m,s]*86400 ## to convert to mm/day
          df_his[ , ,m]<-df_his[ , ,m]*86400
        } else if(v==2|v==3){
          dt_fut[ , ,m,s]<-dt_fut[ , ,m,s]-273 ## convert kelvin to 0C.
          df_his[ , ,m]<-df_his[ , ,m]-273
        } else {
          dt_fut[ , ,m,s]<-dt_fut[ , ,m,s]*0.0864 ## convert w/m2 to MJ/m2/day
          df_his[ , ,m]<-df_his[ , ,m]*0.0864
        }
        
      }
    }
    ## combine history and future
    df<-abind(df_his[, ,1],dt_fut[ , ,1,],df_his[, ,2],dt_fut[ , ,2,],df_his[, ,3],dt_fut[ , ,3,],
              df_his[, ,4],dt_fut[ , ,4,],df_his[, ,5],dt_fut[ , ,5,],along=3)
    
    ## convert 3d array to raster
    #       crs='+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0', transpose=FALSE)
    
    ## since brick starts stacking from last column to first column, we need to reverse column order
    df2=df
    for (n in 1:dim(df2)[3]){
      df2[, ,n]=df[,order(ncol(df[,,n]):1),n]
    }
    
    if (c==1){
      data<-brick(df2, xmn=28.6, xmx=36.1, ymn=-2.875, ymx=6.125, 
                  crs=NA, transpose=TRUE)
    } else if(c==2){
      data<-brick(df2, xmn=27.625, xmx=41.125, ymn=-13.375, ymx=0.125, 
                  crs=NA, transpose=TRUE)
    } else {
      data<-brick(df2, xmn=32.625, xmx=47.625, ymn=1.625, ymx=15.125, 
                  crs=NA, transpose=TRUE)
    }
    
    
    #### Plotting boundaries of Uganda
    if (c==1){
      mps <- shapefile('C:/Users/pjha/Desktop/UGA_adm/UGA_adm0.shp')
    } else if (c==2){
      mps <- shapefile('C:/Users/pjha/Desktop/TZA_adm/TZA_adm0.shp')
    } else {
      mps <- shapefile('C:/Users/pjha/Desktop/ETH_adm/ETH_adm0.shp')
    }
    
    
    name<-c("BCC-CSM2-MR-HIST","BCC-CSM2-MR-SSP126","BCC-CSM2-MR-SSP245","BCC-CSM2-MR-SSP370","BCC-CSM2-MR-SSP585",
            "EC-Earth3-Veg-HIST","EC-Earth3-Veg-SSP126","EC-Earth3-Veg-SSP245","EC-Earth3-Veg-SSP370","EC-Earth3-Veg-SSP585",
            "GFDL-ESM4-HIST","GFDL-ESM4-SSP126","GFDL-ESM4-SSP245","GFDL-ESM4-SSP370","GFDL-ESM4-SSP585",
            "MIROC6-HIST","MIROC6-SSP126","MIROC6-SSP245","MIROC6-SSP370","MIROC6-SSP585", 
            "MRI-ESM2-0-HIST","MRI-ESM2-0-SSP126","MRI-ESM2-0-SSP245","MRI-ESM2-0-SSP370","MRI-ESM2-0-SSP585") 
    
    
    ## lable for models
    lbl <- data.frame(mdl_name = name, mdl = as.integer(1:25))
    
    # Selecting only Valle del Cauca ------------------------------------------
    vll <- aggregate(mps, 'ID_0')
    
    ## mask uganda region
    data1 <- raster::crop(data, vll) #%>% 
    #raster::mask(., vll)
    
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
      cols=c('#e5f5f9','#ccece6','#99d8c9','#66c2a4','#41ae76','#238b45','#006d2c','#00441b')
      l<-c(0,12)
      b<-seq(0,12,1.5)
      tit =paste0(cn[c]," ", 'precipitation in'," ",pd1[p])
      unit="mm day-1"
    } else if(v==2){
      cols=c('#ffffcc','#ffeda0','#fed976','#feb24c','#fd8d3c','#fc4e2a','#e31a1c','#bd0026')
      l<-c(20,52)
      b<-seq(22,52,4)
      tit=paste0(cn[c]," ",'Tmax in'," ",pd1[p])
      unit="0C"
    } else if(v==3){
      cols=c('#ffffcc','#ffeda0','#fed976','#feb24c','#fd8d3c','#fc4e2a','#e31a1c','#bd0026')
      l<-c(10,34)
      b<-seq(10,34,3)
      tit=paste0(cn[c]," ",'Tmin in'," ",pd1[p]) 
      unit="0C"
    } else {
      cols=c('#ffffcc','#ffeda0','#fed976','#feb24c','#fd8d3c','#fc4e2a','#e31a1c','#bd0026')
      l<-c(12,28)
      b<-seq(12,28,2)
      tit=paste0(cn[c]," ",'Srad in'," ",pd1[p]) 
      unit="MJm-2"
    }
    
    if(c==1){
      xbrk=c(30,31,32,33,34,35)
      ybrk=seq(-1,4,by=1)
      xlm=c(29.8,35)
      ylm=c(-1, 4)
    } else if(c==2){
      xbrk=seq(30,40,by=2)
      ybrk=seq(-11,-1,by=3)
      xlm=c(29.5,40.3)
      ylm=c(-11.5, -1)
    } else {
      xbrk=seq(35,48,by=2)
      ybrk=seq(3,15,by=3)
      xlm=c(35,48)
      ylm=c(3, 15)
    }
    
    gg <- ggplot(vls)  +
      geom_tile(aes(x = x, y =  y, fill = value)) +
      facet_wrap(~ mdl_name, nrow=5, ncol=5) +
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
           filename = paste0('//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/plots/climate/raw/',cn1[c],'_',var[v],'_climate_',pd1[p],'.png'), 
           width = 8, height = 11.5, units = 'in', dpi = 300) 
    
  }
}
#}
q(save='no')



