# Project The Effect of Renewable Energy sources on micro climates

### Introduction

Global energy demand is increasing, making renewable energy sources critical to future sustainable power supply. Land-based electricity generation plants base on wind and solar energy are rapidly expanding. The 75% of wind power capacity and 95% of solar power capacity are deployed only in the last 10 years. These plants are assumed to have little effect on the environment, although the understanding of their operational effects on local ecosystems is limited.

Wind turbines and photovoltaic panels can significantly change local ground-level climate by a magnitude that could affect the fundamental atmosphere-plant-soil processes. I believe that understanding the possible effects is crucial to understand the true renewable energy cost and to maximize beneficial effects.

This project is aiming to detect and predict the effects of the renewable energy sources, as well as suggest strategies to reduce the negative impact by studying multiple cases. I will be looking into renewable energy power plants around the world, and correlate its location and power outputs with the data on climate, atmospheric conditions, local weather, and vegetation, air quality and pollution levels. The resutls will be benefitical for the nation-wide planning where to locate renewable energy plants. It will also be important for individual that are installing renewable energy generators on their properties.

### Data sourses

* _GSOD database_ - daily global weather measurements accumulated in an integrated station history database. The data is accessible through R package 'GSODR'.

* _Google maps_ - satellite earth surface image data, accessible through R package 'ggmap'.

* _Monthly Electric Generator Inventory_ - data on current status of generating units at electric power plants with 1 MW or greated power capacity. Data provided by U.S. Energy Information Administration and downloaded online.


### Exploratory study of local climate for Alta Wind Energy Center wind farm

For the exploratory study I have selected the Alta Wind energy center (AWEC) as an example of the wind power plant, and demostrated its effect on the local climate. It is located in Tehachapi Pass in Kern county, California. The AWEC was first deployed in 2010 and as of 2013, it is the largest wind farm in the United States, with a combined installed capacity of 1,547 MW. It is also the third largest wind farm in the world. The location and the power capacity are fetched from the Electric Generator Inventory.

To access the microclimate in the vicinity of the power plant I used the data proviced in the GSOD database. I pulled the locations of the climate stations in the vicinity to the AWEC in two categories: stations within 20-km-radius from the plant and stations within 50-km-radius but beyond the 20-km-radius. The first group is denoted as "Local climate stations", it represents the trends in the climate immediately affected by the AWEC. The second group (20-50 km radius) is called "Regional climage stations", these stations are not affected as much as Local stations by wind turbines. The data provided by Regional stations will determine the general trends in climate changes in the area. The map with locations is displayed below.

![Map of the area around Alta Wind Energy center, California, US](fig1_MapAWEC.png) 

For exploratory purposes I estimated the average annual temperature during 2000-2018 detected by local stations and regional stations. This time period includes years before and after the power station deployment in 2010-2011. The average annual temperature for both groups is displayed on the graph below. The regional and local annual temperature readings correlate well from year to year, which confirms both parameters follow similar trends of regional variation. But in 2010-2011 there is a shart drop in average temperatures for local stations, while the regional stations annual temperaturse kept at the same level. The effect is very well defined and can be attributed to the deployment of the AWEC.

![Map of the area around Alta Wind Energy center, California, US](fig2_TempAWEC.png) 
