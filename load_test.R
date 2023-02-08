
# load libraries ----------------------------------------------------------
library(shinyloadtest)
library(data.table)

# set defaults ------------------------------------------------------------

# url <- "https://connect.appsilon.com/ethz-test/"
shiny_url <- "http://127.0.0.1:6568"

# record tests -----------------------------------------------------------------

record_session(shiny_url)

# run tests ---------------------------------------------------------------

cmd_str <- r"{java -jar .\%s recording.log %s --workers %s --loaded-duration-minutes %s --output-dir %s --overwrite-output}"
shinycannon_loc <- "shinycannon-1.1.3.jar"
total_workder <- 5
time_duration_min <- 5
folder_name <- "run"

shinycannon_cmd <- sprintf(
  fmt = cmd_str,
  shinycannon_loc,
  shiny_url,
  total_workder,
  time_duration_min,
  folder_name
)

system2(
  command = "pwsh.exe",
  input = shinycannon_cmd,
  stdout = TRUE,
  wait = TRUE,
  invisible = FALSE
)

# analysis  ---------------------------------------------------------------

load_df <- load_runs(folder_name)

load_df |>
  shinyloadtest_report(
    paste0(folder_name, ".html")
  )
