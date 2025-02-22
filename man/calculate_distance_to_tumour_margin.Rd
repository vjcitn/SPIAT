% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calculate_distance_to_tumour_margin.R
\name{calculate_distance_to_tumour_margin}
\alias{calculate_distance_to_tumour_margin}
\title{calculate_distance_to_tumour_margin}
\usage{
calculate_distance_to_tumour_margin(sce_object)
}
\arguments{
\item{sce_object}{SingleCellExperiment object that has the information of the
detected bordering cells (metadata has "Region" column).}
}
\value{
An sce_object is returned
}
\description{
Returns a SCE object with the minimum distance from immune
  cells to the identified tumour bordering cells.
}
\examples{
sce_border <- identify_bordering_cells(SPIAT::defined_image, reference_cell = "Tumour",
feature_colname = "Cell.Type", n_to_exclude = 10)
sce_dist <- calculate_distance_to_tumour_margin(sce_border)
}
