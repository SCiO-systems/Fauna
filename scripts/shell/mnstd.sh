for var in "pr" "tasmax" "tasmin" "rsds"
 do
  #for mod in "BCC-CSM2-MR" "CanESM5" "MRI-ESM2-0"
     
   for mod in "EC-Earth3-Veg" "IPSL-CM6A-LR"
   #for mod in "EC-Earth3-Veg" "IPSL-CM6A-LR"  
    #for tim in "185001-194912" "195001-201412"
    do

#cdo ymonstd ${var}_Amon_GFDL-ESM4_historical_r1i1p1f1_EAF_gr1_${tim}.nc monstd/historical/${var}_Amon_GFDL-ESM4_historical_r1i1p1f1_EAF_gr1_monstd_${tim}.nc
#cdo ymonstd ${var}_Amon_MIROC6_historical_r1i1p1f1_EAF_gn_${tim}.nc monstd/historical/${var}_Amon_MIROC6_historical_r1i1p1f1_EAF_gn_monstd_${tim}.nc

cdo ymonstd ${var}_Amon_${mod}_historical_r1i1p1f1_EAF_gr_185001-201412.nc monstd/historical/${var}_Amon_${mod}_historical_r1i1p1f1_EAF_gr_185001-201412.nc

done
done
