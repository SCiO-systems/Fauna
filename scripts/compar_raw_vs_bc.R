library(ncdf4)
library(abind)
library(s2dverification)
dir_raw<-'//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/Uganda/2030/'
dir_bc<-'//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_bc/Uganda/2030/nc1/mnmean/'

## raw
tmx_raw<-nc_open(paste0(dir_raw,'tasmax_Amon_BCC-CSM2-MR_ssp126_r1i1p1f1_re_gn_Ugan_monmean_201501-204412.nc'))
tmx_raw<-ncvar_get(tmx_raw,'tasmax')-273
source('//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/functions_bc/fit_new_dim.R')
tmx_raw1<-fit_new_dim(mod=tmx_raw,obs=tmx_bc_av[ , ,1])

##bc
tmx_bc<-nc_open(paste0(dir_bc,'tasmax_Amon_BCC-CSM2-MR_ssp126_r1i1p1f1_re_gn_Ugan_bc_mnmean_201501-204412.nc'))
tmx_bc<-ncvar_get(tmx_bc,'var1_1')
tmx_bc<-array(tmx_bc,c(26,31,12,31))
tmx_bc_av<-apply(tmx_bc,c(1,2,3),mean)
lat<-ncvar_get(tmx_bc,'lat')
lon<-ncvar_get(tmx_bc,'lon')

## average annual
tmx_raw_an<-apply(tmx_raw1,c(1,2),mean)
tmx_bc_an<-apply(tmx_bc_av,c(1,2),mean)
tmx_mod1<-abind(tmx_raw_an,tmx_bc_an,along=3)
tmx_mod2<-aperm(tmx_mod1,c(3,1,2))

dif<-round((tmx_raw_an-tmx_bc_an),digits = 1)

models<-c('BCC-CSM2-MR', 'BCC-CSM2-MR')
          #'EC-Earth3-Veg','GFDL-ESM4','IPSL-CM6A-LR','MIROC6','MRI-ESM2-0')
X11()
PlotLayout(PlotEquiMap, c('lon','lat'), tmx_mod2,lon=lon, lat=lat, nrow=1, filled.continents=FALSE, units = "degC", 
           cols=c('#ffffcc','#ffeda0','#fed976','#feb24c','#fd8d3c','#fc4e2a','#e31a1c','#b10026'),
           width=8, height=9, toptitle='Tmax raw (left) vs. bias corrected (right)', titles=paste0(models),
          bar_limits = c(22,38), subtitle_scale = 0.5,  title_margin_scale=1.5,
           intylat = 1, intxlon = 1, colNA="white", title_scale=0.5)  
           
          
