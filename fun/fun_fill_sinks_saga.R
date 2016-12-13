
fill_sinks <- function(path_saga, path_data, path_hydro, 
                  dtm_name){
library(raster)
library(gdalUtils)
  
dem <- paste0(path_data, dtm_name)



cmd <- system(paste0(path_saga,
                       " ta_preprocessor 4",
                       " -ELEV ", paste0(dem),
                       " -FILLED ", paste0(path_hydro, "dtm_no_sinks.sdat")))

dtm_ns <- raster(paste0(path_hydro, "dtm_no_sinks.sdat"))

return(dtm_ns)
}
