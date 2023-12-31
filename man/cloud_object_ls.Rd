% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cloud_local.R
\name{cloud_object_ls}
\alias{cloud_object_ls}
\title{Prepare a dataframe for bulk writing of objects to cloud}
\usage{
cloud_object_ls(x, path, extension, prefix = "", suffix = "")
}
\arguments{
\item{x}{A \strong{named} list. Names may contain letters, digits, spaces, '.',
'-', '_' symbols and cannot contain trailing or leading spaces.}

\item{path}{A directory relative to the project root to write objects to.}

\item{extension}{File extension (string) without the leading dot.}

\item{prefix, suffix}{(optional) strings to attach at the beginning or at the
end of file names.}
}
\value{
A tibble in which each row represents an object from the input list,
comprising the following columns:
\itemize{
\item \code{object} - objects you've provided
\item \code{name} - contains paths where objects are meant to be written.
}
}
\description{
\verb{cloud_*_ls} functions for cloud locations (e.g.
\code{\link{cloud_s3_ls}}) return content dataframes which can then be passed to
\verb{cloud_*_read_bulk} and \verb{cloud_*_download_bulk} functions to read/download
multiple files at once. In a similar manner, this function accepts a list
of objects as an input and produces a dataframe which can then be passed to
\verb{cloud_*_write_bulk} functions to write multiple files at once.
}
\examples{
cloud_object_ls(
  dplyr::lst(mtcars = mtcars, iris = iris),
  path = "data",
  extension = "csv",
  prefix = "df_"
)

}
