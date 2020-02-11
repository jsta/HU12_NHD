download_v1 <- function(out_dir) {
  dir.create(out_dir, showWarnings = FALSE)
  system(paste('wget -P', out_dir, '-r -np -nc -A "*atshape.zip" -A "*NHD.zip" ftp://ftp.horizon-systems.com/NHDplus/NHDPlusV1/'))
  out_dir
}

compile_v1_fline <- function(out_dir, out_gpkg) {
  layer <- "flowline"
  if(!file.exists(out_gpkg) || !layer %in% st_layers(out_gpkg)) {
    fl <- get_fl(out_dir)
    
    fline_files <- fl[grepl("nhdflowline.shp", fl, ignore.case = TRUE)]
    vaa_files <- fl[grepl(".*VAA.dbf$", fl, ignore.case = TRUE)]
    
    flines <- lapply(fline_files, read_sf)
    
    flines <- st_sf(bind_rows(flines))
    
    vaa <- lapply(vaa_files, read.dbf)
    
    vaa <- bind_rows(vaa)
    
    flines <- left_join(flines, vaa, by = "COMID")
    
    write_sf(flines, out_gpkg, layer)
  } else {
    flines <- read_sf(out_gpkg, layer)
  }
  return(flines)
}

get_fl <- function(out_dir) {
  fl_zip <- list.files(out_dir, recursive = TRUE, full.names = TRUE, pattern = ".zip")
  
  dev_null <- lapply(fl_zip, unzip, overwrite = FALSE, exdir = out_dir)
  
  fl <- list.files(out_dir, recursive = TRUE, full.names = TRUE)
  
  fl[!fl %in% fl_zip]
}

compile_v1_cats <- function(out_dir, out_gpkg) {
  layer <- "catchment"
  if(!file.exists(out_gpkg) || !layer %in% st_layers(out_gpkg)) {

    fl <- get_fl(out_dir)
    
    cat_files <- fl[grepl("catchment.shp", fl, ignore.case = TRUE)]
    
    cats <- lapply(cat_files, read_sf)
    
    cats <- st_sf(bind_rows(cats))
    
    write_sf(cats, out_gpkg, layer)
  } else {
    cats <- read_sf(out_gpkg, layer)
  }
  return(cats)
}

get_nhdp_crosswalk <- function(nhdplus_dir) {
  foreign::read.dbf(file.path(nhdplus_dir, "NHDPlusV1Network_V2Network_Crosswalk.dbf"))
}
