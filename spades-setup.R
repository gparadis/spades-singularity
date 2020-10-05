Sys.getenv()
install.packages(c("devtools", "reticulate"))


library(devtools)
deps = TRUE
branch = "development"
devtools::install_github(paste("PredictiveEcology/Require@", branch, sep = ""), dependencies = deps)
devtools::install_github(paste("PredictiveEcology/reproducible@", branch, sep = ""), dependencies = deps)
devtools::install_github(paste("PredictiveEcology/SpaDES.core@", branch, sep = ""), dependencies = deps)
devtools::install_github(paste("PredictiveEcology/SpaDES.experiment@", branch, sep = ""), dependencies = deps)
devtools::install_github(paste("PredictiveEcology/SpaDES@", branch, sep = ""), dependencies = deps)
devtools::install_github(paste("PredictiveEcology/SpaDES.shiny@", branch, sep = ""), dependencies = deps)