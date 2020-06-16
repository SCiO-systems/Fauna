for yr in $(seq 2041 2060)
do
cdo sinfo rsds_Amon_EC-Earth3-Veg_ssp245_r1i1p1f1_Ugan_${yr}01-${yr}12.nc
done
