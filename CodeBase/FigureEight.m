
% figure 8 flight path in mission planner

% use two circle to generate figure eight waypoints(meter)
% the center of figure eight is the mid point of two circles' center


function S = FigureEight(WP, CircleCenter)
% <input>
% WP: the number of waypoints of each circle
% <output>
% S:  figure eight waypoints [x, y, z] * N

% initialize parameters
R = 5;                        % radius
CircleCenter1     = CircleCenter.Center1; % first center of circle
CircleCenter2     = CircleCenter.Center2; % second center of circle
FigureEightCenter = [0, 0, 10];   % center of figure eight

% draw two circles respectively
S1 = DrawCircleWaypoints('Clockwise', CircleCenter1, R, 0, WP); 
S2 = DrawCircleWaypoints('CounterClockwise', CircleCenter2, R, -180, WP); 

% post process two circles
S1(1, :)   = FigureEightCenter;  % setup 1st and last point of S1
S1(end, :) = FigureEightCenter;

S2         = S2(2:end,:);        % delete the first point of the S2
                                 % which has overlapped the end point of the first circle
S2(end, :) = FigureEightCenter;  % setup last point of S2
  
% integrate waypoints of the two circles to figure eight     
S = [S1; S2]; 

% plot(S(:, 1),S(:, 2),'x-')
end






