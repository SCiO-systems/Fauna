#!/bin/bash
for var in "pr"
#for var in "pr" "tasmax" "tasmin" "rsds"
   do
    for mod in "MRI-ESM2-0"
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

cdo remapcon,mygrid ../${var}_Amon_${mod}_historical_r1i1p1f1_gn_185001-201412.nc //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/${var}_Amon_${mod}_historical_r1i1p1f1_re_gn_185001-201412.nc

cdo sellonlatbox,27.8,41.5,-12.8,1.6 //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/${var}_Amon_${mod}_historical_r1i1p1f1_re_gn_185001-201412.nc //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/Tanzania/${var}_Amon_${mod}_historical_r1i1p1f1_re_gn_Tanz_185001-201412.nc

cdo sellonlatbox,28.4,36.2,-2.5,5.2 //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/${var}_Amon_${mod}_historical_r1i1p1f1_re_gn_185001-201412.nc //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/Uganda/${var}_Amon_${mod}_historical_r1i1p1f1_re_gn_Ugan_185001-201412.nc

cdo sellonlatbox,32.7,49.2,2,16.1 //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/${var}_Amon_${mod}_historical_r1i1p1f1_re_gn_185001-201412.nc //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/Ethiopia/${var}_Amon_${mod}_historical_r1i1p1f1_re_gn_Ethi_185001-201412.nc

rm //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/${var}_Amon_${mod}_historical_r1i1p1f1_re_gn_185001-201412.nc

done
done


