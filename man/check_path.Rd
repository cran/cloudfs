% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cli.R
\name{check_path}
\alias{check_path}
\title{Validate a path}
\usage{
check_path(path, error = TRUE)
}
\arguments{
\item{path}{A path relative to the project folder root. Can contain only
letters, digits, '-', '_', '.', spaces and '/' symbols.}

\item{error}{if \code{TRUE} (default), throws an error if \code{file} is not a valid
file path.}
}
\value{
Either \code{TRUE} or \code{FALSE} if \code{error} is \code{FALSE}. Either \code{TRUE} or
an error if \code{error} is \code{TRUE}.
}
\description{
Makes sure that a path passed to a cloud function is in the
right format.
}
\keyword{internal}
