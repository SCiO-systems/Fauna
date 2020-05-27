#!/bin/bash
for var in "pr" "tasmax" "tasmin" "rsds"
 do
  for sc in "ssp126" "ssp245" "ssp370" "ssp585"
    do
#cdo sellonlatbox,28.3,48.3,-12,15.3 ${var}_Amon_MIROC6_${sc}_r1i1p1f1_gn_201501-210012.nc //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/${var}_Amon_MIROC6_${sc}_r1i1p1f1_gn_201501-210012.nc

mv ${var}_Amon_MIROC6_${sc}_r1i1p1f1_gn_201501-210012.nc ${var}_Amon_MIROC6_${sc}_r1i1p1f1_EAF_gn_201501-210012.nc
done
done
~
~

