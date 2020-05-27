#!/bin/bash
#for cn in "Ethiopia" "Tanzania" "Uganda"
for cn in "Uganda"
do
#for var in "pr" "tasmax" "tasmin" "rsds"
for var in "pr"
do
for mod in "BCC-CSM2-MR" "EC-Earth3-Veg" "GFDL-ESM4" "IPSL-CM6A-LR" "MIROC6" "MRI-ESM2-0"
#for mod in "EC-Earth3-Veg"
do
for sc in "ssp126" "ssp245" "ssp370" "ssp585"
#for sc in "ssp245"
do

dir='//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/'

cdo ymonmean ${dir}${cn}/2030/${var}_Amon_EC-Earth3-Veg_${sc}_r1i1p1f1_${cn:0:4}_202101-204012.nc ${dir}${cn}/2030/${var}_Amon_${mod}_${sc}_r1i1p1f1_monmean_${cn:0:4}_202101-204012.nc
#cdo ymonstd  ${dir}${cn}/2030/${var}_Amon_EC-Earth3-Veg_${sc}_r1i1p1f1_${cn:0:4}_202101-204012.nc ${dir}${cn}/2030/${var}_Amon_${mod}_${sc}_r1i1p1f1_monstd_${cn:0:4}_202101-204012.nc
cdo ymonmean ${dir}${cn}/2060/${var}_Amon_EC-Earth3-Veg_${sc}_r1i1p1f1_${cn:0:4}_204101-206012.nc ${dir}${cn}/2060/${var}_Amon_${mod}_${sc}_r1i1p1f1_monmean_${cn:0:4}_204101-206012.nc
#cdo ymonstd  ${dir}${cn}/2060/${var}_Amon_EC-Earth3-Veg_${sc}_r1i1p1f1_${cn:0:4}_204101-206012.nc ${dir}${cn}/2060/${var}_Amon_${mod}_${sc}_r1i1p1f1_monstd_${cn:0:4}_204101-206012.nc

done
done
done
done

