options(java.parameters = "- Xmx1024m")
library(GSODR)
library(XML)
library(ggplot2)
library(ggmap)
library(xlsx)
update_station_list()
load(system.file("extdata","isd_history.rda",package="GSODR"))
folderpath <- "Datasets"
if (!file.exists(folderpath)){
    dir.create(file.path(folderpath))
}

#Alta Wind Energy Center coordinates
AWlat = 35.01667
AWlon = -118.31667

#Climate stations
stloc <- nearest_stations(LAT = AWlat, LON = AWlon, distance = 20)
streg <- nearest_stations(LAT = AWlat, LON = AWlon, distance = 50)
streg <- streg[!streg %in% stloc]
stdataloc <- isd_history[isd_history$STNID %in% stloc,]
stdatareg <- isd_history[isd_history$STNID %in% streg,]

#combine data on selected stations
stdataloc$gr <- as.factor("Local climate stations")
stdatareg$gr <- as.factor("Regional climate stations")
stdata <- rbind(stdataloc,stdatareg)

#Wind plants in the region
#data on wind power plants
planturl <- "https://www.eia.gov/electricity/data/eia860m/xls/november_generator2017.xlsx"
plantfile <- "./Datasets/plant_data.xlsx"
download.file(planturl,destfile=plantfile,mode='wb')

#Wind plants in the region
pldata <- read.xlsx(plantfile,sheetIndex = 1,startRow = 2, endRow = 20847,heading = TRUE)
plwnd <- pldata[pldata$Plant.State == 'CA'& pldata$Energy.Source.Code == 'WND' & grepl('AW',pldata$Generator.ID),]
plmarkwnd <- data.frame(LAT = plwnd$Latitude, LON = plwnd$Longitude)
plmarkwnd$gr <- "Alta Wind power plant"
marks <- rbind(data.frame(LAT = stdata$LAT, LON = stdata$LON, gr = stdata$gr),
               plmarkwnd)

mapImageData1 <- get_map(location = c(lon = -118.31667, lat = 35.01667),
                         color = "color",
                         source = "google",
                         maptype = "satellite",
                         zoom = 9)

sitemap <- ggmap(mapImageData1,
      extent = "device",
      ylab = "Latitude",
      xlab = "Longitude")

#sitemap+geom_point(aes(x=LON,y=LAT,colour = gr),data = stdata,size=3)
fig1 <- sitemap+geom_point(aes(x=LON,y=LAT,colour = gr),data = marks,size=3)+ theme(legend.title = element_blank())
fig1
ggsave(filename = "fig1_MapAWEC.png",fig1, width = 8, height = 6, dpi = 300)

#data from climate stations
dataloc <- get_GSOD(years = 2000:2017,station = stloc)
datareg <- get_GSOD(years = 2000:2017,station = streg)

#combine data on selected stations
dataloc$gr <- "Local climate stations"
datareg$gr <- "Regional climate stations"
data <- rbind(dataloc,datareg)

# make the plot
temp <- with(data,aggregate(TEMP,by = list(year = YEAR,gr = gr),mean))
g <- ggplot(temp,aes(year,x,group=gr))
fig2 <- g+geom_point(size=4,aes(col=gr))+geom_line(aes(col=gr),size=1.2)+
    labs(x="Year",y="Average temperature",title="Temperature near Alta Wind Energy Center before and after the plant comission in 2010")+
    theme(legend.position = 'bottom',legend.title = element_blank())
fig2
ggsave(filename = "fig2_TempAWEC.png",fig2, width = 8, height = 6, dpi = 300)


file.create("./Datasets/isd_history.csv")
write.csv(isd_history,"./Datasets/isd_history.csv")
file.create("./Datasets/climate_data.csv")
write.csv(data,"./Datasets/climate_data.csv")



