path_main<-("D:/Christian/Datenmanagement/Grundlagendaten/")
path_data<-paste0(path_main,"data/")
path_csv<-paste0(path_data,"land use/")
path_scripts<-paste0(path_data,"scripts/")

lu<-read.table(paste0(path_csv,"AI001_gebiet_flaeche.txt"),skip = 4,sep = ";", dec=","
               ,head=T,fill=TRUE)
head(lu)
str(lu)
tail(lu)

names(lu) <- c("Year", "ID", "Place", "Settlement", "Recreation", 
               "Agriculture", "Forest")

for(c in colnames(lu)[4:7]){
  lu[, c][lu[, c] == "."] <- NA  
  lu[, c] <- as.numeric(sub(",", ".", as.character(lu[, c])))
}

summary(lu)


source(paste0(path_scripts, "place_split_rename.R"))

lu_cpsr_done<-place_split_rename(x=lu)

head(lu_cpsr_done)

saveRDS(lu_cpsr_done, paste0(path_csv, "landuse_data.rds"))
