place_split_rename <- function(x){
  index<-strsplit(as.character(x$Place), ",")
  place_df <- lapply(index, function(i){
    p1 <- sub("^\\s+", "", i[1])  # Trim leading white spaces
    if(length(i) > 2){
      p2 <- sub("^\\s+", "", i[2])
      p3 <- sub("^\\s+", "", i[3])
    } else if (length(i) > 1){
      p2 <- sub("^\\s+", "", i[2])
      p3 <- NA
    } else {
      p2 <- NA
      p3 <- NA
    }
    data.frame(A = p1,
               B = p2,
               C = p3)
  })
  place_df <- do.call("rbind", place_df)  
  place_df$ID <- x$ID 
  place_df$Year <- x$Year  
  names(place_df)<-c("Place","Admin_unit","Admin_misc","ID","Year")
  place_df[!is.na(place_df$Admin_misc),] <- place_df[!is.na(place_df$Admin_misc), c(1,3,2,4,5)]
  for(r in seq(nrow(place_df))){
    if(is.na(place_df$Admin_unit[r]) &
       grepl("kreis", tolower(place_df$Place[r]))){
      place_df$Admin_unit[r] <- "Landkreis"
    }
  }
  place_df$Admin_unit[is.na(place_df$Admin_unit) & nchar(as.character(place_df$ID) == 2)] <- "Bundesland"
  place_df$Admin_unit[place_df$ID == "DG"] <- "Land"
  place_df <- place_df[,c(4,5,1,2,3)]
  place_df <- cbind(place_df, x[,4:ncol(x)])
  return(place_df)
}