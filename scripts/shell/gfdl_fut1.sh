#!/bin/bash
for var in "pr" "tasmax" "tasmin" "rsds"
 do
  for sc in "ssp126" "ssp245" "ssp370" "ssp585"
   do
mv ${var}_Amon_GFDL-ESM4_${sc}_r1i1p1f1_gr1_201501-210012.nc ${var}_Amon_GFDL-ESM4_${sc}_r1i1p1f1_EAF_gr1_201501-210012.nc
done
done
~
~

