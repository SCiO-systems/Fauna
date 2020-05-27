#!/bin/bash
for var in "pr"
do

cat > mygrid << EOF
gridtype = lonlat
xsize    = 240
ysize    = 120
xfirst   = 0.125
xinc     = 1.5
yfirst   = -89.875
yinc     = 1.5
EOF

ti="195001-201412"
dir='//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/'
pd='199101-201012' 

cdo remapcon2,mygrid //dapadfs/workspace_cluster_13/ADAA/CMIP6/raw/${var}_Amon_MIROC6_historical_r1i1p1f1_gn_${ti}.nc ${dir}${var}_Amon_MIROC6_historical_r1i1p1f1_${ti}.nc
cdo selyear,1991/2010 ${dir}${var}_Amon_MIROC6_historical_r1i1p1f1_${ti}.nc ${dir}${var}_Amon_MIROC6_historical_r1i1p1f1_${pd}.nc
rm ${dir}${var}_Amon_MIROC6_historical_r1i1p1f1_${ti}.nc

cdo sellonlatbox,31.75,50,1.25,15.15 ${dir}${var}_Amon_MIROC6_historical_r1i1p1f1_${pd}.nc ${dir}Ethiopia/${var}_Amon_MIROC6_historical_r1i1p1f1_Ethi_${pd}.nc
cdo sellonlatbox,26.8,42.5,-14,2 ${dir}${var}_Amon_MIROC6_historical_r1i1p1f1_${pd}.nc ${dir}Tanzania/${var}_Amon_MIROC6_historical_r1i1p1f1_Tanz_${pd}.nc
cdo sellonlatbox,27.45,37.2,-4,7 ${dir}${var}_Amon_MIROC6_historical_r1i1p1f1_${pd}.nc ${dir}Uganda/${var}_Amon_MIROC6_historical_r1i1p1f1_Ugan_${pd}.nc

rm ${dir}${var}_Amon_MIROC6_historical_r1i1p1f1_${pd}.nc

done



