redness_index<-function(x,red=1, green=2){
  index<-(x[[red]]-x[[green]])/(x[[red]]+x[[green]])
  return(index)
}