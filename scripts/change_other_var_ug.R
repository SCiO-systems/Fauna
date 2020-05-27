rm(list=ls())
library(ncdf4)
library(abind)
library(s2dverification)
dir_raw<-'//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/' #Uganda/2030/'
dir_bc<-'//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_bc/Uganda/' #2030/nc1/mnmean/'

mod<-c('BCC-CSM2-MR','EC-Earth3-Veg','GFDL-ESM4','IPSL-CM6A-LR','MIROC6','MRI-ESM2-0')
var<-c('tasmax','tasmin','rsds')
sc1<-c('ssp126','ssp245','ssp370','ssp585')
pd<-c('202101-204012','204101-206012')
tim<-c('2030','2050')
tim1<-c('2030','2060')

for (k in 1:2){ ## periods
  for (j in 1:4){ ## scenarios
    cha_all<-array(numeric(),c(19,31,6,3))
    for (i in 1:3){ ## varibles
      ## raw
      if (k==1){
        var_raw1<-nc_open(paste0(dir_raw,'Uganda/',tim[k],'/',var[i],'_Amon_',mod[1],'_',sc1[j],'_r1i1p1f1_monmean_Ugan_',pd[k],'.nc'))
        var_raw2<-nc_open(paste0(dir_raw,'Uganda/',tim[k],'/',var[i],'_Amon_',mod[2],'_',sc1[j],'_r1i1p1f1_monmean_Ugan_',pd[k],'.nc'))
        var_raw3<-nc_open(paste0(dir_raw,'Uganda/',tim[k],'/',var[i],'_Amon_',mod[3],'_',sc1[j],'_r1i1p1f1_monmean_Ugan_',pd[k],'.nc'))
        var_raw4<-nc_open(paste0(dir_raw,'Uganda/',tim[k],'/',var[i],'_Amon_',mod[4],'_',sc1[j],'_r1i1p1f1_monmean_Ugan_',pd[k],'.nc'))
        var_raw5<-nc_open(paste0(dir_raw,'Uganda/',tim[k],'/',var[i],'_Amon_',mod[5],'_',sc1[j],'_r1i1p1f1_monmean_Ugan_',pd[k],'.nc'))
        var_raw6<-nc_open(paste0(dir_raw,'Uganda/',tim[k],'/',var[i],'_Amon_',mod[6],'_',sc1[j],'_r1i1p1f1_monmean_Ugan_',pd[k],'.nc'))
      } else {
        var_raw1<-nc_open(paste0(dir_raw,'Uganda/',tim1[k],'/',var[i],'_Amon_',mod[1],'_',sc1[j],'_r1i1p1f1_monmean_Ugan_',pd[k],'.nc'))
        var_raw2<-nc_open(paste0(dir_raw,'Uganda/',tim1[k],'/',var[i],'_Amon_',mod[2],'_',sc1[j],'_r1i1p1f1_monmean_Ugan_',pd[k],'.nc'))
        var_raw3<-nc_open(paste0(dir_raw,'Uganda/',tim1[k],'/',var[i],'_Amon_',mod[3],'_',sc1[j],'_r1i1p1f1_monmean_Ugan_',pd[k],'.nc'))
        var_raw4<-nc_open(paste0(dir_raw,'Uganda/',tim1[k],'/',var[i],'_Amon_',mod[4],'_',sc1[j],'_r1i1p1f1_monmean_Ugan_',pd[k],'.nc'))
        var_raw5<-nc_open(paste0(dir_raw,'Uganda/',tim1[k],'/',var[i],'_Amon_',mod[5],'_',sc1[j],'_r1i1p1f1_monmean_Ugan_',pd[k],'.nc'))
        var_raw6<-nc_open(paste0(dir_raw,'Uganda/',tim1[k],'/',var[i],'_Amon_',mod[6],'_',sc1[j],'_r1i1p1f1_monmean_Ugan_',pd[k],'.nc'))
      }
      
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
      
      if (i==3){
        var_raw1<-ncvar_get(var_raw1,var[i])*0.0864
        var_raw2<-ncvar_get(var_raw2,var[i])*0.0864
        var_raw2<-var_raw2[1:10, , ]
        var_raw3<-ncvar_get(var_raw3,var[i])*0.0864
        var_raw4<-ncvar_get(var_raw4,var[i])*0.0864
        var_raw5<-ncvar_get(var_raw5,var[i])*0.0864
        var_raw5<-var_raw5[1:5, , ]
        var_raw6<-ncvar_get(var_raw6,var[i])*0.0864
      } else {
        var_raw1<-ncvar_get(var_raw1,var[i])-273
        var_raw2<-ncvar_get(var_raw2,var[i])-273
        var_raw2<-var_raw2[1:10, , ]
        var_raw3<-ncvar_get(var_raw3,var[i])-273
        var_raw4<-ncvar_get(var_raw4,var[i])-273
        var_raw5<-ncvar_get(var_raw5,var[i])-273
        var_raw5<-var_raw5[1:5, , ]
        var_raw6<-ncvar_get(var_raw6,var[i])-273
      }
      
      var_bc1<-nc_open(paste0(dir_bc,tim[k],'/nc/mnmean/',var[i],'_Amon_',mod[1],'_',sc1[j],'_r1i1p1f1_Ugan_bc_',pd[k],'.mnmean.nc'))
      var_bc2<-nc_open(paste0(dir_bc,tim[k],'/nc/mnmean/',var[i],'_Amon_',mod[2],'_',sc1[j],'_r1i1p1f1_Ugan_bc_',pd[k],'.mnmean.nc'))
      var_bc3<-nc_open(paste0(dir_bc,tim[k],'/nc/mnmean/',var[i],'_Amon_',mod[3],'_',sc1[j],'_r1i1p1f1_Ugan_bc_',pd[k],'.mnmean.nc'))
      var_bc4<-nc_open(paste0(dir_bc,tim[k],'/nc/mnmean/',var[i],'_Amon_',mod[4],'_',sc1[j],'_r1i1p1f1_Ugan_bc_',pd[k],'.mnmean.nc'))
      var_bc5<-nc_open(paste0(dir_bc,tim[k],'/nc/mnmean/',var[i],'_Amon_',mod[5],'_',sc1[j],'_r1i1p1f1_Ugan_bc_',pd[k],'.mnmean.nc'))
      var_bc6<-nc_open(paste0(dir_bc,tim[k],'/nc/mnmean/',var[i],'_Amon_',mod[6],'_',sc1[j],'_r1i1p1f1_Ugan_bc_',pd[k],'.mnmean.nc'))
      
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
      
      var_bc1<-ncvar_get(var_bc1,'var1_1')
      var_bc2<-ncvar_get(var_bc2,'var1_1')
      var_bc3<-ncvar_get(var_bc3,'var1_1')
      var_bc4<-ncvar_get(var_bc4,'var1_1')
      var_bc5<-ncvar_get(var_bc5,'var1_1')
      var_bc6<-ncvar_get(var_bc6,'var1_1')
      
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
      var_raw1_an<-var_raw1_an[6:24,4:34]
      var_bc1_an<-var_bc1_an[6:24,4:34]
      ch1_an<-var_bc1_an-var_raw1_an
      
      var_raw2_an<-var_raw2_an[7:25,4:34]
      var_bc2_an<-var_bc2_an[7:25,4:34]  
      ch2_an<-var_bc2_an-var_raw2_an
      
      var_raw3_an<-var_raw3_an[6:24,4:34]
      var_bc3_an<-var_bc3_an[6:24,4:34]
      ch3_an<- var_bc3_an-var_raw3_an
      
      var_raw4_an<-var_raw4_an[1:19,4:34]
      var_bc4_an<-var_bc4_an[1:19,4:34]
      ch4_an<-var_bc4_an-var_raw4_an
      
      var_raw5_an<-var_raw5_an[7:25,1:31]
      var_bc5_an<-var_bc5_an[7:25,1:31]
      ch5_an<-var_bc5_an-var_raw5_an
      
      var_raw6_an<-var_raw6_an[6:24,4:34]
      var_bc6_an<-var_bc6_an[6:24,4:34]
      ch6_an<-var_bc6_an-var_raw6_an
      
      dimn<-dim(ch6_an)
      
      cha_all[ , , ,i]<-abind(ch1_an,ch2_an,ch3_an,ch4_an,ch5_an,ch6_an,along=3)
    }
    dim2<-dim(cha_all)
    cha_all_di<-aperm(cha_all,c(1,2,4,3))
    rm(cha_all)
    ch_all1<-array(cha_all_di,c(dim2[1],dim2[2],dim2[3]*dim2[4]))
    rm(cha_all_di)
    ch_all2<-aperm(ch_all1,c(3,1,2))
    rm(ch_all1)
      lon=seq(from=30.125,to=34.625,by=0.25)
      lat=seq(from=-2.875,to=4.625,by=0.25)
      
      col<-c('#a50026','#d73027','#f46d43','#fdae61','#fee08b','#ffffbf','#d9ef8b','#a6d96a','#66bd63','#1a9850','#006837')
      col1<-rev(col)
      
      PlotLayout(PlotEquiMap, c('lat','lon'), ch_all2[1:18, , ],lon=lon, lat=lat, nrow=6, filled.continents=FALSE, units = "degC and MJm-2day-1",
                 toptitle=paste0('Uganda (BC - Raw)'," ",pd[k]," ",sc1[j]), row_titles = mod, col_titles = c('tmax','tmin','srad'),
                 bar_limits = c(-10,10), width=8, height=20, cols=col1[2:9],col_inf = col1[1],col_sup = col1[11],
                  bar_scale=0.3, intylat = 1, intxlon = 1, colNA="white",
                 title_scale=0.6, extra_margin = c(1,2,1,2), fileout = paste0('//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/plots/diff_bc-raw/others/ugan_ch_others_bc_raw_',tim[k],'_',sc1[j],'.png'))
      
  }
}

q(save="no")
