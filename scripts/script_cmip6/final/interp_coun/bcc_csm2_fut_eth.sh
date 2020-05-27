#!/bin/bash
#for cn in "Ethiopia" "Tanzania" "Uganda"
for cn in "Ethiopia"
do
for var in "tasmax" "tasmin" "rsds"
   do
    for mod in "BCC-CSM2-MR" "EC-Earth3-Veg" "GFDL-ESM4" "MIROC6" "MRI-ESM2-0"
     do
      for sc in "ssp126" "ssp245" "ssp370" "ssp585"
              do

cat > mygrid << EOF
gridtype = lonlat
xsize    = 11
ysize    = 10
xfirst   = 32.625
xinc     = 1.5
yfirst   = 1.625
yinc     = 1.5
EOF

dir='//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/'

cdo remapbil,mygrid ${dir}${cn}/2030/timmean/${var}_Amon_${mod}_${sc}_r1i1p1f1_climate_${cn:0:4}_202101-204012.nc ${dir}${cn}/2030/timmean/interpolated/${var}_Amon_${mod}_${sc}_r1i1p1f1_climate_${cn:0:4}_202101-204012.nc
cdo remapbil,mygrid ${dir}${cn}/2060/timmean/${var}_Amon_${mod}_${sc}_r1i1p1f1_climate_${cn:0:4}_204101-206012.nc ${dir}${cn}/2060/timmean/interpolated/${var}_Amon_${mod}_${sc}_r1i1p1f1_climate_${cn:0:4}_204101-206012.nc

done
done
done
done

