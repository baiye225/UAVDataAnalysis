
% pre process position data (GPS ---> 2D coordinate system)
function result = GPS2POS(pos)
% <input>
% pos = [lat, lon] N*2
% <output>
% result = [x, y] N*2

% initialize original point (reference point)	
lat0 = 38.6355265; % use center of figure eight as the original point
lon0 = -90.2304305;

% transform GPS into 2d coordinate system (get x and y )
PosSize = size(pos,1); % data size of the position data
result = zeros(PosSize,2);
    for n = 1:1:PosSize
        lat1 = pos(n,1);
        lon1 = pos(n,2);
        [x, y] = SimpleDistance(lat1, lon1, lat0, lon0);
        result(n,[1,2]) = [x,y];
    end
end


% calculate distance of two parallel GPS points
function [x, y] = SimpleDistance(lat1, lon1, lat0, lon0)
% radian of the earth: 6371km
R         = 6371e3;                 % radius of earth
RLat      = R;                      % vertical radius (earth radius) of calculating latitude
RLon      = R * cos(lat0 * pi/180);  % horizontal circle radius of calculating longitude
LatDegree = lat1 - lat0;
LonDegree = lon1 - lon0;


% calculate distarnce and add (+/-) to the position data in 2D coordinate system
x = LonDegree * RLon * (pi/180); 
y = LatDegree * RLat * (pi/180); 
end

function d = StraightLine(x1, y1, x2, y2)
d = sqrt((x1 - x2)^2 + (y1 - y2)^2)/2;
end