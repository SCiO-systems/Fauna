#!/bin/bash
for var in "tasmax" "tasmin" "rsds"
do
for sc in "ssp126" "ssp245" "ssp370" "ssp585"
do
cat > mygrid << EOF
gridtype = lonlat
xsize    = 240
ysize    = 120
xfirst   = 0.1
xinc     = 1.5
yfirst   = -89.875
yinc     = 1.5
EOF

dir='//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/'
dir1='//dapadfs/workspace_cluster_13/ADAA/CMIP6/raw/'

cdo remapbil,mygrid ${dir1}/${var}_Amon_MIROC6_${sc}_r1i1p1f1_gn_201501-210012.nc ${dir}${var}_Amon_MIROC6_${sc}_r1i1p1f1_201501-210012.nc

#cdo sellonlatbox,31.75,50,1.25,15.15 ${dir}${var}_Amon_MIROC6_${sc}_r1i1p1f1_201501-210012.nc ${dir}Ethiopia/${var}_Amon_MIROC6_${sc}_r1i1p1f1_Ethi_201501-210012.nc
#cdo sellonlatbox,26.8,42.5,-14,2 ${dir}${var}_Amon_MIROC6_${sc}_r1i1p1f1_201501-210012.nc ${dir}Tanzania/${var}_Amon_MIROC6_${sc}_r1i1p1f1_Tanz_201501-210012.nc
cdo sellonlatbox,27.45,37.2,-4,7 ${dir}${var}_Amon_MIROC6_${sc}_r1i1p1f1_201501-210012.nc ${dir}Uganda/${var}_Amon_MIROC6_${sc}_r1i1p1f1_Ugan_201501-210012.nc

rm ${dir}${var}_Amon_MIROC6_${sc}_r1i1p1f1_201501-210012.nc

done
done

