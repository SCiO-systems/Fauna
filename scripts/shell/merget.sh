#for var in "pr" "rsds" "tasmax" "tasmin"
for var in "pr"
 do
cdo mergetime *${var}_Amon_EC-Earth3-Veg_historical_r1i1p1f1*.nc ${var}_Amon_EC-Earth3-Veg_historical_r1i1p1f1_EAF_gr_185001-201412.nc
done
