for cn in "Ethiopia" "Uganda" "Tanzania"
#for cn in "Ethiopia" 
do
  for var in "pr" "tasmax" "tasmin" "rsds"
   do
    for sc in "126" "245" "370" "585"
     do

ls ${cn}/*${var}_Amon_EC-Earth3-Veg_ssp${sc}_r1i1p1f1_re_gr_${cn:0:4}_*.nc |wc -l
done
done
done
