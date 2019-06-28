This file is used for grabbing index of start and end point of figure 8 flights

run main.m for single experiment (around 10 flights of each flight condition)

run mainAll.m for 36 experiments

% edit the initial parameters for custom flight analysis
request:
'AllStartEnd'     ----> find start and end index of the whole autonomous figure 8 flight

To delete manual take off and autonomous vertical landing and get pure figure eight flight from center of the figure eight to center of the figure eight, the system grab the index of start point based on the "second heading angle" (the drone head to the second waypoint from the center of the figure eight), and grab the index of the end point based on the "final reaching point" (the position that the drone reaches to the last waypoint circle) 


'MorphingStartEnd' ----> find start and end index of the morphing part figure 8 flight

During the figure eight waypoint flight, the drone executes morphing and recover between two designated waypoints. The servo controll it and index of start morphing and end morphing can be found according to servo data.
