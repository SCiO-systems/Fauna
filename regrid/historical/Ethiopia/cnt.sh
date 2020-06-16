for var in 'tasmax' 'tasmin' 'rsds'
do
  cdo mergetime ${var}_Amon_GFDL-ESM4_historical_r1i1p1f1_re_gr1_Ethi_185001-194912.nc ${var}_Amon_GFDL-ESM4_historical_r1i1p1f1_re_gr1_Ethi_195001-201412.nc ${var}_Amon_GFDL-ESM4_historical_r1i1p1f1_re_gr1_Ethi_185001-201412.nc 
done

