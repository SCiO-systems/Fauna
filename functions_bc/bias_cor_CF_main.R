## This is the main function to correct bias using Change factor method of Hawkins.
#Inputs: 
### Monthly mean and stdev of variable over historical and future period in the resolution of a model.
### Matrix dim of the above 4 variables will be [lat, Lon, 12]
##  Var_obs is the daily data in a relatively higher resolution than the model data. 

## Process: 
## This function first converts coarse resolution of the model into resolution of obs by repeating.
## Then, it makes monthly data to daily by repeating.
## Finally it uses daily values of model and obs in the same resolution to bias correct model data.

bias_cor_CF_main<-function(var_fut_av, var_fut_std, var_hist_av, var_hist_std, var_obs) {    

source('//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/functions_bc/fit_new_dim.R')

## change each var to new dim
var_fut_av_new<-fit_new_dim(mod=var_fut_av, obs=var_obs[ , ,1])
var_fut_std_new<-fit_new_dim(mod=var_fut_std, obs=var_obs[ , ,1])
var_h_av_new<-fit_new_dim(mod=var_hist_av, obs=var_obs[ , ,1])
var_h_std_new<-fit_new_dim(mod=var_hist_std, obs=var_obs[ , ,1])

###### ####
## 3. Now make mon average to daily by repeating same values within that month. 
source('//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/functions_bc/mon_to_day.R')
var_fut_av_daily<-mon_to_day(var=var_fut_av_new,var_obs=var_obs)
var_fut_std_daily<-mon_to_day(var=var_fut_std_new,var_obs=var_obs)
var_h_av_daily<-mon_to_day(var=var_h_av_new,var_obs=var_obs)
var_h_std_daily<-mon_to_day(var=var_h_std_new,var_obs=var_obs)

## Bias correct var
source('//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/functions_bc/bc_CF.R')

var_bc_CF<-bc_CF(fut_av=var_fut_av_daily, hist_av=var_h_av_daily,std_fut=var_fut_std_daily,
                    std_hist=var_h_std_daily,obs=var_obs) 
return(var_bc_CF)
}