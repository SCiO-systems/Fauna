rm(list=ls())
library(Dasst)
dir<-'//dapadfs/workspace_cluster_12/AVISA/dssat_outputs/tanzania/'

## model
grids<- 37990:48841
x1<-array(numeric(),c(20, length(grids)))

for (i in 1:length(grids)){
  if(!file.exists(paste0(dir,'dssat_runs_tanzania_BCC-CSM2-MR_ssp_585_2050_37_48/',grids[i],'/Evaluate.OUT'))) {
    x1[ ,i]<-NA
  } else {
    x<-read.dssat(paste0(dir,'dssat_runs_tanzania_BCC-CSM2-MR_ssp_585_2050_37_48/',grids[i],'/Evaluate.OUT'))
    x1[ ,i]<-x[[1]][,14]
    rm(x)
  }
}

mod1_av<-apply(x1,c(2),mean)
saveRDS(mod1_av, paste0(dir,'yield_ethiopia_37990_48841_BCC-CSM2.RDS'))

q(save='no')