#' format_colData_to_sce
#'
#' @description Format a dataframe of colData into a singlecellexperiment class
#'   where the count assay is empty every cell (columns), and cell phenotype, x
#'   and y coordinates are stored under colData for the purpose of passing
#'   dataframe into a function requiring sce_object.
#'
#' @param df Dataframe that will be the colData of the sce object.
#' @importFrom SingleCellExperiment SingleCellExperiment
#' @return An SingleCellExperiment object
#' @examples
#' df <- data.frame(Cell.ID = c("Cell_1", "Cell_2"), Cell.X.Positions = c(2,5), 
#' Cell.Y.Positions = c(3.3, 8), Phenotypes = c("CD3", "CD3,CD8"))
#' sce <- format_colData_to_sce(df)
#' @export

format_colData_to_sce <- function(df) {
  
  #CHECK
  if (dim(df)[1]==0){
    print(1)
    stop("No data in the dataframe")
  } 
  
  assay_data <- rep(0, dim(df)[1])
  assay_rownames <- "pseudo"
  assay_colnames <- rownames(df)
  
  #transpose the matrix so every column is a cell and every row is a marker
  assay_data_matrix <- as.matrix(assay_data)
  colnames(assay_data_matrix) <- NULL
  rownames(assay_data_matrix) <- NULL
  assay_data_matrix_t <- t(assay_data_matrix)
  
  sce <- SingleCellExperiment(assays = list(counts = assay_data_matrix_t))
  
  rownames(sce) <- assay_rownames
  colnames(sce) <- assay_colnames
  
  #Assign the columns
  for (name in colnames(df)){
    SummarizedExperiment::colData(sce)[[name]] <- df[,name]
  }
  return(sce)
}
