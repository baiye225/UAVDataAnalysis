This is a public code source which is shared by other sub-projects

`DatabaseManager.m` <br> 
It is a general manager for raw flight data, which helps the system to load specific data file and save the post processing result

`DrawCircleWaypoints.m` <br> 
Generate waypoint circle around each waypoint

`FigureEight.m` <br> 
Generate figure eight waypoint flight path based on the custom number of the waypoints

`FindIndex.m` <br> 
Find index of a data from the current time point (the closest index of time point based on the data).

`GPS2POS.m` <br> 
Converse GPS data (latitude, longitude) into normal 2D coordinate system and use a custom GPS point as the reference of original point

`IndexManager.m` <br> 
It is a general manager for load index from "GrabIndex"

`LoadData.m` <br> 
Load current data based on current num (experiment), n (data file) and data type (GPS, POS, etc)

`PreProsData.m` <br> 
1. grab the designated data from index (index of start to end)
2. grab the start and end morphing time (for "PlotBodyRate")

`SaveResult.m` <br> 
Save the result into ".mat" file based on current num (experiment) name.

`TimeCalibrater.m` <br> 
1. convert the time unit: us to s
2. zerolize the time: set the first time point as zero and calibrate the time as the reference of the first time point
