
% figure 8 flight path in mission planner

% use two circle to generate figure eight waypoints(meter)
% the center of figure eight is the mid point of two circles' center


function S = FigureEight(Flightpath, WP, CircleCenter)
% <input>
% WP: the number of waypoints of each circle
% <output>
% S:  figure eight waypoints [x, y, z] * N

% initialize parameters
R = 5;                        % radius
CircleCenter1     = CircleCenter.Center1; % first center of circle
CircleCenter2     = CircleCenter.Center2; % second center of circle
FigureEightCenter = [0, 0];           % center of figure eight

% draw two circles respectively
S1 = DrawCircleWaypoints('Clockwise', CircleCenter1, R, 0, WP); 
S2 = DrawCircleWaypoints('CounterClockwise', CircleCenter2, R, -180, WP); 

% post process two circles (make them consecutive)
S1(1, :)   = FigureEightCenter;  % setup 1st and last point of S1
S1(end, :) = FigureEightCenter;

S2         = S2(2:end,:);        % delete the first point of the S2
                                 % which has overlapped the end point of the first circle
S2(end, :) = FigureEightCenter;  % setup last point of S2
  
% integrate waypoints of the two circles to figure eight     
S = [S1; S2]; 

% get altitude data
FlightAlt = FigureEightAlt(Flightpath, WP);

% integrate 3D waypoints of figure eight (normal, oneside, twoside)
S = [S, FlightAlt];

% plot3(S(:, 1),S(:, 2), S(:, 3), 'x-')
end

% generate altitude data of the figure eight path
function FlightAlt = FigureEightAlt(Flightpath, WP)
% initialize altitude margin
AltPeak   = 9; % (m)
AltMid    = 6;
AltValley = 3;

% choose altitude based on three type
    switch Flightpath
        case 'normal'
            FlightAlt = 6 * ones(WP * 2 + 1, 1);
        case 'oneside'
            FlightAlt = InclinedAltGenerator([AltMid, AltPeak], [AltPeak, AltMid],...
                                             [AltMid, AltValley], [AltValley, AltMid],... 
                                             WP);
        case 'twoside'
            FlightAlt = InclinedAltGenerator([AltMid, AltPeak], [AltPeak, AltMid],...
                                             [AltMid, AltPeak], [AltPeak, AltMid],... 
                                             WP);
    end
    
end

% generate inclined altitude data
function FlightAlt = InclinedAltGenerator(AltPoint1, AltPoint2, AltPoint3, AltPoint4, WP)
% <input>
% AltPoint: [StartAltitude, EndAltitude]
% <output>
% FlightAlt: consistant altitude data

% the number of altitude point in each part
PointNumber = ceil((WP + 1)/2);

Part1 = linspace(AltPoint1(1), AltPoint1(2), PointNumber); 
Part2 = linspace(AltPoint2(1), AltPoint2(2), PointNumber);
Part3 = linspace(AltPoint3(1), AltPoint3(2), PointNumber);
Part4 = linspace(AltPoint4(1), AltPoint4(2), PointNumber);

% integrate altitude path (make them consecutive)
    switch WP
        case 10
            FlightAlt = [Part1, Part2(2:end), Part3(2:end), Part4(2:end)];
        case 15
            FlightAlt = [Part1, Part2, Part3(2:end), Part4];
    end
    
% transpose FlightAlt (1*N -> N*1)
FlightAlt = FlightAlt';
end


