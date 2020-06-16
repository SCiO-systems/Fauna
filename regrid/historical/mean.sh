for cn in "Ethiopia"
#for cn in "Ethiopia" "Uganda" "Tanzania"
  do
    for var in "pr" "tasmax" "tasmin" "rsds"
            do
         for time in "185001-201412" 
          do
cdo ymonmean ${cn}/${var}_Amon_MRI-ESM2-0_historical_r1i1p1f1_re_gn_${cn:0:4}_${time}.nc ${cn}/monmean/${var}_Amon_MRI-ESM2-0_historical_r1i1p1f1_re_gn_${cn:0:4}_monmean_${time}.nc 

cdo ymonstd ${cn}/${var}_Amon_MRI-ESM2-0_historical_r1i1p1f1_re_gn_${cn:0:4}_${time}.nc ${cn}/monstd/${var}_Amon_MRI-ESM2-0_historical_r1i1p1f1_re_gn_${cn:0:4}_monstd_${time}.nc

done
done
done
