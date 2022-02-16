source(file="~/Dropbox/Documents/R/ipak.R")
source(file="~/Dropbox/Documents/R/snmSIM.R")
packages <- c("VIM","mice","cmprsk","ggplot2",
              "data.table","parallel","microbenchmark",
              "profvis")
ipak(packages)

### TEST 1
# Note: uses 2+ GB RAM and several seconds or more depending on hardware
# 1: Create large dataset
t1<-proc.time()
X<-as.data.frame(matrix(rnorm(1e8), nrow = 1e7))
# 2: Find the median of each column using a single core
r<-lapply(X, median)
proc.time()-t1
# 2016 MBP
#user  system elapsed 
#11.194   1.340  12.563
# UBUNTU VM
#user  system elapsed 
#8.344   1.148   9.491
# UBUNTU sb
#user  system elapsed 
#8.816   1.116   9.929




### TEST 2
# Simulating from a Structural Nested AFT Model
set.seed(123)
mc<-1000 # number of MC samples
n<-250 #Number of subjects
K<-1 # Number of causes of death
N<-5 # N number of intervals per subject
cores <- detectCores()-1 # for all parallel processing
t1<-proc.time()
t2<-lapply(1:mc,function(x) snmSIM(x,n,N))
proc.time()-t1
# 2016 MBP
#user  system elapsed 
#221.294   2.002 223.896 
# UBUNTU VM
#user  system elapsed 
#273.200   0.168 273.322


t1<-proc.time()
t2<-mclapply(1:mc,function(x) snmSIM(x,n,N),mc.cores=cores)
proc.time()-t1
# 2016 MBP
#user  system elapsed 
#702.900  11.299 148.787
# UBUNTU VM
#user  system elapsed 
#216.984   1.164 109.618

### TEST 3
x <- runif(1e6)
microbenchmark(
  sqrt(x),
  x ^ 0.5
)
# 2016 MBP
#Unit: milliseconds
#expr      min        lq      mean    median        uq       max neval cld
#sqrt(x)  2.85449  4.857371  6.855349  5.166637  5.759324 164.69367   100  a 
#x^0.5 22.18745 25.217478 26.757534 25.813956 27.888482  36.72132   100   b
# UBUNTU 
#Unit: milliseconds
#expr       min        lq     mean    median        uq      max neval cld
#sqrt(x)  2.549202  2.665523  2.91347  2.753263  2.876218 12.62170   100  a 
#x^0.5 61.082606 62.789542 65.12095 64.382818 66.688115 74.86625   100   b