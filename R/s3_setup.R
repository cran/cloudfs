#' @title Attach S3 folder to project
#'
#' @description This function facilitates the association of a specific S3
#'   folder with a project by adding a unique identifier to the project's
#'   DESCRIPTION file. The user is prompted to navigate to the S3 console,
#'   select or create the desired folder for the project, and then provide its
#'   URL. The function extracts the necessary information from the URL and
#'   updates the `cloudfs.s3` field in the DESCRIPTION file accordingly.
#'
#' @inheritParams proj_desc_get
#' 
#' @return This function does not return a meaningful value but modifies the
#'   DESCRIPTION file of the specified project to include the S3 folder path.
#'
#' @examplesIf interactive()
#' cloud_s3_attach()
#'
#' @export
cloud_s3_attach <- function(project = ".") {
  
  name <- proj_desc_get("Name", project)
  s3_desc <- proj_desc_get("cloudfs.s3", project)
  
  if (is.na(s3_desc)) {
    cli::cli_alert_info(
      "For {.code cloud_s3_*} functions to work, project's \\
      {.path DESCRIPTION} file needs to contain a path to a dedicated S3 folder."
    )
  } else {
    cli::cli_alert_info(
      "Project's {.path DESCRIPTION} file already contains a path to an S3 \\
      folder."
    )
    if (!cli_yeah("Do you want to update it?", straight = TRUE)) {
      return(invisible(TRUE))
    }
  }
  
  yeah <- cli_yeah(
    "Do you wish to visit S3 to find/create a folder?",
    straight = TRUE
  )
  
  if (yeah) { utils::browseURL("https://s3.console.aws.amazon.com/") }
  
  repeat {
    ok <- TRUE
    cli::cli_text("Paste folder URL below")
    url <- readline("URL: ")
    info <- tryCatch(
      cloud_s3_get_info_from_url(url),
      error = function(e) e
    )

    if (inherits(info, "error")) {
      cli::cli_warn(info$message)
      ok <- FALSE
    }
    
    if (ok) {
      desc::desc_set(cloudfs.s3 = info, file = file.path(project, "DESCRIPTION"))
      cli::cli_alert_success(
        "Attached S3 folder {.path {info}} to {.field {name}} project.\n
        {.field CloudS3} field in {.path DESCRIPTION} has been updated \\
        sucessfully."
      )
      return(invisible(TRUE))
    } else {
      if (cli_yeah("Try again?", straight = TRUE)) {
        cli::cli_text("Aborting ...")
        break
      }
    }
  }
}

#' @title Get Project's S3 Location
#' 
#' @description Tries to read `cloudfs.s3` field from project's DESCRIPTION
#'   file. If it's absent, tries to attach it with [cloud_s3_attach].
#' 
#' @noRd
cloud_s3_get_root <- function(project = ".") {
  loc <- proj_desc_get("cloudfs.s3", project)
  if (is.na(loc)) {
    cloud_s3_attach(project = project)
    loc <- proj_desc_get("cloudfs.s3", project)
  }
  loc
}

#' @title Extract S3 info from URL
#' @description First makes sure that provided url is an S3 link.
#'  If not, throws an error. Then returns bucket-name|prefix.
#'   
#' @examples 
#' url <- "https://s3.console.aws.amazon.com/s3/buckets/bucket-name?region=us-east-1&prefix=alpha/&showversions=false"
#' cloud_s3_get_info_from_url(url)
#' #> [1] "bucket-name/alpha"
#' 
#' @noRd
cloud_s3_get_info_from_url <- function(url) {
  
  if (!grepl("s3/buckets/[^/?]+", url)) {
    
    url_sample <- "https://s3.console.aws.amazon.com/s3/buckets/bucket-name/..."
    
    cli::cli_abort(c(
      "Project's S3 URL is invalid:",
      "i" = "URL should be of the format {.path {url_sample}}",
      "x" = "Provided URL doesn't meet that specification."
    ))
  }
  
  # Extract bucket
  bucket_match <- regmatches(url, regexpr("buckets/([^?]+)", url))
  bucket <- substring(bucket_match[[1]], 9)
  
  # Extract prefix
  prefix_match <- regmatches(url, regexpr("prefix=([^&]+)", url))
  
  if (length(prefix_match) == 0) {
    prefix <- NA
  } else {
    prefix <- substring(prefix_match[[1]], 8)
    prefix <- sub("/+$", "", prefix)
  }
  
  if (is.na(prefix)) {
    cli::cli_alert_info("Project's S3 bucket has no subfolder.")
  }
  
  paste(bucket, prefix, sep = "/")
}
