packages <- c("data.table", "tidyverse", "skimr", "here", "knitr", "kableExtra")

for (package in packages) {
  if (!require(package, character.only = T, quietly = T)) {
    install.packages(package, repos = "http://lib.stat.cmu.edu/R/CRAN")
  }
}

for (package in packages) {
  library(package, character.only = T)
}

mbm1 <- readRDS(file = "../data/speed_benchmark.rds")

mbm1_table <- knitr::kable(summary(mbm1), caption = "This is the table caption") %>%
                        footnote(c("hello, this is footnote 1", "hello, this is footnote 2"))

print(mbm1_table)