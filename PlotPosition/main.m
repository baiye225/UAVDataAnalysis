clc, clear, close all
% plot all flight path in one figure (3D)

% import the custom function from CodeBase
path(path,'..\CodeBase\'); 
%%%
% initial parameters

num               = struct('Vi', 2, 'WPi', 1, 'MRPHi', 1, 'FPi', 1);
                    % Vi    ["1.5", "2.5"]
                    % WPi   ["10", "15"]
                    % FPi   ['0', '21', '27']
                    % MRPHi ["normal", "oneside", "twoside"]
%%%

% load all flight path
AllPOS = LoadAllPos(num);

% plot all flight path
PlotAllPos(AllPOS)