for yr in $(seq 1995 2014)
do
cdo sinfo pr_Amon_EC-Earth3-Veg_historical_r1i1p1f1_Ethi_${yr}01-${yr}12.nc
done
