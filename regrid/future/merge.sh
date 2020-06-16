for fold in "Ethiopia" "Tanzania" "Uganda"
   do
    #for var in "pr" "tasmax" "tasmin" "rsds"
     for var in "pr"
      do
      #for sc in "126" "245" "370" "585"
       for sc in "126"
         do

#cdo mergetime ${fold}/${var}_Amon_GFDL-ESM4_historical_r1i1p1f1_re_gr1_Ugan_185001-194912.nc ${fold}/${var}_Amon_GFDL-ESM4_historical_r1i1p1f1_re_gr1_Ugan_195001-201412.nc ${fold}/${var}_Amon_GFDL-ESM4_historical_r1i1p1f1_re_gr1_Ugan_185001-201412.nc

#cdo mergetime ${fold}/${var}_Amon_MIROC6_historical_r1i1p1f1_re_gn_Ugan_185001-194912.nc ${fold}/${var}_Amon_MIROC6_historical_r1i1p1f1_re_gn_Ugan_195001-201412.nc ${fold}/${var}_Amon_MIROC6_historical_r1i1p1f1_re_gn_Ugan_185001-201412.nc

cdo mergetime ${fold}/*${var}_Amon_EC-Earth3-Veg_ssp${sc}_r1i1p1f1_re_gr_${fold:0:4}_*.nc ${fold}/ecearth/${var}_Amon_EC-Earth3-Veg_ssp${sc}_r1i1p1f1_re_gr_${fold:0:4}_201501-209912.nc


#rm //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/${fold}/*EC-Earth3-Veg*.nc
done
done
done
