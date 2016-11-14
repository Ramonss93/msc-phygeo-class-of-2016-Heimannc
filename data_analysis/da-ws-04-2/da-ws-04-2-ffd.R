path_main<-("D:/Christian/Datenmanagement/Grundlagendaten/")
path_data<-paste0(path_main,"data/")
path_csv<-paste0(path_data,"crop yield/")
path_scripts<-paste0(path_data,"scripts/")


ffd<-read.table(paste0(path_csv,"115-46-4_feldfruechte.txt"),skip = 6,sep = ";", dec=","
                ,head=T,fill=TRUE)

head(ffd)
str(ffd)
tail(ffd)

ffd<-ffd[-(8926:8930),] 

names(ffd)<-c("Year","ID","Place","Winter_wheat","Rye","Winter_barley","Spring_barley","Oat","Triticale","Potatos","Sugar_beets", "Rapeseed", "Silage_maize")


for(i in c(1,4:13)) {
  ffd[,i][ffd[,i]=="." |
            ffd[,i]=="-"|
            ffd[,i]==","|
            ffd[,i]=="/"]<-NA
  ffd[,i]<-as.numeric(gsub(",", ".", as.character(ffd[,i])))
}

summary(ffd)

source(paste0(path_scripts, "place_split_rename.R"))

ffd_cpsr_done<-place_split_rename(x=ffd)

head(ffd_cpsr_done)

saveRDS(ffd_cpsr_done, paste0(path_csv, "crop_data.rds"))
