
cat('\f')
rm(list = ls())

#加载包
libraries = c("R.matlab","volesti")
#注意，一定要把用到的package都放到一行c之中，否则无效
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
  install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)
#设置为当前代码路径
# setwd("D:/WorkSpace/Aggregation_GA/Fitness/Volume_VolEsti/")
#读取数据
path <- "D:/WorkSpace/Aggregation_GA/Fitness/Volume_VolEsti/"
pathname <- file.path(path, "Polytope_info.mat")
data_read <- readMat(pathname)
A_read <- as.numeric(unlist(data_read['A']))
b_read <- as.numeric(unlist(data_read['b']))
nnrow <- as.numeric(data_read['nrow'])
nncol <- as.numeric(data_read['ncol'])
A_mat <- matrix(A_read, nrow =nnrow, ncol =nncol)
P = Hpolytope(A = A_mat, b = b_read)
vol_est <- volume(P, settings = NULL, rounding = TRUE)
# print(vol_est)
writeMat("D:/WorkSpace/Aggregation_GA/Fitness/Volume_VolEsti/Vol_result.mat",vol=vol_est)
# writeMat必须添加路径，指定写在哪个文件夹中。否则，就会出现在matlab运行时，当前文件夹在哪里，Vol_result.mat就会被创建在哪里，而不是在Volume_estimation这个文件夹下面




