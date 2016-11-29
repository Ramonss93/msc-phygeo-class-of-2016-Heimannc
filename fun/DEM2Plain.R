DEM2Plain<-function(path_saga,path_data,dem_name){
  library(raster)
  library(gdalUtils)
  # Compute inputs
  dem_fp <- paste0(path_data, dem_name)
  cmd <- paste0(path_saga,
                " ta_morphometry 0",
                " -ELEVATION ", paste0(dem_fp),
                " -SLOPE ", paste0(path_data, "SLOPE.sgrd"),
                " -C_MINI ", paste0(path_data, "MINCURV.sgrd"),
                " -C_MAXI ", paste0(path_data, "MAXCURV.sgrd"),
                " -C_PROF ", paste0(path_data, "PCURV.sgrd"),
                " -C_TANG ", paste0(path_data, "TCURV.sgrd"),
                " -UNIT_SLOPE 1 ")
  system(cmd)
  
  slope<- paste0(path_data,"SLOPE.sgrd")
  maxcurv<- paste0(path_data,"MAXCURV.sgrd")
  mincurv<- paste0(path_data,"MINCURV.sgrd")
  profcurv<- paste0(path_data,"PCURV.sgrd")
  tancurv<- paste0(path_data,"TCURV.sgrd")
  
  cmd<- paste0(path_saga,
               " ta_morphometry 25",
               " -SLOPE ", slope,
               " -MINCURV ", mincurv,
               " -MAXCURV ", maxcurv,
               " -PCURV ", profcurv,
               " -TCURV ", tancurv,
               " -PLAIN ", paste0(path_data, "PLAIN.sgrd"))
  system(cmd)
  
  unlink(paste0(path_data,"SLOPE.*"))
  unlink(paste0(path_data,"MAXCURV.*"))
  unlink(paste0(path_data,"MINCURV.*"))
  unlink(paste0(path_data,"PCURV.*"))
  unlink(paste0(path_data,"TCURV.*"))
  
  # Convert restult to tif
  outfile <- paste0(path_data, "PLAIN.sgrd")
  outfile <- paste0(substr(outfile, 1, nchar(outfile)-4), "tif")
  
  cmd <- paste0(path_saga,
                " io_gdal 2",
                " -GRIDS ", paste0(path_data, "PLAIN.sgrd"),
                " -FILE ", outfile)
  system(cmd)
  
  plain<-raster(paste0(path_data,"PLAIN.tif"))
  return(plain)
}