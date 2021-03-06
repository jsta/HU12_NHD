% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/linked_points.R
\name{get_linked_points_scalable}
\alias{get_linked_points_scalable}
\title{Scalable implementation of get linked points}
\usage{
get_linked_points_scalable(
  in_list,
  na_outlet_coords,
  cores = NA,
  check_file = NULL
)
}
\arguments{
\item{in_list}{as returned by get_in_list}

\item{na_outlet_coords}{as returned in the "na" named output of get_lp_points}

\item{cores}{numeric (optional) number of cores to use in parallel evaluation}

\item{check_file}{geopackage file to check for "linked_points" layer -- will load layer and return if found.}
}
\description{
Given matched levelpaths, finds outlets of catchments along level paths. 
Implements a parallel implementation of get_linked_points
}
