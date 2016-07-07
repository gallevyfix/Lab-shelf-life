#load library
require(AnomalyDetection)

#set path for output
path=".../output"

#save name of files - also the names of the labs 
file_names<-dir(".../data",  full.names = FALSE, ignore.case = TRUE)

#setup 3 csv files for thresholds tables
write.table(t(c("labnames", c(1:40))), sprintf("%s/30_180_anoms.csv", path), append=FALSE, sep=",", row.names=FALSE, col.names=FALSE)

write.table(t(c("labnames", c(1:40))), sprintf("%s/30_90_anoms.csv", path), append=FALSE, sep=",", row.names=FALSE, col.names=FALSE)


write.table(t(c("labnames", c(1:10))), sprintf("%s/365_anoms.csv", path), append=FALSE, sep=",", row.names=FALSE, col.names=FALSE)

#preform the anomaly detection analysis on each lab and export gaps found as anomolious
for (i in 1:length(file_names)){
  g=try(sample_counts<-read.table(sprintf(".../data/%s", file_names[i]), header=F, sep=","))
  if (class(g)[1]=="try_error" | dim(sample_counts)[1]==1){
    next
  }else{
  
    #sort sample_counts
    sample_counts_ord<-sample_counts[order(sample_counts[,1]),]
    counts<-as.numeric(sample_counts_ord[,2])
    
    
    # 1. short term period=30, long term period=180
    
    if (length(counts)>180){
      
      res1 = AnomalyDetectionVec(counts , max_anoms=0.02, alpha=0.05, threshold='p95' ,  y_log=T,direction='pos', plot=TRUE, period=30, longterm_period=180)
      
      anoms<-t(sample_counts_ord[res1$anoms[,1],1])
      row.names(anoms)<-sprintf("(%s)%s", i, gsub("list.txt","",sprintf("%s", file_names[i])))
      write.table(anoms, sprintf("%s/30_180_anoms.csv", path), append=TRUE, sep=",", col.names=FALSE)
    }
    
    # 2. short term period=30, long term period=90
    
    
    if (length(counts)>90){
      
      res1 = AnomalyDetectionVec(counts , max_anoms=0.02, alpha=0.05, threshold='p95' ,  y_log=T,direction='pos', plot=TRUE, period=30, longterm_period=90)
      
      anoms<-t(sample_counts_ord[res1$anoms[,1],1])
      row.names(anoms)<-sprintf("(%s)%s", i, gsub("list.txt","",sprintf("%s", file_names[i])))
      write.table(anoms, sprintf("%s/30_90_anoms.csv", path), append=TRUE, sep=",", col.names=FALSE)
    }
    
    # 3. short term period=365, long term period= none
    
    
    if (length(counts)>365*2){
      
      res1 = AnomalyDetectionVec(counts , max_anoms=0.05, alpha=0.05, threshold='p95' ,  y_log=T,direction='pos', plot=TRUE, period=365)
      
      anoms<-t(sample_counts_ord[res1$anoms[,1],1])
      row.names(anoms)<-sprintf("(%s)%s", i, gsub("list.txt","",sprintf("%s", file_names[i])))
      write.table(anoms, sprintf("%s/365_anoms.csv", path), append=TRUE, sep=",", col.names=FALSE)
    }  
    
  }
}

