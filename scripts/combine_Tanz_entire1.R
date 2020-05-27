rm(list=ls())
library(ncdf4)
library(abind)

dir<-'//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_bc/Tanzania/'

mod<-c('BCC-CSM2-MR','EC-Earth3-Veg','GFDL-ESM4','IPSL-CM6A-LR','MRI-ESM2-0')
ti<-c('2030','2050')
prd<-c('202101-204012', '204101-206012')
sc<-c("126","245","370","585")
var<-c('tasmax','tasmin','rsds')
var1<-c('tmx','tmin','srad')

## Loops for each variables
for (n in 1:5){ ## models
  for (k in 1:2){ ## 2030 or 2060?
    for (j in 1:4){ ## scenario
      
      pr<-readRDS(paste0(dir,'all/',ti[k],'/all_Tanz/precip/','pr_Amon_',mod[n],'_ssp',sc[j],'_r1i1p1f1_Tanz_bc_all_',prd[k],'.RDS'))
     
      dimen<-dim(pr)
      others<-array(numeric(), c(dimen[1],dimen[2],dimen[3],3))
      
      for (i in 1:3){ ### variables tmx, tmin and srad 
        dd<-readRDS(paste0(dir,ti[k],'/',var[i],'_Amon_',mod[n],'_ssp',sc[j],'_r1i1p1f1_Tanz_bc_',prd[k],'.RDS'))
        
        ## part 2: change tmx dim to prec dim
        source('//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/functions_bc/fit_new_dim1.R')
        others[ , , ,i]<-fit_new_dim1(mod=dd, obs=pr)
      }
      rm(dd)
      all<-abind(pr,others,along=4)
      rm(pr)
      rm(others)
      ## create directory
      dir.create(file.path(paste0(dir,'all/',ti[k],'/all_Tanz/all_var/'), showWarnings = FALSE))
      
      saveRDS(all,paste0(dir,'all/',ti[k],'/all_Tanz/all_var/','all_Amon_',mod[n],'_ssp',sc[j],'_r1i1p1f1_Tanz_bc_all_',prd[k],'.RDS'))
      rm(all)
    }
  }
}
q(save="no")
