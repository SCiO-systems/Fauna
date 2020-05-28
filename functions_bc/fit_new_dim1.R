fit_new_dim1 <- function(mod, obs){
source('//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/functions_bc/change_dim.R')
dim1<-dim(obs)
dim2<-dim(mod[ , ,1])
fact1<-(dim1[1]-1)/(dim2[1]-1)
fact2<-(dim1[2]-1)/(dim2[2]-1)

var_h6<-array(numeric(),dim=c(dim1[1],dim1[2],dim1[3]))

for (i in 1:dim1[3]){
  var_h3<-mod[1:(nrow(mod)-1),1:(ncol(mod)-1),i]
  
  var_h4<-change_dim(var_h3,dim_output = c(nrow(var_h3)*fact1, ncol(var_h3)*fact2))
  dimn<-dim(var_h4)
  
  odd_lon_var_h2<-matrix(rep(mod[ ,ncol(mod),i],each=fact1)[1:(dim1[1]-1)],nrow=(dim1[1]-1))
  odd_lat_var_h2<-matrix(rep(mod[nrow(mod), ,i],each=fact2)[1:dim1[2]],nrow = 1)
  
  var_h5<-cbind(var_h4,odd_lon_var_h2)
  var_h6[ , ,i]<-rbind(var_h5,odd_lat_var_h2)
}
return(var_h6)
}  