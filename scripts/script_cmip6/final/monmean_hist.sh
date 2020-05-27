#!/bin/bash
for cn in "Ethiopia" "Tanzania" "Uganda"
#for cn in "Ethiopia"
do
for var in "pr" "tasmax" "tasmin" "rsds"
   do
for mod in "BCC-CSM2-MR" "EC-Earth3-Veg" "GFDL-ESM4" "IPSL-CM6A-LR" "MIROC6" "MRI-ESM2-0"
#for mod in "BCC-CSM2-MR" "MRI-ESM2-0"
do

dir='//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/'
pd='199101-201012' 

#cdo timmean ${dir}${cn}/${var}_Amon_${mod}_historical_r1i1p1f1_${cn:0:4}_${pd}.nc ${dir}${cn}/timmean/${var}_Amon_${mod}_historical_r1i1p1f1_${cn:0:4}_climate_${pd}.nc
#cdo ymonmean ${dir}${cn}/${var}_Amon_${mod}_historical_r1i1p1f1_${cn:0:4}_${pd}.nc ${dir}${cn}/monmean/${var}_Amon_${mod}_historical_r1i1p1f1_${cn:0:4}_monmean_${pd}.nc
cdo ymonstd ${dir}${cn}/${var}_Amon_${mod}_historical_r1i1p1f1_${cn:0:4}_${pd}.nc ${dir}${cn}/monstd/${var}_Amon_${mod}_historical_r1i1p1f1_${cn:0:4}_monstd_${pd}.nc
#echo ${dir}${cn}/${var}_Amon_${mod}_historical_r1i1p1f1_${cn:0:4}_${pd}.nc
done
done
done

