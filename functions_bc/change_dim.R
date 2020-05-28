change_dim <- function(m, dim_output = c(25, 12)){ ## m matrix of any size. Specify dim_output of any size.
  
  dimension <- dim(m)
  
  ma <- matrix(rep(m,each=dim_output[1]/dimension[1]), nrow=dim_output[1])
  
  vec_ma <- rep(1:dimension[2], each = dim_output[2]/dimension[2])
  
  cbind(ma[,vec_ma])
  
}

