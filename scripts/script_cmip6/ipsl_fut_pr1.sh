for cn in "Ethiopia" "Tanzania" "Uganda"
do
for var in "pr"
do
for sc in "ssp126" "ssp245" "ssp370" "ssp585"
do
for pd in "2030" "2060"
do

dir='//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/future/'

cdo selyear,2021/2040 ${dir}${cn}/${var}_Amon_IPSL-CM6A-LR_${sc}_r1i1p1f1_${cn:0:4}_201501-210012.nc ${dir}${cn}/${var}_Amon_IPSL-CM6A-LR_${sc}_r1i1p1f1_${cn:0:4}_202101-204012.nc

cdo selyear,2041/2060 ${dir}${cn}/${var}_Amon_IPSL-CM6A-LR_${sc}_r1i1p1f1_${cn:0:4}_201501-210012.nc ${dir}${cn}/${var}_Amon_IPSL-CM6A-LR_${sc}_r1i1p1f1_${cn:0:4}_204101-206012.nc

done
done
done
done
