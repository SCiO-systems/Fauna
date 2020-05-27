for cn in "Ethiopia" "Tanzania" "Uganda"
do
for var in "pr" "tasmax" "tasmin" "rsds"
#for var in "tasmin"
do

dir='//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/'

echo ${cn}_${var}

cdo mergetime ${dir}${cn}/ec_9110/*${var}_Amon_EC-Earth3-Veg_historical_r1i1p1f1_${cn:0:4}_*.nc ${dir}${cn}/${var}_Amon_EC-Earth3-Veg_historical_r1i1p1f1_${cn:0:4}_199101-201012.nc

done
done
