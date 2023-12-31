% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/drive_transfer_bulk.R
\name{cloud_drive_prep_bulk}
\alias{cloud_drive_prep_bulk}
\title{Prepare Google Drive content dataframe to be used by bulk
download/read functions}
\usage{
cloud_drive_prep_bulk(
  content,
  what = c("read", "download"),
  safe_size = 5e+07,
  quiet = FALSE
)
}
\arguments{
\item{content}{(data.frame) Output of \code{cloud_drive_ls()}}

\item{what}{What will be done with content, either "read" or "download".
This affects only how messages will look.}

\item{safe_size}{What is considered to be safe size in bytes to download in
bulk. To show additional caution message in case if you accidentally run
bulk reading on a folder with gigabytes of data.}

\item{quiet}{All caution messages may be turned off by setting this parameter
to \code{TRUE}.}
}
\value{
Transformed \code{content} dataframe.
}
\description{
\code{cloud_drive_ls} returns a dataframe of contents of a Google
Drive folder. This dataframe has \code{name}, \code{type} and \code{id} columns. \code{name}
may be either full names or short names (depending on \code{full_names}
parameter of \code{cloud_drive_ls}), but \code{names(name)} will always contain full
names. This function:
\enumerate{
\item filters out folders
\item extracts \code{names(name)} into \code{path} column.
\item informs about the size of files that are to be downloaded/read and asks
for confirmation
}
}
\keyword{internal}
