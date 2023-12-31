% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/drive_transfer_bulk.R
\name{cloud_drive_upload_bulk}
\alias{cloud_drive_upload_bulk}
\title{Bulk Upload Files to Google Drive}
\usage{
cloud_drive_upload_bulk(content, quiet = FALSE, root = NULL)
}
\arguments{
\item{content}{(data.frame) Output of \code{cloud_s3_ls()}}

\item{quiet}{All caution messages may be turned off by setting this parameter
to \code{TRUE}.}

\item{root}{Google Drive ID or URL of the project root. This serves as the
reference point for all relative paths. When left as \code{NULL}, the root is
automatically derived from the \code{cloudfs.drive} field of the project's
DESCRIPTION file.}
}
\value{
Invisibly returns the input \code{content} dataframe.
}
\description{
This function streamlines the process of uploading multiple
files from the local project folder to the project's designated Google
Drive folder. By using \link{cloud_local_ls}, you can obtain a dataframe
detailing the contents of the local folder. Applying
\code{cloud_drive_upload_bulk} to this dataframe allows you to upload all listed
files to Google Drive.
}
\examples{
\dontshow{if (interactive() ) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
# create toy plots: 2 png's and 1 jpeg
dir.create("toy_plots")
png("toy_plots/plot1.png"); plot(rnorm(100)); dev.off()
png("toy_plots/plot2.png"); plot(hist(rnorm(100))); dev.off()
png("toy_plots/plot3.jpeg"); plot(hclust(dist(USArrests), "ave")); dev.off()

# upload only the two png's
cloud_local_ls("toy_plots")  |> 
  dplyr::filter(type == "png")  |> 
  cloud_drive_upload_bulk()

# clean up
unlink("toy_plots", recursive = TRUE)
  
\dontshow{\}) # examplesIf}
}
