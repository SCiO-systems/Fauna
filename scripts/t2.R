a<-list()

b<-c(2,5,9,3,4,8)

if(length(commandArgs(TRUE)) != 0) {
t <- as.integer(commandArgs(TRUE))[2]
} else  {
stop("You need to provide an external parameter with the chunk number")
}

#for (i in 1:5){
a[[t]]<-b[t]*3
#}

saveRDS(a,'//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/cc_raw/scripts/a2.RDS')
q(save='no')