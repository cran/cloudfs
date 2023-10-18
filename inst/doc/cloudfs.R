## ---- warning=FALSE, message=FALSE, echo=FALSE--------------------------------
library(knitr)
opts_chunk$set(
	comment = "",
	#fig.width = 12, 
	message = FALSE,
	warning = FALSE,
	tidy.opts = list(
		keep.blank.line = TRUE,
		width.cutoff = 150
		),
	eval = FALSE,
	error = TRUE
)

## ----eval=FALSE---------------------------------------------------------------
#  aws.s3::put_object(
#    bucket = "project-data",
#    object = "project-1/models/glm.rds",
#    file = "models/glm.rds"
#  )

## ----eval=FALSE---------------------------------------------------------------
#  cloud_s3_upload("models/glm.rds")

## ----eval=FALSE---------------------------------------------------------------
#  library(cloudfs)
#  cloud_drive_attach()

## ----eval=FALSE---------------------------------------------------------------
#  library(ggplot2)
#  p <- ggplot(mtcars, aes(mpg, disp)) + geom_point()
#  if (!dir.exists("plots")) dir.create("plots")
#  ggsave(plot = p, filename = "plots/scatterplot.png")

## ----eval=FALSE---------------------------------------------------------------
#  cloud_drive_upload("plots/scatterplot.png")

## -----------------------------------------------------------------------------
#  library(dplyr, quietly = TRUE)
#  summary_df <-
#    mtcars %>%
#    group_by(cyl) %>%
#    summarise(across(disp, mean))

## ----eval=FALSE---------------------------------------------------------------
#  cloud_drive_write(summary_df, "results/mtcars_summary.xlsx")

## ----eval=FALSE---------------------------------------------------------------
#  cloud_drive_write(
#    p, "plots/scatterplot.png",
#    fun = \(x, file)
#      ggsave(plot = x, filename = file)
#  )

## ----eval=FALSE---------------------------------------------------------------
#  cloud_drive_write(datasets::airquality, "data/airquality.csv")
#  cloud_drive_write(datasets::trees, "data/trees.csv")
#  cloud_drive_write(datasets::beaver1, "data/beaver1.csv")

## ----eval=FALSE---------------------------------------------------------------
#  cloud_drive_ls("data")
#  #> # A tibble: 3 × 5
#  #>   name           type  last_modified       size_b id
#  #>   <chr>          <chr> <dttm>               <dbl> <drv_id>
#  #> 1 airquality.csv csv   2023-09-12 08:04:46   2890 1CXTi1A…
#  #> 2 beaver1.csv    csv   2023-09-12 08:04:50   1901 1Fg4s1O…
#  #> 3 trees.csv      csv   2023-09-12 08:04:48    400 1vDYBVt…

## ----eval=FALSE---------------------------------------------------------------
#  cloud_drive_ls("data") %>%
#    cloud_drive_download_bulk()

## ----eval=FALSE---------------------------------------------------------------
#  all_data <-
#    cloud_drive_ls("data") %>%
#    cloud_drive_read_bulk()

## ----eval=FALSE---------------------------------------------------------------
#  library(ggplot2)
#  p1 <- ggplot(mtcars, aes(mpg, disp)) + geom_point()
#  p2 <- ggplot(mtcars, aes(cyl)) + geom_bar()
#  
#  plots_list <-
#    list("plot_1" = p1, "plot_2" = p2) %>%
#    cloud_object_ls(path = "plots", extension = "png", suffix = "_newsletter")
#  
#  plots_list %>%
#    cloud_drive_write_bulk(fun = \(x, file) ggsave(plot = x, filename = file))

## ----eval=FALSE---------------------------------------------------------------
#  cloud_local_ls("plots") %>%
#    filter(type == "png") %>%
#    cloud_drive_upload_bulk()

