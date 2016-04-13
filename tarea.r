
data <- read.table("NuAstro_4yr_IceCube_Data.txt", header=TRUE)

good <- complete.cases(data)

#data sin los NA
dataclean <- data[good, ]

#para usar las variables de frente
attach(dataclean)

#calculo de promedios para distintas topologias
x<-mean(Med_Ang_Res_deg[Topology=="Shower"])
y<-mean(Med_Ang_Res_deg[Topology=="Track"])



