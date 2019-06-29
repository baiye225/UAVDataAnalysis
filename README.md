UAVDataAnalysis
==

This project is directionally used for processing figure eight flight, analyze flight performance between difference kinds of morphing. Moreover, it displays flight path for initial view and position error analysis.

Morphing quadcopter is a kind of new techique that quadcopter can change its' geometry and shrink the lateral size body in order to fly through some narrow channel or hall way which the same normal size quadcopter cannot access to.

All function is only for test with raw flight data and index data. The raw flight data and index data are used for upcoming journal and they cannot be pulished recently, but some sample result can be shown currently.

run main.m in each folder to process single experiment. 

run mainAll.m to process data of all flights <br>

![image](https://github.com/baiye225/UAVDataAnalysis/blob/master/Image/Code%20Diagram.jpg)


## Grab Index
The drone was taken off manually, and then executed autonomous flight by flipping a switch on the transmitter. After finishing designated flight path, the dron landed vertically. "Grab Index" helps to pick up the automonous flight and ignores manual flight and vertical landing according to heading and position of the drone. It also helps to grab the time period of morphing based on the designated servo data.
Finally, it generates mat file with index data

## PlotBodyRate
The drone's flight performance (angular rate) between each kind of morphing (morphing angle) can be used to analyze the effect of morphing numerically. By loading the flight data, index data, and calibrating the time (converse time unit and shift the data as a time reference), it displays comparison between two flights.

## PlotPosition
Plot all flights of one experiments (around 10 flights) together for general reviewing

## PositionAnalysis
It is reasonable to analyze flight performance of position by calculate mean square error of position error. To do so, it is necessary to split flight path data segment by segment according to figure eight waypoints. It introduces a method to split the flight path data, which is named "slice pi". Meanwhile, cross product of vector is helpful for splitting flight path to check it the current position data point is in the current "slice pi" (tri-angle) or not.
Finally, it generate mean square error of position at each segment, and mean value of whole flight can also be calculated.

## CodeBase
This is a class of pubilc code for each sub-project to share.
