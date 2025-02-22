#' format_sce_to_ppp
#'
#' @description Formats an sce object into a ppp object
#' which has the x,y coordinates, phenotypes as markers 
#' window specifies the range of x and y coordinates
#'
#' @export
#' @param sce_object SingleCellExperiment object in the form of the output of format_image_to_sce
#' @param window_pol Optional Boolean Specifying if the window is polygon
#' @param feature_colname String specifying the feature column of interest
#' @return A ppp object is returned (defined in `spatstat` package)
#' @examples 
#' ppp_object<-format_sce_to_ppp(SPIAT::defined_image, feature_colname = "Cell.Type")

format_sce_to_ppp <- function(sce_object, window_pol = FALSE, feature_colname="Phenotype") {
  
  # get x, y coordinates and phenotypes from sce object
  sce_data <- data.frame(colData(sce_object))
  sce_data <- sce_data[!duplicated(sce_data[,c("Cell.X.Position", "Cell.Y.Position")]),]
  x <- sce_data$Cell.X.Position
  y <- sce_data$Cell.Y.Position
  marks <- sce_data[[feature_colname]]
  
  # get windows
  x_summary <- summary(sce_data$Cell.X.Position)
  x_min <- as.numeric(x_summary[1])
  x_max <- as.numeric(x_summary[6])
  y_summary <- summary(sce_data$Cell.Y.Position)
  y_min <- as.numeric(y_summary[1])
  y_max <- as.numeric(y_summary[6])
  
  if (window_pol == TRUE){
    
    # get ploy window
    X <- data.frame(x,y)
    hpts <- grDevices::chull(X)
    poly_window <- list(x=rev(X[hpts, 1]), y=rev(X[hpts, 2]))
    
    # format sce to ppp
    ppp_object <- spatstat.geom::ppp(x, y, poly = poly_window, 
                                     marks = marks)
  }
  
  else{  
    ppp_object <- spatstat.geom::ppp(x, y, 
                                     window = spatstat.geom::owin(c(x_min, x_max), c(y_min, y_max)), 
                                     marks = marks)
  }
  return(ppp_object)
}


