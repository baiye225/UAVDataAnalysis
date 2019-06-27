% draw waypoint circle (1 meter radius circle at each waypoint)

function AllWPCircles = WPCircle(S)
% <input>
% S: figure eight waypoints

% delete first and last point (the center point appears three times)
S = S(2:end-1, 1:2);
n = size(S, 1);
    for i = 1:1:n
        AllWPCircles(i, 1) = DrawCircle(S(i, 1:2));
    end

end

% draw circle
function SCircle = DrawCircle(CircleCenter)
R = 1; % radius of the waypoints circle
n = 1;
ThetaGroup = linspace(0, 360, 36);
    for i = ThetaGroup
        theta = deg2rad(i);
        x = R * cos(theta) + CircleCenter(1);
        y = R * sin(theta) + CircleCenter(2);
        Circle(n, :) = [x, y];
        n = n + 1;
    end
    
    SCircle = struct('x', Circle(:, 1), 'y', Circle(:, 2));
end