#!/bin/bash
#for cn in "Ethiopia" "Tanzania" "Uganda"
for cn in "Tanzania"
do
for var in "tasmax" "tasmin" "rsds"
   do
    for mod in "BCC-CSM2-MR" "EC-Earth3-Veg" "GFDL-ESM4" "MIROC6" "MRI-ESM2-0"
     do
      
cat > mygrid << EOF
gridtype = lonlat
xsize    = 10
ysize    = 10
xfirst   = 27.625
xinc     = 1.5
yfirst   =-13.375
yinc     = 1.5
EOF

dir='//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/'

cdo remapbil,mygrid ${dir}${cn}/timmean/${var}_Amon_${mod}_historical_r1i1p1f1_${cn:0:4}_climate_199101-201012.nc ${dir}${cn}/timmean/interpolated/${var}_Amon_${mod}_historical_r1i1p1f1_${cn:0:4}_climate_199101-201012.nc

done
done
done

