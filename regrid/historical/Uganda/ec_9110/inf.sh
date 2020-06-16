for yr in $(seq 1991 2010)
do
cdo sinfo rsds_Amon_EC-Earth3-Veg_historical_r1i1p1f1_Ugan_${yr}01-${yr}12.nc
done
