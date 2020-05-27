#!/bin/bash
for cn in "Ethiopia" "Tanzania" "Uganda"
do
for var in "pr" "tasmax" "tasmin" "rsds"
do
#for mod in "BCC-CSM2-MR" "GFDL-ESM4" "IPSL-CM6A-LR" "MIROC6" "MRI-ESM2-0"
for mod in "EC-Earth3-Veg"
do
for sc in "ssp126" "ssp245" "ssp370" "ssp585"
do

dir='//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/'

rm ${dir}${cn}/2030/2140/${var}_Amon_${mod}_${sc}_r1i1p1f1_monmean_${cn:0:4}_202101-204012.nc 
rm ${dir}${cn}/2030/2140/${var}_Amon_${mod}_${sc}_r1i1p1f1_monstd_${cn:0:4}_202101-204012.nc 
rm ${dir}${cn}/2060/4160/${var}_Amon_${mod}_${sc}_r1i1p1f1_monmean_${cn:0:4}_204101-206012.nc 
rm ${dir}${cn}/2060/4160/${var}_Amon_${mod}_${sc}_r1i1p1f1_monstd_${cn:0:4}_204101-206012.nc 

done
done
done
done

