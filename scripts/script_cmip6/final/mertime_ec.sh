#for cn in "Ethiopia" "Tanzania" "Uganda"
for cn in "Ethiopia"
do
for var in "pr" "tasmax" "tasmin" "rsds"
#for var in "pr"
do
for sc in "ssp126" "ssp245" "ssp370" "ssp585"
#for sc in "ssp126"
do
dir='//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/'

echo ${cn}${var}${sc}
cdo mergetime ${dir}${cn}/2030/2140_new/*${var}_Amon_EC-Earth3-Veg_${sc}_r1i1p1f1_${cn:0:4}_*.nc ${dir}${cn}/${var}_Amon_EC-Earth3-Veg_${sc}_r1i1p1f1_${cn:0:4}_202101-204012.nc
cdo mergetime ${dir}${cn}/2060/4160_new/*${var}_Amon_EC-Earth3-Veg_${sc}_r1i1p1f1_${cn:0:4}_*.nc ${dir}${cn}/${var}_Amon_EC-Earth3-Veg_${sc}_r1i1p1f1_${cn:0:4}_204101-206012.nc

#rm ${dir}${cn}/2030/2140_ec/*202101-204012*.nc
#rm ${dir}${cn}/2060/4160_ec/*204101-206012*.nc

done
done
done
