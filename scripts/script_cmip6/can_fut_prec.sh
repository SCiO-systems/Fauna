#!/bin/bash
for var in "pr"
   do
    for sc in "ssp126" "ssp245" "ssp370" "ssp585"
            do
cat > mygrid << EOF
gridtype = lonlat
xsize    = 120
ysize    = 60
xfirst   = 0.1
xinc     = 3.0
yfirst   = -89.85
yinc     = 3.0
EOF

cdo remapcon,mygrid ../${var}_Amon_CanESM5_${sc}_r1i1p1f1_gn_201501-210012.nc //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/${var}_Amon_CanESM5_${sc}_r1i1p1f1_re_gn_201501-210012.nc

cdo sellonlatbox,27.8,41.5,-12.8,1.6 //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/${var}_Amon_CanESM5_${sc}_r1i1p1f1_re_gn_201501-210012.nc //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/Tanzania/${var}_Amon_CanESM5_${sc}_r1i1p1f1_re_gn_Tanz_201501-210012.nc

cdo sellonlatbox,28.4,36.2,-2.5,5.2 //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/${var}_Amon_CanESM5_${sc}_r1i1p1f1_re_gn_201501-210012.nc //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/Uganda/${var}_Amon_CanESM5_${sc}_r1i1p1f1_re_gn_Ugan_201501-210012.nc

cdo sellonlatbox,32.7,49.2,2,16.1 //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/${var}_Amon_CanESM5_${sc}_r1i1p1f1_re_gn_201501-210012.nc //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/Ethiopia/${var}_Amon_CanESM5_${sc}_r1i1p1f1_re_gn_Ethi_201501-210012.nc

rm //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/${var}_Amon_CanESM5_${sc}_r1i1p1f1_re_gn_201501-210012.nc

done
done


