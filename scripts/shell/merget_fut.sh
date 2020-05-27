for var in "pr" "rsds" "tasmax" "tasmin"
 do
  for sc in "ssp126" "ssp245" "ssp370" "ssp585"
   do
cdo mergetime *${var}_Amon_EC-Earth3-Veg_${sc}_r1i1p1f1*.nc ${var}_Amon_EC-Earth3-Veg_${sc}_r1i1p1f1_EAF_gr_201601-210012.nc
done
done
