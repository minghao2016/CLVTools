% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{apparelStaticCov}
\alias{apparelStaticCov}
\title{Time-invariant Covariates for the Apparel Retailer Dataset}
\format{
A \code{data.table} with 250 rows and 3 variables:

\describe{
  \item{Id}{Customer Id}
  \item{Gender}{0=male, 1=female}
  \item{Channel}{Acquisition channel: 0=online, 1=offline}
}
}
\usage{
data("apparelStaticCov")
}
\description{
This simulated data contains additional demographic information on all 250 customers in the
"apparelTrans" dataset. This information can be used as time-invariant covariates.
}
\keyword{datasets}
