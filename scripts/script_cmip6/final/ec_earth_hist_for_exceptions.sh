#!/bin/bash
#for var in "tasmax" "tasmin" "rsds"
for var in "tasmax"
   do
  #for yr in $(seq 1995 2014)  
for yr in "1999" "2006"
   do

cat > mygrid << EOF
gridtype = lonlat
xsize    = 480
ysize    = 240
xfirst   = 0.125
xinc     = 0.75
yfirst   = -89.875
yinc     = 0.75
EOF

dir='//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/'

cdo remapbil,mygrid //dapadfs/workspace_cluster_13/ADAA/CMIP6/raw/${var}_Amon_EC-Earth3-Veg_historical_r1i1p1f1_gr_${yr}01-${yr}12.nc ${dir}${var}_Amon_EC-Earth3-Veg_historical_r1i1p1f1_${yr}01-${yr}12.nc 

#cdo sellonlatbox,27.8,41.5,-12.8,1.6 ${dir}${var}_Amon_EC-Earth3-Veg_historical_r1i1p1f1_${yr}01-${yr}12.nc ${dir}Tanzania/ec_9514/${var}_Amon_EC-Earth3-Veg_historical_r1i1p1f1_Tanz_${yr}01-${yr}12.nc
cdo sellonlatbox,28.4,36.2,-4,6 ${dir}${var}_Amon_EC-Earth3-Veg_historical_r1i1p1f1_${yr}01-${yr}12.nc ${dir}Uganda/ec_9514/${var}_Amon_EC-Earth3-Veg_historical_r1i1p1f1_Ugan_${yr}01-${yr}12.nc
#cdo sellonlatbox,32.7,49.2,2,16.1 ${dir}${var}_Amon_EC-Earth3-Veg_historical_r1i1p1f1_${yr}01-${yr}12.nc ${dir}Ethiopia/ec_9514/${var}_Amon_EC-Earth3-Veg_historical_r1i1p1f1_Ethi_${yr}01-${yr}12.nc

rm ${dir}${var}_Amon_EC-Earth3-Veg_historical_r1i1p1f1_${yr}01-${yr}12.nc

done
done


