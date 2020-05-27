#for cn in "Ethiopia" "Tanzania" "Uganda"
for cn in "Ethiopia"
do
#for var in "tasmax" "tasmin" "rsds"
for var in "rsds"
do
#for mod in "BCC-CSM2-MR" "EC-Earth3-Veg" "GFDL-ESM4" "IPSL-CM6A-LR" "MIROC6" "MRI-ESM2-0" 
for mod in "MRI-ESM2-0"
do
#for sc in "ssp126" "ssp245" "ssp370" "ssp585"
for sc in "ssp585"
do
dir='//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_bc/'
cdo monmean ${dir}${cn}/2030/nc/time/${var}_Amon_${mod}_${sc}_r1i1p1f1_${cn:0:4}_bc_202101-204012.time.nc ${dir}${cn}/2030/nc/mnmean/${var}_Amon_${mod}_${sc}_r1i1p1f1_${cn:0:4}_bc_202101-204012.mnmean.nc

cdo monmean ${dir}${cn}/2050/nc/time/${var}_Amon_${mod}_${sc}_r1i1p1f1_${cn:0:4}_bc_204101-206012.time.nc ${dir}${cn}/2050/nc/mnmean/${var}_Amon_${mod}_${sc}_r1i1p1f1_${cn:0:4}_bc_204101-206012.mnmean.nc

done
done
done
done
