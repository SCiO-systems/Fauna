#for cn in "Ethiopia" "Tanzania" "Uganda"
for cn in "Ethiopia" "Tanzania"
do
for yr in $(seq 1995 2014)
do
#for var in "pr" "tasmax" "tasmin" "rsds"
for var in "pr"
do
dir='//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/'
#cp ${dir}${cn}/${var}_Amon_EC-Earth3-Veg_historical_r1i1p1f1_${cn:0:4}_${yr}01-${yr}12.nc ${dir}${cn}/ec_9514
rm ${dir}${cn}/${var}_Amon_EC-Earth3-Veg_historical_r1i1p1f1_${cn:0:4}_${yr}01-${yr}12.nc
done
done
done
