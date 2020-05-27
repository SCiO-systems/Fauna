rm(list=ls())
library(s2dverification)

ln<-seq(from=29.525,to=35.025,by=0.05)
lt<-seq(from=-1.525,to=4.475,by=0.05)
dd<-read.csv('//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/scripts/final_sowing_date_ug.csv',header=T)
dd1<-dd[,2:13]  ## lat from=3.9,to=-2.35 and lon from=30.1,to=34.6 in 0.25 res
dd2<-t(dd1) ## make the matrix [lon,lat]. dd1 is [lat,lon]
dd3<-dd2[ ,c(seq(13,1,-1))]  ## reorder long to start from 0.1 to 3.9
## convert the matrix dd2 from 0.25 deg res to 0.05 res
## the function fit_new_dim1 uses 3d matrix. So, addd a singleton dim 
dd3<-InsertDim(dd3,3,1)

## the function needs a 3d matrix of the intended dim
plt<-matrix(runif(13431,3,4),nrow=111)
plt1<-InsertDim(plt,3,1)
## part 2: change dim
source('//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/functions_bc/fit_new_dim1.R')
plt2<-fit_new_dim1(mod=dd3, obs=plt1)
plt3<-drop(plt2)
saveRDS(plt3,'//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/dssat_input/sow_date.RDS')
