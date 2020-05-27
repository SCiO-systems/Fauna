for var in "pr" "tasmax" "tasmin" "rsds"
 do
  #for mod in "BCC-CSM2-MR" "CanESM5" "MIROC6" "MRI-ESM2-0"
   #for mod in "IPSL-CM6A-LR"
    #for mod in "GFDL-ESM4"
     for mod in "EC-Earth3-Veg"
     do
      for sc in "ssp126" "ssp245" "ssp370" "ssp585"
       do
cdo seldate,2016-01-16,2045-12-31 ${var}_Amon_${mod}_${sc}_r1i1p1f1_EAF_gr_201601-210012.nc monmean/future/2030/${var}_Amon_${mod}_${sc}_r1i1p1f1_EAF_gr_201601-204512.nc

cdo seldate,2046-01-16,2075-12-31 ${var}_Amon_${mod}_${sc}_r1i1p1f1_EAF_gr_201601-210012.nc monmean/future/2060/${var}_Amon_${mod}_${sc}_r1i1p1f1_EAF_gr_204601-207512.nc

done
done
done


