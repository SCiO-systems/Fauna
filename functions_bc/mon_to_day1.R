### Function to make the monthly data to daily from 1981 to 2010
## var is the model monthly data in [lat, lon, month] dim and var_obs is the daily obs data in [Lat, Lon, day]

mon_to_day1<-function(var, var_obs) {
    dimen<-dim(var_obs)
var_f_dly<-array(numeric(),dim=dimen)

for (i in 1:dimen[1]){
   for (j in 1:dimen[2]) {
    m1<-rep(var[i,j,1], each=31); m2<-rep(var[i,j,2], each=28)
    m22<-rep(var[i,j,2], each=29)
    m3<-rep(var[i,j,3], each=31); m4<-rep(var[i,j,4], each=30)
    m5<-rep(var[i,j,5], each=31); m6<-rep(var[i,j,6], each=30)
    m7<-rep(var[i,j,7], each=31); m8<-rep(var[i,j,8], each=31)
    m9<-rep(var[i,j,9], each=30); m10<-rep(var[i,j,10], each=31)
    m11<-rep(var[i,j,11], each=30); m12<-rep(var[i,j,12], each=31)

      yr1<-c(m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12)
      yr2<-c(m1,m22,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12)

      #days<-c(yr1,yr1,yr1,yr2,yr1,yr1,yr1,yr2,yr1,yr1,yr1,yr2,yr1,yr1,yr1,yr2,yr1,yr1,yr1,yr2,yr1,yr1,yr1,
       # yr2,yr1,yr1,yr1,yr2,yr1,yr1)
		
		days<-c(yr1,yr2,yr1,yr1,yr1,yr2,yr1,yr1,yr1,yr2,yr1,yr1,yr1,
        yr2,yr1,yr1,yr1,yr2,yr1,yr1) ## now from 91

      var_f_dly[i,j, ]<-days 
                }
       }
return(var_f_dly)  
}