#!/bin/bash
for var in "pr" "tasmax" "tasmin" "rsds"
 do
  for sc in "ssp126" "ssp245" "ssp370" "ssp585"
    do

cat > mygrid << EOF
gridtype = lonlat
xsize    = 288
ysize    = 144
xfirst   = 0.1
xinc     = 1.25
yfirst   = -89.85
yinc     = 1.0
EOF


cdo remapcon,mygrid ../${var}_Amon_MRI-ESM2-0_${sc}_r1i1p1f1_gn_201501-210012.nc //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/${var}_Amon_MRI-ESM2-0_${sc}_r1i1p1f1_re_gn_201501-210012.nc

cdo sellonlatbox,27.8,41.5,-12.8,1.6 //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/${var}_Amon_MRI-ESM2-0_${sc}_r1i1p1f1_re_gn_201501-210012.nc //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/Tanzania/${var}_Amon_MRI-ESM2-0_${sc}_r1i1p1f1_re_gn_Tanz_201501-210012.nc

cdo sellonlatbox,28.4,36.2,-2.5,5.2 //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/${var}_Amon_MRI-ESM2-0_${sc}_r1i1p1f1_re_gn_201501-210012.nc //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/Uganda/${var}_Amon_MRI-ESM2-0_${sc}_r1i1p1f1_re_gn_Ugan_201501-210012.nc

cdo sellonlatbox,32.7,49.2,2,16.1 //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/${var}_Amon_MRI-ESM2-0_${sc}_r1i1p1f1_re_gn_201501-210012.nc //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/Ethiopia/${var}_Amon_MRI-ESM2-0_${sc}_r1i1p1f1_re_gn_Ethi_201501-210012.nc

rm //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/${var}_Amon_MRI-ESM2-0_${sc}_r1i1p1f1_re_gn_201501-210012.nc

done
done


