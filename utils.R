library(shiny)
library(shinyjs)
library(maptools)
library(leaflet)

#Download datasets from repositories
if(!dir.exists("data")) dir.create("data")
if(!file.exists("data/Branch_Information.csv")) 
  download.file("http://opendata.tplcs.ca/data/Branch_Information/Branch_Information.csv", "data/Branch_Information.csv")
if(!file.exists("data/library-data.kml"))
  download.file("http://www.torontopubliclibrary.ca/data/library-data.kml", "data/library-data.kml")

branches <- read.csv("data/Branch_Information.csv", stringsAsFactors = FALSE, strip.white = TRUE)
drops <- c("FSA", "NBHD.No.", "Ward.No.", "TSNS.2020.NIA", "TSNS.2020.Branch"," Branch.Staff.Hours", "Total.Rental.Space..sq..ft..")
branches <- branches[, !(names(branches) %in% drops)]

coordsKML <- getKMLcoordinates("data/library-data.kml", ignoreAltitude = TRUE)
coordsMatrix <- do.call(rbind, coordsKML)
coords <- as.data.frame(coordsMatrix)
colnames(coords) <- c("longitude", "latitude")

df <- data.frame(branches, coords)

#Calculate some useful variabiles
#Number of PCs with Internet Access
PCs <- df$Total...of.Public.PCs.with.Internet.Access
minPC <- min(PCs) #2
maxPC <- max(PCs) #255

#Seating
seatNo <- df$Seating
minSeating <- min(seatNo) #4
maxSeating <- max(seatNo) #1423

#Hours open per week
hoursOpen <- df$Hours.Open.per.Week..Includes.Sundays.
minHours <- min(hoursOpen) #28
maxHours <- max(hoursOpen) #69

#Ward Region
regions <- df$Ward.Region

#Public Transit
publicTransit <- as.character(df$Public.Transit)

#Address
address <- df$Address

#Branch Name
branchName <- df$Branch.Name