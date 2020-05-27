#!/bin/bash
for var in "pr" "tasmax" "tasmin" "rsds"
 do
  for mod in "canESM5"
   do  
    for sc in "historical"
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
                          
cdo remapcon,mygrid ../${var}_Amon_${mod}_${sc}_r1i1p1f1_gn_185001-201412.nc //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/${var}_Amon_${mod}_${sc}_r1i1p1f1_re_gn_185001-201412.nc

#cdo sellonlatbox,27.8,41.5,-12.8,1.6 //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/${var}_Amon_${mod}_${sc}_r1i1p1f1_re_gn_185001-201412.nc //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/Tanzania/${var}_Amon_${mod}_${sc}_r1i1p1f1_re_gn_Tanz_185001-201412.nc

#cdo sellonlatbox,28.4,36.2,-2.5,5.2 //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/${var}_Amon_${mod}_${sc}_r1i1p1f1_re_gn_185001-201412.nc //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/Uganda/${var}_Amon_${mod}_${sc}_r1i1p1f1_re_gn_Ugan_185001-201412.nc

cdo sellonlatbox,32.7,49.2,2,16.1 //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/${var}_Amon_${mod}_${sc}_r1i1p1f1_re_gn_185001-201412.nc //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/Ethiopia/${var}_Amon_${mod}_${sc}_r1i1p1f1_re_gn_Ethi_185001-201412.nc

rm //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/${var}_Amon_${mod}_${sc}_r1i1p1f1_re_gn_185001-201412.nc

done
done
done

