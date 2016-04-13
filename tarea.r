
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

#agregar columna a dataclean
dataclean[,"Time_GMT"] <- c(f(Time_MJD))

#function que bota eventos para un mes en distintos años, deberia entrar 'datanew' y un mes 'x' entre 0 y 11
evt_month <- function(data,x){
p <- as.POSIXlt(subset(data, as.POSIXlt(data$Time_GMT)$mon==x)$Time_GMT)$year
return(p)
}

#ejemplo para visualizar la funcion
print(table(evt_month(dataclean,1)+1900))


#encontrar mes con mayor eventos para un año

#seleccionar un año, por ejemplo 113 que equivale a 2013, que tiene 2 meses con maximo numero de eventos (2 eventos)
#datapr son los datos para el año escogido
datapr <- dataclean[as.POSIXlt(dataclean$Time_GMT)$year==113, ]

#conseguir numero de eventos para todos los meses
for(i in unique(as.POSIXlt(datapr$Time_GMT)$mon)){
  eventos<- length(evt_month(datapr,i)) #aca se usa la funcion
  qq<-cbind(mes=i+1,eventos)   #i+1 para que el numero de mes corresponda con la convencion de 1:12 en vez de 0:11
  if(i==min(unique(as.POSIXlt(datapr$Time_GMT)$mon))){qp<-qq}else{qp<-rbind(qp,qq)}
  #print(qp)
}
#se tiene la tabla qp con numero de mes y numero de evento
#luego se imprime las filas con mayor numero de eventos
print(qp[qp[,2]==max(qp[,2]), ],header=TRUE)



