#!/bin/bash
for cn in "Ethiopia" "Tanzania" "Uganda"
do
#for var in "pr" "tasmax" "tasmin" "rsds"
for var in "pr"
do
for mod in "BCC-CSM2-MR" "EC-Earth3-Veg" "GFDL-ESM4" "IPSL-CM6A-LR" "MIROC6" "MRI-ESM2-0"
do
for sc in "ssp126" "ssp245" "ssp370" "ssp585"
do

dir='//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/'
dir1='//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/'
#cdo selyear,2021/2040 ${dir}${cn}/${var}_Amon_${mod}_${sc}_r1i1p1f1_${cn:0:4}_201501-210012.nc ${dir}${cn}/${var}_Amon_${mod}_${sc}_r1i1p1f1_${cn:0:4}_202101-204012.nc
#cdo selyear,2041/2060 ${dir}${cn}/${var}_Amon_${mod}_${sc}_r1i1p1f1_${cn:0:4}_201501-210012.nc ${dir}${cn}/${var}_Amon_${mod}_${sc}_r1i1p1f1_${cn:0:4}_204101-206012.nc
pd='199101-201012' 

#cdo sub ${dir}${cn}/2030/timmean/${var}_Amon_${mod}_${sc}_r1i1p1f1_climate_${cn:0:4}_202101-204012.nc ${dir1}${cn}/timmean/${var}_Amon_${mod}_historical_r1i1p1f1_${cn:0:4}_climate_${pd}.nc ${dir}${cn}/2030/climate_change/${var}_Amon_${mod}_${sc}_r1i1p1f1_${cn:0:4}_2030-history.nc 
#cdo sub ${dir}${cn}/2060/timmean/${var}_Amon_${mod}_${sc}_r1i1p1f1_climate_${cn:0:4}_204101-206012.nc ${dir1}${cn}/timmean/${var}_Amon_${mod}_historical_r1i1p1f1_${cn:0:4}_climate_${pd}.nc ${dir}${cn}/2060/climate_change/${var}_Amon_${mod}_${sc}_r1i1p1f1_${cn:0:4}_2060-history.nc  

#cdo timmean ${dir}${cn}/${var}_Amon_${mod}_${sc}_r1i1p1f1_${cn:0:4}_202101-204012.nc ${dir}${cn}/2030/timmean/${var}_Amon_${mod}_${sc}_r1i1p1f1_climate_${cn:0:4}_202101-204012.nc
cdo ymonmean ${dir}${cn}/${var}_Amon_${mod}_${sc}_r1i1p1f1_${cn:0:4}_202101-204012.nc ${dir}${cn}/2030/monmean/${var}_Amon_${mod}_${sc}_r1i1p1f1_monmean_${cn:0:4}_202101-204012.nc
cdo ymonstd ${dir}${cn}/${var}_Amon_${mod}_${sc}_r1i1p1f1_${cn:0:4}_202101-204012.nc ${dir}${cn}/2030/monstd/${var}_Amon_${mod}_${sc}_r1i1p1f1_monstd_${cn:0:4}_202101-204012.nc
cdo ymonmean ${dir}${cn}/${var}_Amon_${mod}_${sc}_r1i1p1f1_${cn:0:4}_204101-206012.nc ${dir}${cn}/2060/monmean/${var}_Amon_${mod}_${sc}_r1i1p1f1_monmean_${cn:0:4}_204101-206012.nc
#cdo timmean ${dir}${cn}/${var}_Amon_${mod}_${sc}_r1i1p1f1_${cn:0:4}_204101-206012.nc ${dir}${cn}/2060/timmean/${var}_Amon_${mod}_${sc}_r1i1p1f1_climate_${cn:0:4}_204101-206012.nc
cdo ymonstd ${dir}${cn}/${var}_Amon_${mod}_${sc}_r1i1p1f1_${cn:0:4}_204101-206012.nc ${dir}${cn}/2060/monstd/${var}_Amon_${mod}_${sc}_r1i1p1f1_monstd_${cn:0:4}_204101-206012.nc

#rm ${dir}${cn}/${var}_Amon_${mod}_${sc}_r1i1p1f1_${cn:0:4}_202101-204012.nc
#rm ${dir}${cn}/${var}_Amon_${mod}_${sc}_r1i1p1f1_${cn:0:4}_204101-206012.nc

done
done
done
done

