for var in 'rsds' 'tasmax' 'tasmin'
do
for mod in 'BCC-CSM2-MR' 'EC-Earth3-Veg' 'GFDL-ESM4' 'IPSL-CM6A-LR' 'MIROC6' 'MRI-ESM2-0'
do
for sc in "ssp126" "ssp245" "ssp370" "ssp585"
do
path='//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_bc/Ethiopia/'

cdo settaxis,1981-01-01,12:00:00,1days ${path}2030/nc/${var}_Amon_${mod}_${sc}_r1i1p1f1_re_gn_Ethi_bc_201501-204412.nc ${path}2030/nc1/${var}_Amon_${mod}_${sc}_r1i1p1f1_re_gn_Ethi_bc_201501-204412.nc

cdo settaxis,1981-01-01,12:00:00,1days ${path}2060/nc/${var}_Amon_${mod}_${sc}_r1i1p1f1_re_gn_Ethi_bc_204501-207412.nc ${path}2060/nc1/${var}_Amon_${mod}_${sc}_r1i1p1f1_re_gn_Ethi_bc_204501-207412.nc

#cdo monmean 2030/nc1/${var}_Amon_${mod}_${sc}_r1i1p1f1_re_gn_Ethi_bc_201501-204412.nc 2030/nc1/mnmean/${var}_Amon_${mod}_${sc}_r1i1p1f1_re_gn_Ethi_bc_mnmean_201501-204412.nc

#cdo monmean 2060/nc1/${var}_Amon_${mod}_${sc}_r1i1p1f1_re_gn_Ethi_bc_204501-207412.nc 2060/nc1/mnmean/${var}_Amon_${mod}_${sc}_r1i1p1f1_re_gn_Ethi_bc_mnmean_204501-207412.nc

done
done
done
