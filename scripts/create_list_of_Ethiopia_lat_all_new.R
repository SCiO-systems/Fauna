rm(list=ls())
library(dplyr)
library(abind)
dir<-'//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/'

country<-'Ethiopia'
sc<-c('126','245','370','585')
yr<-c('2030','2050')
period<-c('202101-204012','204101-206012')

## Lat and lon for each model
## 1. Models
mod<-c('BCC-CSM2-MR','EC-Earth3-Veg','GFDL-ESM4','IPSL-CM6A-LR','MRI-ESM2-0')
#Lat and long of all files for different models 

mod1_lon<-as.character(seq(from=32.625,to=47.625,by=0.05))
mod1_lat<-as.character(seq(from=2.625,to=15.125,by=0.05))

mod2_lon<-as.character(seq(from=32.375,to=48.125,by=0.05))
mod2_lat<-as.character(seq(from=2.375,to=15.125,by=0.05))

mod3_lon<-as.character(seq(from=32.625,to=47.625,by=0.05))
mod3_lat<-as.character(seq(from=2.625,to=15.125,by=0.05))

mod4_lon<-as.character(seq(from=32.625,to=47.625,by=0.05))
mod4_lat<-as.character(seq(from=2.625,to=15.125,by=0.05))

mod5_lon<-as.character(seq(from=32.625,to=47.625,by=0.05))
mod5_lat<-as.character(seq(from=2.625,to=15.125,by=0.05))
###############################################################
k=2
p=1
n=4

#for (k in 1:2){ ## period
  #for (p in 1:5){ ## model
    #for (n in 1:4){ ## scenario
      
      dd<-readRDS(paste0(dir,'cc_bc/',country,'/all/',yr[k],'/all_Ethi/all_var/all_Amon_',mod[p],'_ssp',sc[n],'_r1i1p1f1_Ethi_bc_all_',period[k],'.RDS'))
      
      ## Select domain to cover Ethiopia only
      lon<-seq(from=33.025,to=43.025,by=0.05)
      lat<-seq(from=3.025, to=13.025,by=0.05)
      
      ln1<-which(get(paste0('mod',p,'_lon'))==33.025);    ln2<-which(get(paste0('mod',p,'_lon'))==43.025)
      lt1<-which(get(paste0('mod',p,'_lat'))==3.025);     lt2<-which(get(paste0('mod',p,'_lat'))==13.025)           
      
      dd<-dd[ln1:ln2,lt1:lt2, , ]
      
      ## condition to remove incosistent data (tmx <= tmin)
      dd[ , , ,2]<-ifelse(round(dd[ , , ,2])<=round(dd[ , , ,3]),dd[ , , ,3]+0.6,dd[ , , ,2])
      
      ## convert radiation equal to 0 to 0.11, since DSSAT stops to run
      dd[ , , ,4]<-ifelse(dd[ , , ,4]==0,0.11,dd[ , , ,4])
      
      ## precip 4 digits after decimal and other 2 digits.
      dda<-round(dd[,, ,1],digits=4)
      ddb<-round(dd[,, ,2:4],digits=2)
      
      dd<-abind(dda,ddb,along=4)
      rm(dda); rm(ddb)
      
      ## lon and lat repeated to make a mesh grid
      
      dimen<-dim(dd)
      ln2<-rep(lon,each=dimen[2])
      t<-dimen[2]
      
      x<-array(numeric(),dim=c(length(lon),dimen[2],2))
      for (l in 1:length(lon)){
        x[l, , ]<-cbind(lon=ln2[((l-1)*t+1):(l*t)],lat=round(lat[1:dimen[2]],2))
      }
      
      x<-matrix(x, nrow=dim(x)[1]*dim(x)[2],byrow=F)
      x<-as.data.frame(x)
      colnames(x)<-c('lon','lat')
      
      ## Date,m and day
       if (k==1){
        ymd<-seq(as.Date('2021-01-01'),by='1 days', length.out=dim(dd)[3])
      } else {
        ymd<-seq(as.Date('2041-01-01'),by='1 days', length.out=dim(dd)[3])
      }
	  	  
      y<-substr(ymd[1:dim(dd)[3]],1,4)
      m<-substr(ymd[1:dim(dd)[3]],6,7)
      d<- substr(ymd[1:dim(dd)[3]],9,10)
      
      ## to make '01' to '1' in both month and day
      for (i in 1:length(y)){
        if(as.numeric(m[i]) < 10){
          m[i]=substr(ymd[i],7,7)
        } else {
          m[i]<-substr(ymd[i],6,7)
        }
      }
      
      for (i in 1:length(y)){
        if(as.numeric(d[i]) < 10){
          d[i]=substr(ymd[i],10,10)
        } else {
          d[i]<-substr(ymd[i],9,10)
        }
      }
      
      y<-as.integer(y)
      m<-as.integer(m)
      d<-as.integer(d)
      ################
      dimn<-dim(dd)
      
      dd1<-array(list(), dim=c(dimn[1],dimn[2]))
      for (i in 1:dimn[1]){
        for (j in 1:dimn[2]){
          dd1[[i,j]]<-data.frame(dd[i,j, , ])
          dd1[[i,j]]<-cbind.data.frame(ymd,y,m,d,dd1[[i,j]])
          colnames(dd1[[i,j]])<-c('Date','year','month','day','prec_bias_correction','tmax','tmin','srad')
          dd1[[i,j]]$Date <- as.character(dd1[[i,j]]$Date)
        }
      }
      rm(dd)
      dd2<-array(dd1, dim=c(dimn[1]*dimn[2]))
      rm(dd1)
      
      ### ID for each lat and lon
      code<-as.integer(seq(from=1,to=length(dd2),by=1))
      
      ## Join soil, climate and code
      ug<-readRDS('//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/dssat_input/Ethiopia_soils.RDS')
      ug<-ug[1:dim(dd2),]
      
      require(purrr)
      
      ## Planting date start and end. Change it based on actual planting date.
      jday_init_avg<-readRDS('//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/dssat_input/sow_date_ethi.RDS')
      jday_init_avg<-jday_init_avg[ ,1:dimen[2]]
      dim_pl<-dim(jday_init_avg)
      jday_init_avg<-array(jday_init_avg,c(dim_pl[1]*dim_pl[2]))
      jday_end_avg<-jday_init_avg
      
      plnt<-tibble( Code = code %>% unlist(),jday_init_avg = jday_init_avg,  jday_end_avg = jday_end_avg) 
      
      yyy=ug %>%dplyr::mutate(climate = purrr::map(.x = dd2, .f = function(i){return(i)} ),
                              Code = purrr::map(.x = code, .f = function(i){return(i)} ))  %>% 
        dplyr::select(-c(geometry,CELL5M,ISO2)) %>% rename('lon' = X, 'lat' = Y) %>%
        tidyr::unnest(Code) %>% 
        full_join(. , plnt)  %>% 
        select(c('Code','lat','lon','climate','SOIL.SOL', 'jday_init_avg', 'jday_end_avg', 'SoilProfil'))
      yyy$Code<-as.numeric(yyy$Code)
      
      rm(ug); rm(dd2); rm(code); rm(plnt)
      ## for test
      saveRDS(yyy,paste0(dir,'dssat_input/',country,'/',yr[k],'/',mod[p],'_ssp',sc[n],'_r1i1p1f1_',period[k],'.RDS'))
      rm(yyy)
    #}
  #}
#}
q(save="no")






















