% initialize figure eight slice pi
% 1. two centers of slice pi are the same as the centers of figure eight waypoints flight path circle
% 2. the radius of slice pi is a little bit larger

function SPi = FigureEightSplitter(WP, CircleCenter)
% initialize parameters
R = 7;                                % radius
CircleCenter1 = CircleCenter.Center1; % first center of circle
CircleCenter2 = CircleCenter.Center2; % second center of circle

% draw two circles respectively
SPi1 = DrawCircleWaypoints('Clockwise', CircleCenter1, R, 0, WP); 
SPi2 = DrawCircleWaypoints('CounterClockwise', CircleCenter2, R, -180, WP); 

SPi = struct('SPi1', SPi1, 'SPi2', SPi2);
end
