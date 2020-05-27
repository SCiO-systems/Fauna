#!/bin/bash
for var in "tasmax" "tasmin" "rsds"
   do
  for sc in "ssp126" "ssp245" "ssp370" "ssp585"
      do

cat > mygrid << EOF
gridtype = lonlat
xsize    = 144
ysize    = 144
xfirst   = 0.125
xinc     = 1.25
yfirst   = -89.875
yinc     = 1.25
EOF

dir='//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/'

cdo remapbil,mygrid //dapadfs/workspace_cluster_13/ADAA/CMIP6/raw/${var}_Amon_IPSL-CM6A-LR_${sc}_r1i1p1f1_gr_201501-210012.nc ${dir}${var}_Amon_IPSL-CM6A-LR_${sc}_r1i1p1f1_201501-210012.nc

#cdo sellonlatbox,27.8,41.5,-12.8,1.6 ${dir}${var}_Amon_IPSL-CM6A-LR_${sc}_r1i1p1f1_201501-210012.nc ${dir}Tanzania/${var}_Amon_IPSL-CM6A-LR_${sc}_r1i1p1f1_Tanz_201501-210012.nc
cdo sellonlatbox,28.4,36.2,-4,6 ${dir}${var}_Amon_IPSL-CM6A-LR_${sc}_r1i1p1f1_201501-210012.nc ${dir}Uganda/${var}_Amon_IPSL-CM6A-LR_${sc}_r1i1p1f1_Ugan_201501-210012.nc
#cdo sellonlatbox,32.7,49.2,2,16.1 ${dir}${var}_Amon_IPSL-CM6A-LR_${sc}_r1i1p1f1_201501-210012.nc ${dir}Ethiopia/${var}_Amon_IPSL-CM6A-LR_${sc}_r1i1p1f1_Ethi_201501-210012.nc

rm ${dir}${var}_Amon_IPSL-CM6A-LR_${sc}_r1i1p1f1_201501-210012.nc

done
done

