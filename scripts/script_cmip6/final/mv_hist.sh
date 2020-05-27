#!/bin/bash
for cn in "Ethiopia" "Tanzania" "Uganda"
do
for var in "pr" "tasmax" "tasmin" "rsds"
do
for mod in "BCC-CSM2-MR" "GFDL-ESM4" "IPSL-CM6A-LR" "MIROC6" "MRI-ESM2-0" "EC-Earth3-Veg"
do

dir='//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/'
pd='199501-201412' 

mv ${var}_Amon_${mod}_historical_r1i1p1f1_${cn:0:4}_monmean_${pd}.nc ${dir}${cn}/monmean/
mv ${var}_Amon_${mod}_historical_r1i1p1f1_${cn:0:4}_monstd_${pd}.nc ${dir}${cn}/monstd/

#echo ${dir}${cn}/${var}_Amon_${mod}_historical_r1i1p1f1_${cn:0:4}_${pd}.nc
done
done
done

