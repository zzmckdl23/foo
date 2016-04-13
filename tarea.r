
data <- read.table("NuAstro_4yr_IceCube_Data.txt")

good <- complete.cases(data)

dataclean <- data[good, ]