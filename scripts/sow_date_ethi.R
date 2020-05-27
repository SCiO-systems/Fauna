library(s2dverification)
ln<-seq(from=33.025,to=43.025,by=0.05)
lt<-seq(from=3.025, to=13.025,by=0.05)
dd<-read.csv('//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/scripts/final_sowing_date_et.csv',header=T)
dd_t<-t(dd)
dd_t1<-dd_t[,c(seq(11,1,-1))]
dd_t2<-dd_t1[2:12,] ## select columns until 47.1 long only
## convert the matrix dd_t2 to 0.05 deg res
## the function fit_new_dim1 uses 3d matrix. So, addd a singleton dim 
dd3<-InsertDim(dd_t2,3,1)

## the function needs a 3d matrix of the intended dim
plt<-matrix(runif(40401,3,4),nrow=201)
plt1<-InsertDim(plt,3,1)
## part 2: change dim
source('//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/functions_bc/fit_new_dim1.R')
plt2<-fit_new_dim1(mod=dd3, obs=plt1)
plt3<-drop(plt2)
saveRDS(plt3,'//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/dssat_input/sow_date_ethi.RDS')

