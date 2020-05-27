for var in "pr" "rsds" "tasmax" "tasmin"
 do
  for sc in "historical" "ssp126" "ssp245" "ssp370" "ssp585"
   do
ls *${var}_Amon_EC-Earth3-Veg_${sc}_r1i1p1f1*.nc |wc -l
done
done

