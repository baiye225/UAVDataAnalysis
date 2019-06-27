% position analysis
% import desire figure eight flight path
% pi slice to split each segment
% plot figure eight, slice pi, and flight path in order to prove split 
% calculate position error of each segment

clc, clear, close all

% import the custom function from CodeBase
path(path,'..\CodeBase\'); 

%%%
% initial parameters

num               = struct('Vi', 1, 'WPi', 2, 'MRPHi', 2, 'FPi', 1);
                     % Vi    ["1.5", "2.5"]
                     % WPi   ["10", "15"]
                     % MRPHi ['0', '21', '27']
                     % FPi   ["normal", "oneside", "twoside"]
n = 3;               % pick flight in the current flight conditions (flight folder)
PathType = 'Normal'; % (eg: Normal, Dynamic)
%%%

% get the number of waypoints
Name = DatabaseManager('FlightParameters');
WP   = str2double(Name.wp(num.WPi));


% load data
POS          = LoadData('POS', num, n);                       % load raw data
IndexStruct  = IndexManager('Single', 'AllStartEnd', num);    % load index of AllStartEnd
CircleCenter = struct('Center1', [-5.2115, 0],...             % centers of two circles
                      'Center2', [5.2115, 0]);
                  
S            = FigureEight(WP, CircleCenter);                 % figure eight path
AllWPCircles = WPCircle(S);                                   % waypoints circle
SPi          = FigureEightSplitter(WP, CircleCenter);         % figure eight slice pi

                  
% pre process data (grab data from index)
GPS = PreProsData('AllStartEnd', POS, 'POS', IndexStruct, n);

% GPS -> 2d coordinate system
Position = GPS2POS([GPS.lat, GPS.lon]);

% calculate index of splitting segments
Index = GetSplitIndex(Position, SPi, CircleCenter);
               
% plot normal pos and splitter
PlotPosAnalysis(PathType, S, SPi, CircleCenter, Position, Index)                

% % calculate position error
PosError = GetPosError(Position, S, Index);


