# # to test
# # its necessary to add dir_run into a funtion than is goint to run DSSAT with all specification and run into a particular folder
# out_dir <- 'dssat_runs_ug_bcc/'
# crop <- "BEAN"
# name <- "BBACO001.BNX"  # for linux ./proof.MZX, for windows proof.MZX USAID
# filename <- "DSSBatch.v47"  # filename
# 
# CSMbatch(crop, name, paste0(out_dir, filename))

CSMbatch <- function(crop, name, filename) {
  
  outbatch <- rbind(
    rbind(
      # Batchfile headers            
      paste0("$BATCH(", crop, ")"),            
      "!",            
      cbind(sprintf("%6s %92s %6s %6s %6s %6s", "@FILEX", "TRTNO", "RP", "SQ", "OP", 
                    "CO"))),            
    cbind(sprintf("%6s %86s %6i %6i %6i %6i",            
                  paste0(name),
                  1,  # Variable for treatment number            
                  1,  # Default value for RP element            
                  0,  # Default value for SQ element            
                  1,  # Default value for OP element            
                  0)))  # Default value for CO element 
  
  # Write the batch file to the selected folder  
  write(outbatch, file = filename, append = F)
  
}
