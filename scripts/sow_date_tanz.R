rm(list=ls())
library(s2dverification)

ln<-seq(from=29.125,to=40.125,by=0.05)
lt<-seq(from=-11.975,to=-0.975,by=0.05)
dd<-read.csv('//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/scripts/final_sowing_date_tz.csv',header=T)
dd2<-t(dd) ## make the matrix [lon,lat]. dd1 is [lat,lon]
dd3<-dd2[ ,c(seq(12,1,-1))]  ## reorder long to start from lower
dd4<-dd3[2:13,]
## convert the matrix dd2 from 0.25 deg res to 0.05 res
## the function fit_new_dim1 uses 3d matrix. So, addd a singleton dim 
dd5<-InsertDim(dd4,3,1)

## the function needs a 3d matrix of the intended dim
plt<-matrix(runif(48841,3,4),nrow=221) ## to comply with fit_new_dim1.R, make 201 columns eventhough we need 196 only.
## remove 5 unnecessary columns later.
plt1<-InsertDim(plt,3,1)
## part 2: change dim
source('//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/functions_bc/fit_new_dim1.R')
plt2<-fit_new_dim1(mod=dd5, obs=plt1)
plt3<-drop(plt2)
saveRDS(plt3,'//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/dssat_input/sow_date_tanz.RDS')
