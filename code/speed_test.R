packages <- c("microbenchmark", "tidyverse", "here", "MatchIt", "splines", "boot", "parallel")

for (package in packages) {
  if (!require(package, character.only = T, quietly = T)) {
    install.packages(package, repos = "http://lib.stat.cmu.edu/R/CRAN")
  }
}

for (package in packages) {
  library(package, character.only = T)
}

set.seed(123)
data(lalonde)

ate_func <- function(df, i) {
    dat <- df[i,]
    propensity_score <- glm(treat ~ ns(age, df = 2) + ns(educ, df = 2) + race +
                                married + ns(scale(re74), df = 2) + ns(scale(re75), df = 2),
                            data = dat,
                            family = binomial(link = "logit"))$fitted.values
    dat$sw <- dat$treat * (mean(dat$treat) / propensity_score) +
                (1 - dat$treat) * ((1 - mean(dat$treat)) / (1 - propensity_score))
    ate_estimate <- lm(re78 ~ treat, data = dat, weights = sw)$coef[2]
    return(ate_estimate)
}

if(Sys.info()[['sysname']] == "Darwin"|Sys.info()[['sysname']] == "Linux") {
    paral = "multicore"
} else {
    paral = "snow"
}

## finding medians for each column of large dataset
med_func <- function(){
    X <- as.data.frame(matrix(rnorm(1e8), nrow = 1e7))
    med_col <- lapply(X, median)
    return(med_col)
}


mbm1 <- microbenchmark(
    "bootstrap 1 core" = {
        boot_res <- boot(lalonde, ate_func, R = 1000)
    },
    "bootstrap parallel cores" = {
        boot_res <- boot(lalonde, ate_func, R = 1000, parallel = paral, ncpus = detectCores())
    },
    "column medians" = {
        col_med <- med_func()
    },
    times = 25
    )

saveRDS(mbm1, file = here("data","speed_benchmark.rds"))