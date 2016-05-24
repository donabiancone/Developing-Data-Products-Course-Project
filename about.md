## Toronto Public Library Branch Location

### About

This Shiny App is for searching and visualizing, on an interactive map, the information about Toronto Public Library branches located around the City. [Toronto Public Library Open Data site](http://opendata.tplcs.ca/) has released several datasets for public use.

### Data

I have used two different dataset: 

* [Branch Geolocations](http://www.torontopubliclibrary.ca/data/library-data.kml), that contains geolocations of all library branches with KML coordinates 
* [Branch Information](http://opendata.tplcs.ca/data/Branch_Information/Branch_Information.csv), that provides the locations of the existing library branches within the City of Toronto and branch profile information such as: City neighbourhood region, City Ward region, catchment population, hours open per week, collection size, # of parking spaces, # of seating, # of public PCs with Internet Access, approximate distance from branch to public transit, and so on.

### Leaflet

The app is based on `Leaflet`, one of the most popular open-source JavaScript libraries for interactive maps. More infomation and tutorials can be found here: [Leaflet for R](https://rstudio.github.io/leaflet/).

### Shiny App

From user interface of the app, it's possible specify different search criteria, such as: **Ward Region**, **Hours Open per Week**, **number of seating**, **number of public PCs with Internet Access**, **distance to public transit**. Results are visualize on the interactive map in the form of markers that indicate geolocation of the branch. Clicking on the marker, a popup will appear, with detailed information about the branch: **Name**, **address**, **telephone**, **collection size**, **public parking spaces**, and so on.
Moreover, aside the map, it is possible visualize dataset with results, and performs search on it.

Source code is available on [GitHub](https://github.com/donabiancone/Developing-Data-Products-Course-Project)

Presentation with description of the project is available on [RPubs](http://rpubs.com/donabiancone/TPL-BranchLocation)