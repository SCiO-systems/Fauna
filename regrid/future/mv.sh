for cn in "Ethiopia" "Tanzania" "Uganda"
   do
    for tim in "2030" "2060"
     do
      for var in "pr" "tasmax" "tasmin" "rsds"
       do
       for sc in "126" "245" "370" "585"
        do
         for pd in "201501-204412" "204501-207412"
          do

mv ${cn}/${tim}/${var}_Amon_IPSL-CM6A-LR_ssp${sc}_r1i1p1f1_gr_${cn:0:4}_monmean_${pd}.nc ${cn}/${tim}/${var}_Amon_IPSL-CM6A-LR_ssp${sc}_r1i1p1f1_re_gr_${cn:0:4}_monmean_${pd}.nc

mv ${cn}/${tim}/${var}_Amon_IPSL-CM6A-LR_ssp${sc}_r1i1p1f1_gr_${cn:0:4}_monstd_${pd}.nc ${cn}/${tim}/${var}_Amon_IPSL-CM6A-LR_ssp${sc}_r1i1p1f1_re_gr_${cn:0:4}_monstd_${pd}.nc

done
done
done
done
done
