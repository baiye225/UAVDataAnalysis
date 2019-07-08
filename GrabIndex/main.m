clc,clear,close all

% import the custom function from CodeBase
path(path,'..\CodeBase\'); 

%%%
% initial parameters
FlightType = 'LoiterTest'; % (eg: 'FigureEight', 'LoiterTest')
request    = 'MorphingStartEnd'; % (eg: 'AllStartEnd', 'MorphingStartEnd')

num               = struct('Vi', 1, 'WPi', 1, 'MRPHi', 1, 'FPi', 2);
                    % Vi    ["1.5", "2.5"]
                    % WPi   ["10", "15"]
                    % FPi   ['0', '21', '27']
                    % MRPHi ["normal", "oneside", "twoside"]
% loiter test: only change 'MRPHi', other parameter won't be used
%%%
                    
% get all index
Point             = DataFileIndexProcessing(FlightType, request, num);

