% plot 3D flight path
% figure1: 0, 21, 27 morphing of normal path
% figure2: 0, 21, 27 morphing of oneside path
% figure3: 0, 21, 27 morphing of twosides path

clc, clear, close all
% import the custom function from CodeBase
path(path,'..\CodeBase\'); 

%%%
%%%
% initialize three flights
NumAll  = struct('Vi', 2, 'WPi', 1,'FPi', 1);
               % Vi    ["1.5", "2.5"]
               % WPi   ["10", "15"]
               % MRPHi ['0', '21', '27']
               % FPi   ["normal", "oneside", "twoside"]
n1 = 1;
n2 = 4;
n3 = 4;
%%%
%%%

% integrate all num and n
num1 = NumAll; num2 = NumAll; num3 = NumAll;
num1.MRPHi = 1; num2.MRPHi = 2; num3.MRPHi = 3;
num  = struct('num1', num1, 'num2', num2, 'num3', num3);
               % Vi    ["1.5", "2.5"]
               % WPi   ["10", "15"]
               % MRPHi ['0', '21', '27']
               % FPi   ["normal", "oneside", "twoside"]

n  = struct('n1', n1, 'n2', n2, 'n3', n3);

% get the flight type
FlightType = 'FigureEight'; % (fixed value)

% get the number of waypoints
% get the number of waypoints and flight path
Name       = DatabaseManager('FlightParameters');
WP         = str2double(Name.wp(NumAll.WPi));
Flightpath = (Name.fp(NumAll.FPi));

% load data
POS          = ThreeLoadPOS(FlightType, num, n);               % load raw data
Index        = ThreeLoadIndex(FlightType, num);                % load index of AllStartEnd
CircleCenter = struct('Center1', [-5.2115, 0],...              % centers of two circles
                      'Center2', [5.2115, 0]);      
S            = FigureEight(Flightpath, WP, CircleCenter);      % figure eight path     

% pre process data (grab data from index)
Position = ThreePreProsData(FlightType, POS, Index, n);

% plot result
PlotPosMananger('FirgureSetup', '3D')
PlotPosMananger('Path', '3D', Position.Position1, 'b-')
PlotPosMananger('Path', '3D', Position.Position2, 'g-')
PlotPosMananger('Path', '3D', Position.Position3, 'c-')
PlotPosMananger('FigureEight', '3D', S)
legend('0^{\circ}', '21^{\circ}', '27^{\circ}', 'Desired path','Location', 'northeast')


% get standard file name to save the figure conveniently
disp(DatabaseManager('DataGeneralName', FlightType, num.num1, n.n1))
disp(DatabaseManager('DataGeneralName', FlightType, num.num2, n.n2))
disp(DatabaseManager('DataGeneralName', FlightType, num.num3, n.n2))


%%%
%%%
%%%
%%%
% function of processing three position data

% load three raw data
function POS = ThreeLoadPOS(FlightType, num, n)
% load data and calibrate alt
POS1 = LoadData('POS', FlightType, num.num1, n.n1); 
POS2 = LoadData('POS', FlightType, num.num2, n.n2); 
POS3 = LoadData('POS', FlightType, num.num3, n.n3);
POS1 = CalibrateAlt(POS1);
POS2 = CalibrateAlt(POS2);
POS3 = CalibrateAlt(POS3);
POS  = struct('POS1', POS1, 'POS2', POS2, 'POS3', POS3);
end

% load three idnex
function Index = ThreeLoadIndex(FlightType, num)

Index1 = IndexManager('Single', FlightType, 'AllStartEnd', num.num1);
Index2 = IndexManager('Single', FlightType, 'AllStartEnd', num.num2);
Index3 = IndexManager('Single', FlightType, 'AllStartEnd', num.num3);
Index  = struct('Index1', Index1, 'Index2', Index2, 'Index3', Index3);
end

% pre process three data and converse GPS to 2D coordinate
function Position = ThreePreProsData(FlightType, POS, Index, n)
GPS1 = PreProsData('AllStartEnd', FlightType, POS.POS1, 'POS', Index.Index1, n.n1);
GPS2 = PreProsData('AllStartEnd', FlightType, POS.POS2, 'POS', Index.Index2, n.n2);
GPS3 = PreProsData('AllStartEnd', FlightType, POS.POS3, 'POS', Index.Index3, n.n3);

% integrate position data [x, y, z]
Position1 = [GPS2POS([GPS1.lat, GPS1.lon]), GPS1.alt]; % add altitude data
Position2 = [GPS2POS([GPS2.lat, GPS2.lon]), GPS2.alt]; % add altitude data
Position3 = [GPS2POS([GPS3.lat, GPS3.lon]), GPS3.alt]; % add altitude data
Position  = struct('Position1', Position1, 'Position2', Position2, 'Position3', Position3);
end

% zerolize alt of POS
function POS = CalibrateAlt(POS)
% setup the first alt point is the ground
POS(:, 5) = POS(:, 5) - POS(1, 5);
end













