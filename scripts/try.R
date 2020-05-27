library(Dasst)
dir<-'//dapadfs/workspace_cluster_12/AVISA/dssat_outputs/ethiopia/dssat_runs_ethiopia1_BCC-CSM2-MR_ssp_585_2050_2230/'
grids <- 22030:22033

## 1. 
evaluate<-list()

for (i in 1:length(grids)){
  if(!file.exists(paste0(dir,grids[i],'/Evaluate.OUT'))) {
    evaluate[[i]]<-NA
  } else {
  a<-read.dssat(paste0(dir,grids[i],'/Evaluate.OUT'))
  evaluate[[i]]<-a[[1]]
  }
}


## work tomorrow on how to store 20 dataframes in a list
## 2. ETPhot 
# ET<-list()
# ETPhot<-list()
#var<-c('ET','ETPhot')

ET<-list()
 for (i in 1:length(grids)){
     if(!file.exists(paste0(dir,grids[i],'/ET.OUT'))) {
    ET[[i]]<-NA
  } else {
    a<-read.dssat(paste0(dir,grids[i],'/ET.OUT'))
    ET[[i]]<-a ## to extract ET for 1st year: ## head(vari[[2]][[1]]); 20th year: head(vari[[2]][[20]])
  }
 }




                            

plantgro <- read.dssat(paste0(dir, grids[[i]],"/SoilWat.OUT"))


## to read Warning type of list files
x<-list()
for (i in 1:length(grids)){
if(!file.exists(paste0(dir,grids[i],'/WARNING.OUT'))) {
  x[[i]]<-NA
} else {
  x[[i]]<- scan(paste0(dir, grids[[i]],"/WARNING.OUT"), what="", sep="\n")
  }
}

  
  
