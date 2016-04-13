
data <- read.table("NuAstro_4yr_IceCube_Data.txt", header=TRUE)

good <- complete.cases(data)

#data sin los NA
dataclean <- data[good, ]

#para usar las variables de frente
attach(dataclean)

#calculo de promedios para distintas topologias

#metodo 1: directo
x1<-mean(Med_Ang_Res_deg[Topology=="Shower"])
y1<-mean(Med_Ang_Res_deg[Topology=="Track"])

#metodo 2: crear subdatos por topologia
showerdata <- dataclean[Topology=="Shower", ]
trackdata <- dataclean[Topology=="Track", ]
x2 <- mean(showerdata$Med_Ang_Res_deg)
y2 <- mean(trackdata$Med_Ang_Res_deg)

#funcion que toma el MJD y lo convierte a POSIX
f <- function(x){as.POSIXct(x*24*60*60,origin='1858-11-17',tz='GMT')}



