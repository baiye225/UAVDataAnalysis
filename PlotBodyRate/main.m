clc,clear,close all
% plot comparison of body axis rate in roll, pitch, and yaw

% import the custom function from CodeBase
path(path,'..\CodeBase\'); 

%%%
% initial parameters
num1     = struct('Vi', 1, 'WPi', 2, 'MRPHi', 2, 'FPi', 2); % import two kinds of morphing
num2     = struct('Vi', 1, 'WPi', 2, 'MRPHi', 3, 'FPi', 2);
n1 = 2; n2 = 2;
                % Vi    ["1.5", "2.5"]
                % WPi   ["10", "15"]
                % MRPHi ['0', '21', '27']
                % FPi["normal", "oneside", "twoside"]
                
DataType  = 'Yaw';  % choose the custom data (eg: Roll, Pitch, Yaw)
TimeShift = 2;      % zoom in time range (Time = TimeShift + MorphingTime + TimeShift)
%%%

% load index file
IndexStruct  = LoadTwoIndex(num1, num2);

% load two IMU (eg: flight conditions in num1 and num2, use first flight for both)
[IMU1, IMU2] = LoadTwoIMU('IMU', num1, num2, n1, n2);

% get plot data
[BodyRate, MorphingTime] = GetTwoPlotData(IMU1, IMU2, n1, n2, IndexStruct);
BodyRateZoom             = GetTwoPlotDataZoom(BodyRate, MorphingTime, TimeShift);

% plot two body rate
PlotTwoBodyRate(BodyRate, MorphingTime, DataType, 'Normal')
PlotTwoBodyRate(BodyRateZoom, MorphingTime, DataType, 'Zoom')

% get standard file name to save the figure conveniently
ResultName1 = DatabaseManager('DataGeneralName', num1, n1)
ResultName2 = DatabaseManager('DataGeneralName', num2, n2)


