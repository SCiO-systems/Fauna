for var in "pr" "tasmax" "tasmin" "rsds"
do
for sc in "126" "245" "370" "585"
do
echo ${var}${sc}
cdo sinfo ${var}_Amon_EC-Earth3-Veg_ssp${sc}_r1i1p1f1_Ethi_202101-204012.nc

done
done
