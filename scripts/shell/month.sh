#for var in "pr" "tasmax" "tasmin" "rsds"
for var in "tasmax"
 do
  #for mod in "BCC-CSM2-MR" "CanESM5" "MIROC6" "MRI-ESM2-0" 
   for mod in "IPSL-CM6A-LR"
    do
   #"${mod}" "IPSL-CM6A-LR" "MRI-ESM2-0"
   # do 
     #for sc in "ssp126" "ssp245" "ssp370" "ssp585"
      for sc in "ssp126"
      do
  #for mod in "${mod}" "IPSL-CM6A-LR"  
        for tim in "201501-204412" "204501-207412"
         #for tim in "201601-204512" "204601-207512"
          do

cdo ymonmean ${var}_Amon_${mod}_${sc}_r1i1p1f1_EAF_gr_${tim}.nc monmean/future/${var}_Amon_${mod}_${sc}_r1i1p1f1_EAF_gr_monmean_${tim}.nc

cdo ymonstd ${var}_Amon_${mod}_${sc}_r1i1p1f1_EAF_gr_${tim}.nc monstd/future/${var}_Amon_${mod}_${sc}_r1i1p1f1_EAF_gr_monstd_${tim}.nc

done
done
done
done
