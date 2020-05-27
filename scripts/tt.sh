cust_func(){
  #echo "Do something $1 times..."
  Rscript 'dssat_ug_mod'$1'.R' 
  sleep 1
}
# For loop 5 times
for i in 1 2 
do
	cust_func $i & # Put a function in the background
done
