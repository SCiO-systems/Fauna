for cn in "Ethiopia" "Tanzania" "Uganda"
 do
  for var in "pr" "tasmax" "tasmin" "rsds"
   do
    for sc in "126" "245" "370" "585"
     do
cdo selyear,2015/2044 ${cn}/${var}_Amon_EC-Earth3-Veg_ssp${sc}_r1i1p1f1_re_gr_${cn:0:4}_201501-209912.nc ${cn}/2030/${var}_Amon_EC-Earth3-Veg_ssp${sc}_r1i1p1f1_re_gr_${cn:0:4}_201501-204412.nc

cdo selyear,2045/2074 ${cn}/${var}_Amon_EC-Earth3-Veg_ssp${sc}_r1i1p1f1_re_gr_${cn:0:4}_201501-209912.nc ${cn}/2060/${var}_Amon_EC-Earth3-Veg_ssp${sc}_r1i1p1f1_re_gr_${cn:0:4}_204501-207412.nc

cdo ymonmean ${cn}/2030/${var}_Amon_EC-Earth3-Veg_ssp${sc}_r1i1p1f1_re_gr_${cn:0:4}_201501-204412.nc ${cn}/2030/${var}_Amon_EC-Earth3-Veg_ssp${sc}_r1i1p1f1_re_gr_${cn:0:4}_monmean_201501-204412.nc

cdo ymonmean ${cn}/2060/${var}_Amon_EC-Earth3-Veg_ssp${sc}_r1i1p1f1_re_gr_${cn:0:4}_204501-207412.nc ${cn}/2060/${var}_Amon_EC-Earth3-Veg_ssp${sc}_r1i1p1f1_re_gr_${cn:0:4}_monmean_204501-207412.nc

cdo ymonstd ${cn}/2030/${var}_Amon_EC-Earth3-Veg_ssp${sc}_r1i1p1f1_re_gr_${cn:0:4}_201501-204412.nc ${cn}/2030/${var}_Amon_EC-Earth3-Veg_ssp${sc}_r1i1p1f1_re_gr_${cn:0:4}_monstd_201501-204412.nc

cdo ymonstd ${cn}/2060/${var}_Amon_EC-Earth3-Veg_ssp${sc}_r1i1p1f1_re_gr_${cn:0:4}_204501-207412.nc ${cn}/2060/${var}_Amon_EC-Earth3-Veg_ssp${sc}_r1i1p1f1_re_gr_${cn:0:4}_monstd_204501-207412.nc
 
rm ${cn}/2030/${var}_Amon_EC-Earth3-Veg_ssp${sc}_r1i1p1f1_re_gr_${cn:0:4}_201501-204412.nc
rm ${cn}/2060/${var}_Amon_EC-Earth3-Veg_ssp${sc}_r1i1p1f1_re_gr_${cn:0:4}_204501-207412.nc

done
done
done
