for var in "pr" "tasmax" "tasmin" "rsds"
   do
         
cdo ymonmean ${var}_Amon_MRI-ESM2-0_historical_r1i1p1f1_re_gn_Ethi_185001-201412.nc monmean/${var}_Amon_MRI-ESM2-0_historical_r1i1p1f1_re_gn_Ethi_monmean_185001-201412.nc 

cdo ymonstd ${var}_Amon_MRI-ESM2-0_historical_r1i1p1f1_re_gn_Ethi_185001-201412.nc monstd/${var}_Amon_MRI-ESM2-0_historical_r1i1p1f1_re_gn_Ethi_monstd_185001-201412.nc

done

