for var in "pr" "rsds" "tasmax" "tasmin"
 do
  for sc in "ssp126" "ssp245" "ssp370" "ssp585"
   do
 mv ${var}_Amon_IPSL-CM6A-LR_${sc}_r1i1p1f1_gr_201501-210012.nc ${var}_Amon_IPSL-CM6A-LR_${sc}_r1i1p1f1_EAF_gr_201501-210012.nc 
done
done
