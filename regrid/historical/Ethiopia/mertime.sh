for cn in "Ethiopia" "Tanzania" "Uganda"
do
for var in "pr" "tasmax" "tasmin" "rsds"
do

dir='//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/'
cdo mergetime ${dir}${cn}/ec_9514/*${var}_Amon_EC-Earth3-Veg_historical_r1i1p1f1_${cn:0:4}_*.nc ${dir}${cn}/${var}_Amon_EC-Earth3-Veg_historical_r1i1p1f1_${cn:0:4}_199501-201412.nc

done
done
