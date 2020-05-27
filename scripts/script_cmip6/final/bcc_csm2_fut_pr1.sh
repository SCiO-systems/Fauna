#!/bin/bash
for var in "pr"
   do
    for mod in "BCC-CSM2-MR" "MRI-ESM2-0"
     do
      for sc in "ssp126" "ssp245" "ssp370" "ssp585"
       do

cat > mygrid << EOF
gridtype = lonlat
xsize    = 288
ysize    = 144
xfirst   = 0.125
xinc     = 1.25
yfirst   = -89.875
yinc     = 1.25
EOF

dir='//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/'

cdo remapcon2,mygrid //dapadfs/workspace_cluster_13/ADAA/CMIP6/raw/${var}_Amon_${mod}_${sc}_r1i1p1f1_gn_201501-210012.nc ${dir}${var}_Amon_${mod}_${sc}_r1i1p1f1_201501-210012.nc

cdo sellonlatbox,31.75,50,1.25,15.15 ${dir}${var}_Amon_${mod}_${sc}_r1i1p1f1_201501-210012.nc ${dir}Ethiopia/${var}_Amon_${mod}_${sc}_r1i1p1f1_Ethi_201501-210012.nc
#cdo sellonlatbox,26.8,42.5,-14,2 ${dir}${var}_Amon_${mod}_${sc}_r1i1p1f1_201501-210012.nc ${dir}Tanzania/${var}_Amon_${mod}_${sc}_r1i1p1f1_Tanz_201501-210012.nc
#cdo sellonlatbox,27.45,37.2,-4,7 ${dir}${var}_Amon_${mod}_${sc}_r1i1p1f1_201501-210012.nc ${dir}Uganda/${var}_Amon_${mod}_${sc}_r1i1p1f1_Ugan_201501-210012.nc

rm ${dir}${var}_Amon_${mod}_${sc}_r1i1p1f1_201501-210012.nc

done
done
done





