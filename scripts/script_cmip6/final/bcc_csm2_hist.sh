#!/bin/bash
for var in "tasmax" "tasmin" "rsds"
   do
    for mod in "BCC-CSM2-MR" "MRI-ESM2-0"
         do
   
cat > mygrid << EOF
gridtype = lonlat
xsize    = 288
ysize    = 144
xfirst   = 0.1
xinc     = 1.25
yfirst   = -89.85
yinc     = 1.25
EOF

dir='//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/'
dir1='//dapadfs/workspace_cluster_13/ADAA/CMIP6/raw'

cdo remapbil,mygrid ${dir1}/${var}_Amon_${mod}_historical_r1i1p1f1_gn_185001-201412.nc ${dir}${var}_Amon_${mod}_historical_r1i1p1f1_185001-201412.nc
cdo selyear,1991/2010 ${dir}${var}_Amon_${mod}_historical_r1i1p1f1_185001-201412.nc ${dir}${var}_Amon_${mod}_historical_r1i1p1f1_199101-201012.nc

rm ${dir}${var}_Amon_${mod}_historical_r1i1p1f1_185001-201412.nc

cdo sellonlatbox,31.75,50,1.25,15.5 ${dir}${var}_Amon_${mod}_historical_r1i1p1f1_199101-201012.nc ${dir}Ethiopia/${var}_Amon_${mod}_historical_r1i1p1f1_Ethi_199101-201012.nc
#cdo sellonlatbox,26.8,42.5,-14,2 ${dir}${var}_Amon_${mod}_historical_r1i1p1f1_199101-201012.nc ${dir}Tanzania/${var}_Amon_${mod}_historical_r1i1p1f1_Tanz_199101-201012.nc
#cdo sellonlatbox,27.45,37.2,-4,7 ${dir}${var}_Amon_${mod}_historical_r1i1p1f1_199101-201012.nc ${dir}Uganda/${var}_Amon_${mod}_historical_r1i1p1f1_Ugan_199101-201012.nc


rm ${dir}${var}_Amon_${mod}_historical_r1i1p1f1_199101-201012.nc

done
done






