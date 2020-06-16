for var in "pr" "tasmax" "tasmin" "rsds"
   do
  #for fold in "Ethiopia" "Tanzania" "Uganda"
    for fold in "Ethiopia"
         do
   #for yr in $(seq 1850 2014)
    #do
                      
#cdo mergetime ${fold}/${var}_Amon_GFDL-ESM4_historical_r1i1p1f1_re_gr1_${fold:0:4}_185001-194912.nc ${fold}/${var}_Amon_GFDL-ESM4_historical_r1i1p1f1_re_gr1_${fold:0:4}_195001-201412.nc ${fold}/${var}_Amon_GFDL-ESM4_historical_r1i1p1f1_re_gr1_${fold:0:4}_185001-201412.nc

#cdo mergetime ${fold}/${var}_Amon_MIROC6_historical_r1i1p1f1_re_gn_${fold:0:4}_185001-194912.nc ${fold}/${var}_Amon_MIROC6_historical_r1i1p1f1_re_gn_${fold:0:4}_195001-201412.nc ${fold}/${var}_Amon_MIROC6_historical_r1i1p1f1_re_gn_${fold:0:4}_185001-201412.nc

cdo mergetime //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/${fold}/*${var}_Amon_EC-Earth3-Veg*.nc //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/${fold}/ecearth/${var}_Amon_EC-Earth3-Veg_historical_r1i1p1f1_re_gr_${fold:0:4}_185501-201412.nc

#rm //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/${fold}/${var}_Amon_GFDL-ESM4_historical_r1i1p1f1_re_gr1_${fold:0:4}_185001-194912.nc
#rm //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/${fold}/${var}_Amon_GFDL-ESM4_historical_r1i1p1f1_re_gr1_${fold:0:4}_195001-201412.nc
#rm //dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/regrid/historical/${fold}/${var}_Amon_EC-Earth3-Veg_historical_r1i1p1f1_re_gr_${fold:0:4}_${yr}01-${yr}12.nc
#done
done
done
