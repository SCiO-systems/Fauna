library(Dasst)
library(s2dverification)
require(pacman)
pacman::p_load(raster, rgdal, rgeos, gtools, tidyverse)

#dir<-'//dapadfs/workspace_cluster_12/AVISA/dssat_test1/dssat_runs_ug_bcc/'
dir<-'//dapadfs/workspace_cluster_12/AVISA/dssat_outputs/uganda/'
x1<-array(numeric(),c(20,13431))

# for (i in 1:13410){
#   #if(i==61 | i==62 | i==63 | i==64 | i==65 | i==66 | i==67 | i==68 | i==69 | i==70){
#   if(i==NA){
#     next
#   }
#   x<-read.dssat(paste0(dir,'dssat_runs_uganda_BCC-CSM2-MR_ssp_126_2030/',i,'/Evaluate.OUT'))
#   x1[ ,i]<-x[[1]][,14]
#   rm(x)
# }

for (i in 1:13431){
if(!file.exists(paste0(dir,'dssat_runs_uganda_BCC-CSM2-MR_ssp_126_2030/',i,'/Evaluate.OUT'))) {
  x1[ ,i]<-NA
  } else {
    x<-read.dssat(paste0(dir,'dssat_runs_uganda_BCC-CSM2-MR_ssp_126_2030/',i,'/Evaluate.OUT'))
    x1[ ,i]<-x[[1]][,14]
    rm(x)
  }
}

xav<-apply(x1,c(2),mean)
xst<-apply(x1,c(2),sd)

lon<-seq(from=29.525,to=35.025,by=0.05)
lat<-seq(from=-1.525, to=4.475,by=0.05)

xav1<-array(xav,c(111,121))
xst1<-array(xst,c(111,121))
xav2<-as.matrix(xav1)

#xav1<-matrix(xav,nrow=30,byrow = T)
PlotEquiMap(xav2,lon=lon,lat=lat,filled.continents = F, bar_limits = c(0,4000), toptitle='Yield annual average (2021-2040)',
                       cols=c('#ffffcc','#ffeda0','#fed976','#feb24c','#fd8d3c','#fc4e2a','#e31a1c','#bd0026'),
                       intylat = 1, intxlon = 1, colNA="white",units = "kg ha-1", width=8, height=10,
                       fileout = paste0(dir,'/av_yield_Uganda1.png'))
