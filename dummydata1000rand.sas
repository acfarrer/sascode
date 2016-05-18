/* Create 1000 obs with random values */
data dummy ;
do i = 1 to 1000 ;
rand = ranuni(0) ;
output ;
end ;
run ;
