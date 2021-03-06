% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/class_clv_fitted_staticcov.R,
%   R/f_s3generics_clvfitted_staticcov.R
\docType{class}
\name{clv.fitted.static.cov-class}
\alias{clv.fitted.static.cov-class}
\alias{show,clv.fitted.static.cov-method}
\title{Fitted CLV Model with Static covariates}
\usage{
\S4method{show}{clv.fitted.static.cov}(object)
}
\description{
Extends the class \code{clv.fitted} with slots to accommodate the various additional
optimization options that can be used for covariates models.
Also used to perform steps during the estimation process that are specific to static covariates models.
}
\section{Slots}{

\describe{
\item{\code{estimation.used.constraints}}{Single boolean whether the estimation constraint any covariate parameters to be the same for both processes.}

\item{\code{names.original.params.constr}}{Character vector with the original names of the constraint covariate parameters. Length zero if none are constraint.}

\item{\code{names.original.params.free.life}}{Character vector with the original names of the not constraint lifetime covariate parameters. Length zero if none are free.}

\item{\code{names.original.params.free.trans}}{Character vector with the original names of the not constraint transaction covariate parameters. Length zero if none are free.}

\item{\code{names.prefixed.params.constr}}{Character vector with the prefixed names of the constraint covariate parameters during optimization. Length zero if none are constraint.}

\item{\code{names.prefixed.params.free.life}}{Character vector with the prefixed names of the not constraint lifetime covariate parameters during optimization. Length zero if none are free.}

\item{\code{names.prefixed.params.free.trans}}{Character vector with the prefixed names of the not constraint transaction covariate parameters during optimization. Length zero if none are free.}

\item{\code{names.prefixed.params.after.constr.life}}{Character vector containing the names of all constraint and free lifetime covariates parameters with lifetime prefixes only. Needed after reduplicating the constraint parameters.}

\item{\code{names.prefixed.params.after.constr.trans}}{Character vector containing the names of all constraint and free transaction covariates parameters with transaction prefixes only. Needed after reduplicating the constraint parameters.}

\item{\code{estimation.used.regularization}}{Single boolean whether the estimation used regularization.}

\item{\code{reg.lambda.life}}{Single numeric with the lambda used for regularizing the lifetime covariate parameters. Length zero if regularization is not used.}

\item{\code{reg.lambda.trans}}{Single numeric with the lambda used for regularizing the transaction covariate parameters. Length zero if regularization is not used.}

\item{\code{prediction.params.life}}{Numeric vector of the lifetime covariate parameters, set and used solely when predicting. Named after lifetime covariates and derived from \code{coef()}.}

\item{\code{prediction.params.trans}}{Numeric vector of the transaction covariate parameters, set and used solely when predicting. Named after transaction covariates and derived from \code{coef()}.}
}}

\seealso{
\code{\link[CLVTools:clv.fitted-class]{clv.fitted}}, \code{\link[CLVTools:clv.fitted.dynamic.cov-class]{clv.fitted.dynamic.cov}}
}
\keyword{internal}
