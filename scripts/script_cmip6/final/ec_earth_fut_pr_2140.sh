#!/bin/bash
for var in "pr"
do  
 for sc in "ssp126" "ssp245" "ssp370" "ssp585"
    do
      #for yr in $(seq 2021 2040)
       for yr in 2038
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

dir='//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/'

cdo remapcon2,mygrid //dapadfs/workspace_cluster_13/ADAA/CMIP6/raw/${var}_Amon_EC-Earth3-Veg_${sc}_r1i1p1f1_gr_${yr}01-${yr}12.nc ${dir}${var}_Amon_EC-Earth3-Veg_${sc}_r1i1p1f1_${yr}01-${yr}12.nc 

cdo sellonlatbox,31.75,50,1.25,15.15 ${dir}${var}_Amon_EC-Earth3-Veg_${sc}_r1i1p1f1_${yr}01-${yr}12.nc ${dir}Ethiopia/2030/2140_new/${var}_Amon_EC-Earth3-Veg_${sc}_r1i1p1f1_Ethi_${yr}01-${yr}12.nc
cdo sellonlatbox,26.8,42.5,-14,2 ${dir}${var}_Amon_EC-Earth3-Veg_${sc}_r1i1p1f1_${yr}01-${yr}12.nc ${dir}Tanzania/2030/2140_new/${var}_Amon_EC-Earth3-Veg_${sc}_r1i1p1f1_Tanz_${yr}01-${yr}12.nc
cdo sellonlatbox,27.45,37.2,-4,7 ${dir}${var}_Amon_EC-Earth3-Veg_${sc}_r1i1p1f1_${yr}01-${yr}12.nc ${dir}Uganda/2030/2140_new/${var}_Amon_EC-Earth3-Veg_${sc}_r1i1p1f1_Ugan_${yr}01-${yr}12.nc

rm ${dir}${var}_Amon_EC-Earth3-Veg_${sc}_r1i1p1f1_${yr}01-${yr}12.nc

done
done
done

