for cn in "Tanzania"
do
for var in 'rsds' 'tasmax' 'tasmin'
do
for mod in "BCC-CSM2-MR" "EC-Earth3-Veg" "GFDL-ESM4" "IPSL-CM6A-LR" "MIROC6" "MRI-ESM2-0"
do
for sc in "ssp126" "ssp245" "ssp370" "ssp585"
do
dir='//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_bc/'
#echo ${dir}${cn}/2030/nc/${var}_Amon_${mod}_${sc}_r1i1p1f1_${cn:0:4}_bc_202101-204012.nc
cdo settaxis,2021-01-01,00:00:00,1days ${dir}${cn}/2030/nc/${var}_Amon_${mod}_${sc}_r1i1p1f1_${cn:0:4}_bc_202101-204012.nc ${dir}${cn}/2030/nc/time/${var}_Amon_${mod}_${sc}_r1i1p1f1_${cn:0:4}_bc_202101-204012.time.nc

cdo settaxis,2041-01-01,00:00:00,1days ${dir}${cn}/2050/nc/${var}_Amon_${mod}_${sc}_r1i1p1f1_${cn:0:4}_bc_204101-206012.nc ${dir}${cn}/2050/nc/time/${var}_Amon_${mod}_${sc}_r1i1p1f1_${cn:0:4}_bc_204101-206012.time.nc
done
done
done
done


