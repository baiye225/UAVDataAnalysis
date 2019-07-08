
% draw circle waypoints
function S = DrawCircleWaypoints(direction, CircleCenter, R, StartTheta, WP)
% <input>
% direction:    direction of the waypoints path ('Clockwise' or 'Counterclockwise')
% CircleCenter: circle center coordinate (x, y)
% r:            radius of the circle
% StartTheta:   start point (denoted by theta) (degree)
% WP:           the number of the waypoints

% choose direction of rotation
    switch direction
        case 'Clockwise'
            ThetaGroup = linspace(StartTheta, StartTheta - 360, WP + 1);
        case 'CounterClockwise'
            ThetaGroup = linspace(StartTheta, StartTheta + 360, WP + 1);
    end
    
% initialize waypoint data and index
S = zeros(WP + 1, 2);
n = 1;

% draw circle waypoints
    for i = ThetaGroup
        theta = deg2rad(i);
        x = R * RoundThetaValue(cos(theta)) + CircleCenter(1);
        y = R * RoundThetaValue(sin(theta)) + CircleCenter(2);
        S(n, :) = [x, y];
        n = n + 1;
    end

end

% round sin(+/-pi) and cos(+/-(pi/2)) to zero to aviod tiny error of float calculation
function Result = RoundThetaValue(ThetaValue)
% <input>
% ThetaValue: (eg: sin(pi), cos(pi/3))
    if abs(ThetaValue) < 1e-4
        Result = 0;
    else
        Result = ThetaValue;
    end

end