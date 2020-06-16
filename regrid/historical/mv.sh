for cn in "Ethiopia" "Tanzania" "Uganda"
 do
  for var in "pr" "tasmax" "tasmin" "rsds"
    do 
mv ${cn}/monmean/${var}_Amon_EC-Earth3-Veg_historical_r1i1p1f1_re_gr_${cn:0:4}_monmean_185501-201412.nc ${cn}/monmean/${var}_Amon_EC-Earth3-Veg_historical_r1i1p1f1_re_gr_${cn:0:4}_monmean_185001-201412.nc 

mv ${cn}/monstd/${var}_Amon_EC-Earth3-Veg_historical_r1i1p1f1_re_gr_${cn:0:4}_monstd_185501-201412.nc ${cn}/monstd/${var}_Amon_EC-Earth3-Veg_historical_r1i1p1f1_re_gr_${cn:0:4}_monstd_185001-201412.nc
done
done
