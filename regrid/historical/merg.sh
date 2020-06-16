for cn in "Ethiopia" "Tanzania" "Uganda"
 do
  #for var in "pr"
   #do
rm ${cn}/*185001-194912*.nc
rm ${cn}/*195001-201412*.nc

#cdo mergetime ${cn}/${var}_Amon_MIROC6_historical_r1i1p1f1_re_gn_${cn:0:4}_185001-194912.nc ${cn}/${var}_Amon_MIROC6_historical_r1i1p1f1_re_gn_${cn:0:4}_195001-201412.nc ${cn}/${var}_Amon_MIROC6_historical_r1i1p1f1_re_gn_${cn:0:4}_185001-201412.nc
#done
done
