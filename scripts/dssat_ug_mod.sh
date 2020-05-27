cust_func(){
#echo Rscript DSSAT_ug_mod$1.R
 echo "Do something $1 times..."
  sleep 1
}
# For loop 2 times
for i in 1 2
do
	cust_func $i & # Put a function in the background
done

