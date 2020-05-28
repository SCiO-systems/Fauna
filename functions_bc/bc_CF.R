## Bias correction for each day using Change factor method Hawkins et al. (2013)
bc_CF<-function(fut_av,hist_av,std_fut,std_hist,obs){

dimen<-dim(obs)
var_bc_da<-array(numeric(),dim=dimen)
for (i in 1:dimen[1]){
  for(j in 1:dimen[2]){
    for (k in 1:dimen[3]){
var_bc_da[i,j,k]<-fut_av[i,j,k]+(std_fut[i,j,k]/std_hist[i,j,k])*(obs[i,j,k]-hist_av[i,j,k])
    }
  }
}
return(var_bc_da)
}